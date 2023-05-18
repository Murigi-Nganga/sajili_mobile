import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sajili_mobile/local_storage/local_storage.dart';

import 'package:sajili_mobile/models/attendance.dart';
import 'package:sajili_mobile/models/schedule.dart';
import 'package:sajili_mobile/models/student.dart';
import 'package:sajili_mobile/utils/api_endpoints.dart';
import 'package:sajili_mobile/utils/custom_snack.dart';

class AttendanceController extends GetxController with StateMixin<Attendance> {
  Rx<Map<String, dynamic>?> user = Rx({});

  @override
  onInit() async {
    super.onInit();
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
}
