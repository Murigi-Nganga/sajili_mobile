import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sajili_mobile/controllers/attendance_controller.dart';
import 'package:sajili_mobile/models/schedule.dart';
import 'package:sajili_mobile/utils/attendance_utils.dart';

String getDayOfWeekString(int dayOfWeek) {
  List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];
  return daysOfWeek[dayOfWeek - 1];
}

Future<Position> getCurrentLocation() async =>
    await Geolocator.getCurrentPosition();

class StudAttendanceScreen extends StatefulWidget {
  const StudAttendanceScreen({super.key});

  @override
  State<StudAttendanceScreen> createState() => _StudAttendanceScreenState();
}

class _StudAttendanceScreenState extends State<StudAttendanceScreen> {

  @override
  Widget build(BuildContext context) {
    //* Receive argument for the schedule using GetX
    final Schedule schedule = Get.arguments['schedule'];
    final now = DateTime.now();

    final fiveMinBeforeStart = DateTime(
      now.year,
      now.month,
      now.day,
      schedule.startTime.hour,
      schedule.startTime.minute,
    ).subtract(const Duration(minutes: 5));

    final fiveMinAfterStart = DateTime(
      now.year,
      now.month,
      now.day,
      schedule.startTime.hour,
      schedule.startTime.minute,
    ).add(const Duration(minutes: 5));

    final thirtyMinAfterStart = DateTime(
      now.year,
      now.month,
      now.day,
      schedule.startTime.hour,
      schedule.startTime.minute,
    ).add(const Duration(minutes: 30));

    final fiveMinBeforeEnd = DateTime(
      now.year,
      now.month,
      now.day,
      schedule.endTime.hour,
      schedule.endTime.minute,
    ).subtract(const Duration(minutes: 5));

    final fiveMinAfterEnd = DateTime(
      now.year,
      now.month,
      now.day,
      schedule.endTime.hour,
      schedule.endTime.minute,
    ).add(const Duration(minutes: 5));

    final isScheduleTime = now.isAfter(fiveMinBeforeStart) &&
        now.isBefore(fiveMinAfterEnd) &&
        (getDayOfWeekString(now.weekday) == schedule.dayOfWeek);

    final isAfterFirstCheckIn = now.isAfter(fiveMinAfterStart);

    final isSecondCheckInPeriod =
        now.isAfter(thirtyMinAfterStart) && now.isBefore(fiveMinBeforeEnd);

    final isFinalCheckInPeriod =
        now.isAfter(fiveMinBeforeEnd) && now.isBefore(fiveMinAfterEnd);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Take attendance'),
        actions: [
          //TODO: Open a modal at the bottom to view the details of the lesson
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.info_rounded),
            ),
          ),
        ],
      ),
      body: isScheduleTime
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: schedule.isOnline
                    ? const Center(
                        child: Text('Class is online'),
                      )
                    : Column(
                        children: [
                          GetBuilder<AttendanceController>(
                              builder: (attController) {
                            return Column(
                              children: [
                                const Text(
                                  'Tap on the check-in buttons to track your attendance',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Gorodita',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 36, 58, 97),
                                  ),
                                ),
                                const SizedBox(height: 40),
                                const Text('Button can be tapped between'),
                                Text(
                                    '${padZeros(fiveMinBeforeStart.hour)}:${padZeros(fiveMinBeforeStart.minute)} - '
                                    '${padZeros(fiveMinAfterStart.hour)}:${padZeros(fiveMinAfterStart.minute)} hrs'),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: Get.mediaQuery.size.width * .8,
                                  child: ElevatedButton(
                                    onPressed: isAfterFirstCheckIn
                                        ? null
                                        : () async => await captureCheckIn(
                                            schedule: schedule,
                                            numButtonTapped: 1),
                                    child: const Text('First check-in'),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text('Button can be tapped between'),
                                Text(
                                    '${padZeros(thirtyMinAfterStart.hour)}:${padZeros(thirtyMinAfterStart.minute)} - '
                                    '${padZeros(fiveMinBeforeEnd.hour)}:${padZeros(fiveMinBeforeEnd.minute)} hrs'),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: Get.mediaQuery.size.width * .8,
                                  child: ElevatedButton(
                                    onPressed: isSecondCheckInPeriod
                                        ? () async => await captureCheckIn(
                                            schedule: schedule,
                                            numButtonTapped: 2)
                                        : null,
                                    child: const Text('Second check-in'),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                //TODO: Extract this button to a widget !!!
                                const Text('Button can be tapped between'),
                                Text(
                                    '${padZeros(fiveMinBeforeEnd.hour)}:${padZeros(fiveMinBeforeEnd.minute)} - '
                                    '${padZeros(fiveMinAfterEnd.hour)}:${padZeros(fiveMinAfterEnd.minute)} hrs'),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: Get.mediaQuery.size.width * .8,
                                  child: ElevatedButton(
                                    onPressed: isFinalCheckInPeriod
                                        ? () => takeAttendance(
                                              attController,
                                              schedule,
                                            )
                                        : null,
                                    child: const Text('Final check-in'),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
              ),
            )
          : const Text('Not time for the lesson'),
      floatingActionButton: isScheduleTime
          ? FloatingActionButton.extended(
              backgroundColor: const Color.fromARGB(255, 36, 58, 97),
              foregroundColor: Colors.white,
              onPressed: () => setState(() {}),
              label: const Text('Refresh'),
              icon: const Icon(Icons.refresh_rounded),
            )
          : null,
    );
  }
}
