import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajili_mobile/local_storage/local_storage.dart';
import 'package:sajili_mobile/models/schedule.dart';
import 'package:sajili_mobile/routes/app_routes.dart';
import 'package:sajili_mobile/utils/attendance_utils.dart' show padZeros;
import 'package:sajili_mobile/utils/enums.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({Key? key, required this.schedule}) : super(key: key);

  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    String startHour = padZeros(schedule.startTime.hour);
    String startMinute = padZeros(schedule.startTime.minute);
    String endHour = padZeros(schedule.endTime.hour);
    String endMinute = padZeros(schedule.endTime.minute);

    return FutureBuilder(
      future: LocalStorage().getUser(),
      builder: ((context, snapshot) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Colors.indigo,
                Color.fromARGB(255, 36, 58, 97),
              ],
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.transparent,
              width: 2,
            ),
          ),
          child: ListTile(
            textColor: Colors.white,
            onTap: () {
              snapshot.data!['userType'] == UserType.lecturer
                  ? Get.toNamed(Routes.lecScheduleRoute)
                  : Get.toNamed(
                      Routes.studAttendanceRoute,
                      arguments: {"schedule": schedule},
                    );
            },
            title: Text(schedule.subject.subjectCode),
            subtitle: Text(schedule.subject.subjectName),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$startHour:$startMinute hrs'),
                Text('$endHour:$endMinute hrs'),
              ],
            ),
          ),
        );
      }),
    );
  }
}
