import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajili_mobile/controllers/attendance_controller.dart';
import 'package:sajili_mobile/models/schedule.dart';
import 'package:sajili_mobile/utils/attendance_utils.dart';
import 'package:sajili_mobile/widgets/checkin_widget.dart';

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

    final fiveMinBeforeStart = customTime(
      hour: schedule.startTime.hour,
      minute: schedule.startTime.minute,
      minToSubtract: 5,
    );

    final fiveMinAfterStart = customTime(
      hour: schedule.startTime.hour,
      minute: schedule.startTime.minute,
      minToAdd: 5,
    );

    final thirtyMinAfterStart = customTime(
      hour: schedule.startTime.hour,
      minute: schedule.startTime.minute,
      minToAdd: 30,
    );

    final fiveMinBeforeEnd = customTime(
      hour: schedule.endTime.hour,
      minute: schedule.endTime.minute,
      minToSubtract: 5,
    );

    final fiveMinAfterEnd = customTime(
      hour: schedule.endTime.hour,
      minute: schedule.endTime.minute,
      minToAdd: 5,
    );

    final isScheduleTime = now.isAfter(fiveMinBeforeStart) &&
        now.isBefore(fiveMinAfterEnd) &&
        (getDayOfWeekString(now.weekday) == schedule.dayOfWeek);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Take attendance'),
        actions: [
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
                            return attController.status.isLoading
                                //TODO: Use a different widget here
                                ? const CircularProgressIndicator()
                                : Column(
                                    children: [
                                      const Text(
                                        'Tap on the check-in buttons to track your attendance',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Gorodita',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 36, 58, 97),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      CheckinWidget(
                                        buttonText: 'First check-in',
                                        lowerTimeBound: fiveMinBeforeStart,
                                        upperTimeBound: fiveMinAfterStart,
                                        onPressed: () async =>
                                            await attController.captureCheckIn(
                                          schedule: schedule,
                                          numButtonTapped: 1,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      CheckinWidget(
                                        buttonText: 'Second check-in',
                                        lowerTimeBound: thirtyMinAfterStart,
                                        upperTimeBound: fiveMinBeforeEnd,
                                        onPressed: () async =>
                                            await attController.captureCheckIn(
                                          schedule: schedule,
                                          numButtonTapped: 2,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      CheckinWidget(
                                        buttonText: 'Final check-in',
                                        lowerTimeBound: fiveMinBeforeEnd,
                                        upperTimeBound: fiveMinAfterEnd,
                                        onPressed: () async =>
                                            attController.captureCheckIn(
                                          schedule: schedule,
                                          numButtonTapped: 3,
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
