import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajili_mobile/controllers/schedule_controller.dart';
import 'package:sajili_mobile/models/schedule.dart';
import 'package:sajili_mobile/widgets/schedule_card.dart';

const _weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: GetBuilder<ScheduleController>(builder: (scheduleController) {
        if (scheduleController.status.isSuccess) {
          return ListView.separated(
            itemBuilder: (context, index) {
              // Find the schedules for each day of the week
              List<Schedule> schedules = scheduleController.state!
                  .where((schedule) => schedule.dayOfWeek == _weekdays[index])
                  .toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(_weekdays[index]),
                  ),
                  schedules.isEmpty
                      ? const ListTile(
                          title: Text('None'),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            Schedule schedule = schedules[index];
                            return ScheduleCard(schedule: schedule);
                          },
                          itemCount: schedules.length,
                        ),
                ],
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: _weekdays.length,
          );
        } else if (scheduleController.status.isEmpty) {
          return const Center(child: Text('No Schedules found'));
        } else if (scheduleController.status.isError) {
          return const Center(child: Text('Could not fetch schedules'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
