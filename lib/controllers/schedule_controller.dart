import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sajili_mobile/constants/api_endpoints.dart';
import 'package:sajili_mobile/models/schedule.dart';
import 'package:sajili_mobile/utils/custom_snack.dart';

class ScheduleController extends GetxController
    with StateMixin<List<Schedule>> {
  @override
  onInit() async {
    super.onInit();
    getSchedules();
  }

  Future<void> getSchedules() async {
    change(null, status: RxStatus.loading());

    try {
      await http.get(Uri.parse(Endpoints.getSchedulesByLecId)).then((response) {
        final responseBody = json.decode(response.body);
        if (response.statusCode == 200) {
          final List<Schedule> schedules = responseBody
              .map<Schedule>((obj) => Schedule.fromJson(obj))
              .toList();
          if (schedules.isEmpty) {
            change(schedules, status: RxStatus.empty());
            return;
          }
          change(schedules, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.error('Something went wrong'));
        }
      });
    } catch (error) {
      print('ERROR $error');
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
