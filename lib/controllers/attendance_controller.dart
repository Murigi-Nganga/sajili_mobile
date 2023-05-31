import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
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
import 'package:sajili_mobile/utils/enums.dart';
import 'package:timezone/timezone.dart';

class AttendanceController extends GetxController with StateMixin<Attendance> {
  Rx<Map<String, dynamic>?> user = Rx({});

  @override
  onInit() async {
    super.onInit();
    change(state, status: RxStatus.empty());
    user(await LocalStorage().getUser());
  }

  Future<void> _submitAttendance(
      Schedule schedule, bool isPartial, String authMethod,
      {File? studImage}) async {
    change(null, status: RxStatus.loading());

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Endpoints.submitAttendanceUrl),
      )
        ..fields['student'] = (user.value!['appUser'] as Student).regNo
        ..fields['schedule'] = schedule.id.toString()
        ..fields['time_signed_in'] =
            TZDateTime.now(getLocation('Africa/Nairobi')).toString()
        ..fields['is_partial'] = isPartial.toString()
        ..fields['auth_method'] = authMethod;

      if (studImage != null) {
        var stream = http.ByteStream(studImage.openRead());
        var length = await studImage.length();

        var multipartFile = http.MultipartFile(
          'student_image',
          stream,
          length,
          filename: studImage.path.split('/').last,
        );
        request.files.add(multipartFile);
      }

      var response = await request.send();
      var responseBody = json.decode(await response.stream.bytesToString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        //TODO Check: Whether or not to have the mixin
        //: final Attendance attendance = Attendance.fromJson(responseBody);
        // LocalStorage().addAttendance(attendance);
        change(state, status: RxStatus.success());
        showSnack(
          'Success',
          'Attendance recorded successfully',
          Colors.green[400]!,
          Icons.error_rounded,
          1,
        );
      } else if (response.statusCode == 404 || response.statusCode == 406) {
        showSnack(
          'Error',
          responseBody['message'],
          Colors.red[400]!,
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
      change(state, status: RxStatus.success());
    } catch (error) {
      change(null, status: RxStatus.error(error.toString()));
      showSnack(
        'Error',
        error.toString(),
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
    } else if (numButtonTapped == 2) {
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
          } else {
            attTrack.btnTwoPressed = true;
            attTrack.btnTwoInLocation = isInAttLocation;
            await LocalStorage().addAttendanceTrack(
                scheduleId: schedule.id, attTrack: attTrack);
            showSnack(
              'Success',
              'Second check-in recorded successfully',
              Colors.green[400]!,
              Icons.grade_rounded,
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
    } else {
      //* The case where the button tapped is the third btn

      if (now.isAfter(customTime(
            hour: schedule.endTime.hour,
            minute: schedule.endTime.minute,
            minToSubtract: 5,
          )) &&
          now.isBefore(customTime(
            hour: schedule.endTime.hour,
            minute: schedule.endTime.minute,
            minToAdd: 5,
          ))) {
        if (attTrack != null) {
          attTrack.btnThreePressed = true;
          attTrack.btnThreeInLocation = isInAttLocation;
          await LocalStorage()
              .addAttendanceTrack(scheduleId: schedule.id, attTrack: attTrack);
          AttendanceType attType = getAttendanceType(attTrack);
          switch (attType) {
            case AttendanceType.partial:
              //* Register partial attendance
              authenticateWithBiometrics(schedule: schedule, isPartial: true);
              break;
            case AttendanceType.full:
              //* Register full attendance
              authenticateWithBiometrics(schedule: schedule);
              break;
            default:
              //* There is no attendance so display an error snack
              showSnack(
                'Error',
                'You do not meet the threshold to take attendance',
                Colors.red[400]!,
                Icons.running_with_errors_rounded,
                1,
              );
              return;
          }
        } else {
          AttendanceTrack newAttTrack = AttendanceTrack(
            btnThreePressed: true,
            btnThreeInLocation: isInAttLocation,
          );
          await LocalStorage().addAttendanceTrack(
              scheduleId: schedule.id, attTrack: newAttTrack);
          showSnack(
            'Error',
            'You do not meet the threshold to take attendance',
            Colors.red[400]!,
            Icons.running_with_errors_rounded,
            1,
          );
          return;
        }
      } else {
        showSnack(
          'Info',
          'Time for final check-in has passed',
          Colors.orange[400]!,
          Icons.info_rounded,
          1,
        );
      }
    }

    change(state, status: RxStatus.success());
  }

  Future<void> authenticateWithBiometrics(
      {required Schedule schedule, bool isPartial = false}) async {
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
            await _submitAttendance(
                schedule, isPartial, authMethods['localAuth']!);
          } else {
            showSnack(
              'Error',
              'Authentication failed',
              Colors.red[400]!,
              Icons.running_with_errors_rounded,
              1,
            );
            return;
          }
        } catch (e) {
          showSnack(
            'Error',
            'Could not do authentication'
                '${e.toString()}',
            Colors.red[400]!,
            Icons.running_with_errors_rounded,
            1,
          );
        }
      } else {
        showSnack(
          'Info',
          'Please enroll for biometrics on your phone',
          Colors.orange[400]!,
          Icons.info_rounded,
          1,
        );
        File studImage = await Get.toNamed(Routes.studImagePreviewRoute);
        await _submitAttendance(
          schedule,
          isPartial,
          authMethods['faceRecognitionService']!,
          studImage: studImage,
        );
      }
    } else {
      File studImage = await Get.toNamed(Routes.studImagePreviewRoute);
      await _submitAttendance(
        schedule,
        isPartial,
        authMethods['faceRecognitionService']!,
        studImage: studImage,
      );
    }
  }
}
