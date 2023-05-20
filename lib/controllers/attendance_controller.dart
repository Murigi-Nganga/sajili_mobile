import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:sajili_mobile/local_storage/local_storage.dart';
import 'package:sajili_mobile/models/att_track.dart';
import 'package:sajili_mobile/models/attendance.dart';
import 'package:sajili_mobile/models/schedule.dart';
import 'package:sajili_mobile/models/student.dart';
import 'package:sajili_mobile/routes/app_routes.dart';
import 'package:sajili_mobile/utils/api_endpoints.dart';
import 'package:sajili_mobile/utils/attendance_utils.dart';
import 'package:sajili_mobile/utils/custom_snack.dart';

class AttendanceController extends GetxController with StateMixin<Attendance> {
  Rx<Map<String, dynamic>?> user = Rx({});

  @override
  onInit() async {
    super.onInit();
    change(state, status: RxStatus.empty());
    user(await LocalStorage().getUser());
  }

  Future<void> submitAttendance(Schedule schedule) async {
    change(null, status: RxStatus.loading());

    try {
      final requestBody = {
        "student": (user.value!['appUser'] as Student).regNo,
        "schedule": schedule.id.toString()
      };

      await http
          .post(
        Uri.parse(Endpoints.submitAttendanceUrl),
        body: requestBody,
      )
          .then((response) {
        final responseBody = json.decode(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          final Attendance attendance = Attendance.fromJson(responseBody);
          LocalStorage().addAttendance(attendance);
          change(attendance, status: RxStatus.success());
          showSnack(
            'Success',
            'Attendance recorded successfully',
            Colors.green[400]!,
            Icons.error_rounded,
            1,
          );
        } else {
          change(null, status: RxStatus.error('Something went wrong'));
          showSnack(
            'Error',
            'Something went wrong',
            Colors.orange[400]!,
            Icons.error_rounded,
            1,
          );
        }
      });
    } catch (error) {
      change(null, status: RxStatus.error(error.toString()));
      showSnack(
        'Error',
        'Please check your network connection',
        Colors.red[400]!,
        Icons.error_rounded,
        1,
      );
    }
  }

  Future<void> captureCheckIn(
      {required Schedule schedule, required int numButtonTapped}) async {
    change(state, status: RxStatus.loading());

    DateTime now = DateTime.now();
    if (schedule.location.polygonPoints == null) {
      showSnack(
        'Error',
        'Attendance location not defined',
        Colors.red[400]!,
        Icons.running_with_errors_rounded,
        1,
      );
      change(state, status: RxStatus.success());
      return;
    }

    Position currentLocation = await getCurrentLocation();

    bool isInAttLocation = isPointInPolygon(
        LatLng(currentLocation.latitude, currentLocation.longitude),
        schedule.location.polygonPoints!);

    AttendanceTrack? attTrack =
        LocalStorage().getAttendanceTrack(scheduleId: schedule.id);

    if (numButtonTapped == 1) {
      if (now.isAfter(customTime(
            hour: schedule.startTime.hour,
            minute: schedule.startTime.minute,
            minToSubtract: 5,
          )) &&
          now.isBefore(customTime(
            hour: schedule.startTime.hour,
            minute: schedule.startTime.minute,
            minToAdd: 5,
          ))) {
        if (attTrack != null) {
          if (attTrack.btnOnePressed) {
            showSnack(
              'Info',
              'First check-in already recorded',
              Colors.orange[400]!,
              Icons.info_rounded,
              1,
            );
          }
        } else {
          AttendanceTrack newAttTrack = AttendanceTrack(
            btnOnePressed: true,
            btnOneInLocation: isInAttLocation,
          );
          await LocalStorage().addAttendanceTrack(
              scheduleId: schedule.id, attTrack: newAttTrack);
          showSnack(
            'Success',
            'First check-in recorded successfully',
            Colors.green[400]!,
            Icons.grade_rounded,
            1,
          );
        }
      } else {
        showSnack(
          'Info',
          'Time for first check-in has passed',
          Colors.orange[400]!,
          Icons.info_rounded,
          1,
        );
      }
    } else {
      //* The case where the button tapped is the second btn
      if (now.isAfter(customTime(
            hour: schedule.startTime.hour,
            minute: schedule.startTime.minute,
            minToAdd: 30,
          )) &&
          now.isBefore(customTime(
            hour: schedule.endTime.hour,
            minute: schedule.endTime.minute,
            minToSubtract: 5,
          ))) {
        if (attTrack != null) {
          if (attTrack.btnTwoPressed) {
            showSnack(
              'Info',
              'Second check-in already recorded',
              Colors.orange[400]!,
              Icons.info_rounded,
              1,
            );
          }
        } else {
          AttendanceTrack newAttTrack = AttendanceTrack(
            btnTwoPressed: true,
            btnTwoInLocation: isInAttLocation,
          );
          await LocalStorage().addAttendanceTrack(
              scheduleId: schedule.id, attTrack: newAttTrack);
          showSnack(
            'Success',
            'Second check-in recorded successfully',
            Colors.green[400]!,
            Icons.grade_rounded,
            1,
          );
        }
      } else {
        showSnack(
          'Info',
          'Time for second check-in has passed',
          Colors.orange[400]!,
          Icons.info_rounded,
          1,
        );
      }
    }
    change(state, status: RxStatus.success());
  }

  Future<void> takeAttendance(
      AttendanceController attController, Schedule schedule) async {
    //* Three cases:
    //? 1. Doesn't have biometrics
    //? 2. Has biometrics but not enrolled
    final LocalAuthentication auth = LocalAuthentication();

    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;

    if (canAuthenticateWithBiometrics) {
      final List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();

      if (availableBiometrics.isNotEmpty) {
        try {
          final bool didAuthenticate = await auth.authenticate(
            localizedReason: 'Please authenticate to sign your attendance',
            options: const AuthenticationOptions(
              biometricOnly: true,
              stickyAuth: true,
            ),
          );

          if (didAuthenticate) {
            attController.submitAttendance(
              schedule,
            );
          } else {
            showSnack(
            'Error',
            //? Check if device gives another chance / try-out
            'Authentication failed',
            Colors.red[400]!,
            Icons.running_with_errors_rounded,
            1,
          );
          }
        } catch (e) {
          showSnack(
            'Error',
            'Cannot do authentication'
                '${e.toString()}',
            Colors.red[400]!,
            Icons.running_with_errors_rounded,
            1,
          );
        }
      } else {
        showSnack(
          'Info',
          'Please enable biometrics on your phone',
          Colors.orange[400]!,
          Icons.info_rounded,
          1,
        );
      }
    } else {
      final result = await Get.toNamed(Routes.studTakePictureRoute);
      if(result == 'success') {
        //? Show success snack
      } else {
        //? Show 'failed' snack
      }  
    }
  }
}
