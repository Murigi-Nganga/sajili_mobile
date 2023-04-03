import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sajili_mobile/constants/api_endpoints.dart';
import 'package:sajili_mobile/models/location.dart';
import 'package:sajili_mobile/utils/custom_snack.dart';

class LocationController extends GetxController
    with StateMixin<List<AttendanceLocation>> {
  @override
  onInit() async {
    super.onInit();
    getLocations();
  }

  Future<void> getLocations() async {
    change(null, status: RxStatus.loading());

    try {
      await http.get(Uri.parse(Endpoints.getLocationsUrl)).then((response) {
        final responseBody = json.decode(response.body);
        if (response.statusCode == 200) {
          final List<AttendanceLocation> locations = responseBody
              .map<AttendanceLocation>(
                  (obj) => AttendanceLocation.fromJson(obj))
              .toList();
          if (locations.isEmpty) {
            change(locations, status: RxStatus.empty());
            return;
          }
          change(locations, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.error('Something went wrong'));
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
