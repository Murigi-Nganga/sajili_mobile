import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sajili_mobile/local_storage/local_storage.dart';
import 'package:sajili_mobile/models/schedule.dart';
import 'package:timezone/standalone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'dart:async';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

int convertTimeToMin(int hour, int min) => hour * 60 + min;

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

Time getMidTime({required Time startTime, required Time endTime}) {
  int startTimeInMin = convertTimeToMin(startTime.hour, startTime.minute);
  int endTimeInMin = convertTimeToMin(endTime.hour, endTime.minute);

  int diffInMinutes = endTimeInMin - startTimeInMin;
  int minutesToAdd = diffInMinutes ~/ 2;

  int midTimeInMin = startTimeInMin + minutesToAdd;

  return Time(midTimeInMin ~/ 60, midTimeInMin % 60);
}

Future<void> setScheduleNotification({required Schedule schedule}) async {
  DateTime now = DateTime.now();
  DateTime notifDateTime = DateTime(now.year, now.month, now.day,
          schedule.startTime.hour, schedule.startTime.minute)
      .subtract(const Duration(minutes: 5));

  //* If notification time is earlier than now, don't set notification
  if (now.isAfter(notifDateTime)) return;

  //* Set location and timezone
  final myLocation = getLocation('Africa/Nairobi');

  //* Define notification details
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'Channel ${schedule.id}',
    'Class Reminders',
    channelDescription: 'Notifications to remind students to attend classes',
    priority: Priority.max,
    importance: Importance.max,
    colorized: true,
    timeoutAfter: 10 * 60 * 1000,
  );

  TZDateTime scheduledNotificationDateTime =
      tz.TZDateTime.from(notifDateTime, myLocation);

  //* Schedule the notification
  await flutterLocalNotificationsPlugin.zonedSchedule(
    schedule.id,
    '${schedule.subject.subjectCode} - ${schedule.subject.subjectName}',
    'Class will start at ${notifDateTime.hour}:${notifDateTime.minute} hrs\n'
        // 'Remember to take your check-ins for the class'
        ,
    scheduledNotificationDateTime,
    NotificationDetails(
      android: androidPlatformChannelSpecifics,
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    payload: 'Notification reminder for ${schedule.subject.subjectCode}',
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );

  // await flutterLocalNotificationsPlugin.zonedSchedule(
  //   schedule.id + 1000,
  //   '${schedule.subject.subjectCode} - ${schedule.subject.subjectName}',
  //   'Remember to take your second check-in for the class',
  //   scheduledNotificationDateTime.add(const Duration(minutes: 2)),
  //   NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //   ),
  //   androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //   payload: 'Notification reminder for ${schedule.subject.subjectCode}',
  //   uiLocalNotificationDateInterpretation:
  //       UILocalNotificationDateInterpretation.absoluteTime,
  // );
}

Future<void> setNotifications() async {
  DateTime now = DateTime.now();

  //* Fetch all schedules from the hive box
  List<Schedule> schedules = LocalStorage().getSchedules();

  if (schedules.isEmpty) return;

  for (Schedule schedule in schedules) {
    String dayOfWeek = schedule.dayOfWeek;

    if (dayOfWeek == getDayOfWeekString(now.weekday)) {
      await setScheduleNotification(schedule: schedule);
    }
  }
}
