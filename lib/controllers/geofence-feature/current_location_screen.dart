import 'dart:async';
import 'dart:math' as math;

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import 'package:location/location.dart';
import 'package:sajili_mobile/controllers/gps_controller.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({Key? key}) : super(key: key);

  @override
  State<CurrentLocationScreen> createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  // Use controller to set location
  // final GPSController _gpsController = Get.find<GPSController>();

  final double _earthRadius = 6371000;

  double haversineDistance({
    required double lat1,
    required double lon1,
    required double lat2,
    required double lon2,
  }) {
    final double dLat = (lat2 - lat1) * math.pi / 180;
    final double dLon = (lon2 - lon1) * math.pi / 180;

    final double a = math.pow(math.sin(dLat / 2), 2) +
        math.cos(lat1 * math.pi / 180) *
            math.cos(lat2 * math.pi / 180) *
            math.pow(math.sin(dLon / 2), 2);

    final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return _earthRadius * c;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Location'),
      ),
      // body: 
      // Obx(
      //   () => SizedBox(
      //     child: _gpsController.location.value == null
      //         ? const CircularProgressIndicator()
      //         : Column(
      //             children: [
      //               Text(
      //                   'Longitude: ${_gpsController.location.value!.longitude}'),
      //               Text('Latitude:${_gpsController.location.value!.latitude}'),
      //               Text('${haversineDistance(
      //                 lat1: _gpsController.location.value!.latitude!,
      //                 lon1: _gpsController.location.value!.longitude!,
      //                 lat2: -1.2763522,
      //                 lon2: 36.7576156,
      //               )} meters')
      //               // isInsideGeofence
      //               //     ? const Text('You are inside the geofence')
      //               //     : const Text('You are outside the geofence')
      //             ],
      //           ),
      //   ),
      // ),
    );
  }
}