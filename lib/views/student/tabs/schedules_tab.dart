import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajili_mobile/controllers/schedule_controller.dart';
import 'package:sajili_mobile/models/schedule.dart';
import 'package:sajili_mobile/widgets/schedule_card.dart';

const _weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

class SchedulesScreen extends StatelessWidget {
  const SchedulesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedules'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<ScheduleController>(builder: (scheduleController) {
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
                      title: Text(
                        _weekdays[index],
                        style: TextStyle(
                          fontFamily: 'Gorodita',
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(.7),
                        ),
                      ),
                    ),
                    schedules.isEmpty
                        ? const ListTile(
                            title: Text(
                              'None',
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
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
              separatorBuilder: (context, index) => const Divider(color: Colors.black45),
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
      ),
    );
  }
}
