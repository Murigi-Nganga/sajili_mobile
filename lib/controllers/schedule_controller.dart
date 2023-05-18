import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sajili_mobile/local_storage/local_storage.dart';
import 'package:sajili_mobile/utils/api_endpoints.dart';
import 'package:sajili_mobile/models/schedule.dart';
import 'package:sajili_mobile/utils/custom_snack.dart';
import 'package:sajili_mobile/utils/enums.dart';
import 'package:sajili_mobile/utils/notifications.dart';

class ScheduleController extends GetxController
    with StateMixin<List<Schedule>> {
  Rx<Map<String, dynamic>?> user = Rx({});

  @override
  onInit() async {
    super.onInit();

    user(await LocalStorage().getUser());

    if (user.value != null) {
      if (user.value!['userType'] == UserType.lecturer) {
        await getSchedulesByLecId();
      } else {
        await getSchedulesByYear();
        //* Set app notifications
        await setNotifications();
      }
    }
  }

  Future<void> getSchedulesByLecId() async {
    change(null, status: RxStatus.loading());

    try {
      await http
          .get(Uri.parse(
              "${Endpoints.getSchedulesByLecId}/${user.value!['appUser'].id}"))
          .then((response) {
        final responseBody = json.decode(response.body);
        if (response.statusCode == 200) {
          final List<Schedule> schedules = responseBody
              .map<Schedule>((obj) => Schedule.fromJson(obj))
              .toList();
          LocalStorage().persistSchedules(schedules);
          if (schedules.isEmpty) {
            change(schedules, status: RxStatus.empty());
            return;
          }
          change(schedules, status: RxStatus.success());
        } else {
          LocalStorage().persistSchedules([]);
          change(null, status: RxStatus.error('Something went wrong'));
        }
      });
    } catch (error) {
      LocalStorage().persistSchedules([]);
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

  Future<void> getSchedulesByYear() async {
    change(null, status: RxStatus.loading());

    try {
      await http
          .get(Uri.parse(
              "${Endpoints.getSchedulesByYear}/${user.value!['appUser'].yearOfStudy}"))
          .then((response) {
        final responseBody = json.decode(response.body);
        if (response.statusCode == 200) {
          final List<Schedule> schedules = responseBody
              .map<Schedule>((obj) => Schedule.fromJson(obj))
              .toList();
          print(schedules[0].endTime.runtimeType);
          LocalStorage().persistSchedules(schedules);
          if (schedules.isEmpty) {
            change(schedules, status: RxStatus.empty());
            return;
          }
          change(schedules, status: RxStatus.success());
        } else {
          LocalStorage().persistSchedules([]);
          change(null, status: RxStatus.error('Something went wrong'));
        }
      });
    } catch (error) {
      LocalStorage().persistSchedules([]);
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
