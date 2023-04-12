import 'package:flutter/material.dart';
import 'package:sajili_mobile/models/schedule.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({Key? key, required this.schedule}) : super(key: key);

  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {},
        title: Text(schedule.subject.subjectCode),
        subtitle: Text(schedule.subject.subjectName),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${schedule.startTime.substring(0, 5)} hrs'),
            Text('${schedule.endTime.substring(0, 5)} hrs'),
          ],
        ),
      ),
    );
  }
}
