import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sajili_mobile/local_storage/local_storage.dart';
import 'package:sajili_mobile/models/schedule.dart';
import 'package:sajili_mobile/utils/attendance_utils.dart';
import 'package:timezone/standalone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'dart:async';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> setScheduleNotification({required Schedule schedule}) async {
  DateTime now = DateTime.now();

  //* 5 mins before the class begins
  DateTime notifDateTime = customTime(
    hour: schedule.startTime.hour,
    minute: schedule.startTime.minute,
    minToSubtract: 5,
  );

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
    priority: Priority.high,
    importance: Importance.high,
    timeoutAfter: 10 * 60 * 1000,
  );

  TZDateTime scheduledNotificationDateTime =
      tz.TZDateTime.from(notifDateTime, myLocation);

  //* Schedule the notification
  await flutterLocalNotificationsPlugin.zonedSchedule(
    schedule.id,
    '${schedule.subject.subjectCode} - ${schedule.subject.subjectName}',
    'Class will start at ${notifDateTime.hour}:${notifDateTime.minute} hrs\n'
        'Remember to record your check-ins to confirm \n'
        'your class attendance',
    scheduledNotificationDateTime,
    NotificationDetails(
      android: androidPlatformChannelSpecifics,
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    payload: 'Notification reminder for ${schedule.subject.subjectCode}',
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
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
