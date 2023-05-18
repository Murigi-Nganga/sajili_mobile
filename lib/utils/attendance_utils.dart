import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sajili_mobile/controllers/attendance_controller.dart';
import 'package:sajili_mobile/local_storage/local_storage.dart';
import 'package:sajili_mobile/models/att_track.dart';
import 'package:sajili_mobile/models/schedule.dart';
import 'package:sajili_mobile/utils/custom_snack.dart';
import 'package:sajili_mobile/views/student/stud_attendance_screen.dart';

String padZeros(int value) => value < 10 ? '0$value' : value.toString();

DateTime customTime({
  required int hour,
  required int minute,
  int minToSubtract = 0,
  int minToAdd = 0,
}) {
  assert(minToAdd >= 0, "minToAdd must be greater than or equal to 0");
  assert(
      minToSubtract >= 0, "minToSubtract must be greater than or equal to 0");
  assert(minToAdd > 1 && minToSubtract < 1 || minToAdd < 1 && minToSubtract > 1,
      "Either minToAdd or minToSubtract can be greater than 0");

  DateTime now = DateTime.now();
  if (minToAdd > 0) {
    return DateTime(now.year, now.month, now.day, hour, minute)
        .add(Duration(minutes: minToAdd));
  }
  if (minToSubtract > 0) {
    return DateTime(now.year, now.month, now.day, hour, minute)
        .subtract(Duration(minutes: minToSubtract));
  }
  return DateTime(now.year, now.month, now.day, hour, minute);
}

//* The point-in-polygon algorithm
bool _isPointInPolygon(LatLng point, List<LatLng> polygon) {
  bool isInside = false;

  int numVertices = polygon.length;
  int j = numVertices - 1;

  for (int i = 0; i < numVertices; i++) {
    LatLng vertexI = polygon[i];
    LatLng vertexJ = polygon[j];

    //* Check if point is on edge of polygon
    if ((vertexI.longitude == point.longitude &&
            vertexI.latitude == point.latitude) ||
        (vertexJ.longitude == point.longitude &&
            vertexJ.latitude == point.latitude)) {
      return true;
    }

    //* Check if point is between vertices
    if ((vertexI.latitude < point.latitude &&
            vertexJ.latitude >= point.latitude) ||
        (vertexJ.latitude < point.latitude &&
            vertexI.latitude >= point.latitude)) {
      if (vertexI.longitude +
              (point.latitude - vertexI.latitude) /
                  (vertexJ.latitude - vertexI.latitude) *
                  (vertexJ.longitude - vertexI.longitude) <
          point.longitude) {
        isInside = !isInside;
      }
    }

    j = i;
  }

  return isInside;
}

void takeAttendance(
    AttendanceController attController, Schedule schedule) async {
  final LocalAuthentication auth = LocalAuthentication();

  final bool canAuthenticateWithBiometrics =
      await auth.canCheckBiometrics || await auth.isDeviceSupported();

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
        }
      } on PlatformException catch (e) {
        print(e.toString());
      }
    }
  }
}

Future<void> captureCheckIn(
    {required Schedule schedule, required int numButtonTapped}) async {
  DateTime now = DateTime.now();
  if (schedule.location.polygonPoints == null) {
    showSnack(
      'Error',
      'Attendance Location not defined',
      Colors.red[400]!,
      Icons.running_with_errors_rounded,
      1,
    );
    return;
  }

  Position currentLocation = await getCurrentLocation();

  bool isInAttLocation = _isPointInPolygon(
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
            0,
          );
          print(attTrack.toJson());
        }
      } else {
        AttendanceTrack newAttTrack = AttendanceTrack(
          btnOnePressed: true,
          btnOneInLocation: isInAttLocation,
        );
        await LocalStorage()
            .addAttendanceTrack(scheduleId: schedule.id, attTrack: newAttTrack);

        //? Check if the change has been made
        print(LocalStorage().getAttendanceTrack(scheduleId: schedule.id));
      }
    } else {
      showSnack(
        'Info',
        'Time for first check-in has passed',
        Colors.orange[400]!,
        Icons.info_rounded,
        0,
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
          minToAdd: 5,
        ))) {
      if (attTrack != null) {
        if (attTrack.btnTwoPressed) {
          showSnack(
            'Info',
            'Second check-in already recorded',
            Colors.orange[400]!,
            Icons.info_rounded,
            0,
          );
        }
      } else {
        attTrack!.btnTwoPressed = true;
        attTrack.btnTwoInLocation = isInAttLocation;
        await LocalStorage()
            .addAttendanceTrack(scheduleId: schedule.id, attTrack: attTrack);

        //? Check if the change has been made
        print(LocalStorage().getAttendanceTrack(scheduleId: schedule.id));
      }
    } else {
      showSnack(
        'Info',
        'Time for first check-in has passed',
        Colors.orange[400]!,
        Icons.info_rounded,
        0,
      );
    }
  }
}
