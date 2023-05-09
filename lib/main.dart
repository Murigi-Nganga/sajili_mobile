import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sajili_mobile/bindings/initial_bindings.dart';
import 'package:sajili_mobile/local_storage/local_storage.dart';
import 'package:sajili_mobile/models/att_location.dart';
import 'package:sajili_mobile/models/lecturer.dart';
import 'package:sajili_mobile/models/schedule.dart';
import 'package:sajili_mobile/models/student.dart';
import 'package:sajili_mobile/models/subject.dart';
import 'package:sajili_mobile/routes/app_routes.dart';
import 'package:sajili_mobile/utils/app_theme.dart';
import 'package:sajili_mobile/utils/enums.dart';
import 'package:sajili_mobile/views/decision_screen.dart';
import 'package:sajili_mobile/views/lecturer/lec_home_screen.dart';
import 'package:sajili_mobile/views/student/stud_home_screen.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/standalone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('mipmap/ic_launcher');

const InitializationSettings initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
);

List<Map<String, dynamic>> mySchedules = [
  {
    "id": 1,
    "subject": "Maths",
    "startTime": const Time(16, 53, 0),
    "endTime": const Time(12, 45, 0)
  },
  {
    "id": 2,
    "subject": "English",
    "startTime": const Time(16, 54, 0),
    "endTime": const Time(13, 0, 0)
  }
];

Future<void> scheduleNotification(
    int notificationId, int startHour, int startMin) async {
  final myLocation = getLocation('Africa/Nairobi');
  // const android = AndroidNotificationDetails('id', 'channel ',
  //     channelDescription: 'description',
  //     priority: Priority.max,
  //     importance: Importance.max);
  var scheduledNotificationDateTime =
      tz.TZDateTime(myLocation, 2023, 4, 27, startHour, startMin - 5);
  const androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'Class Reminders',
    'Class Reminders',
    channelDescription: 'Notifications to remind students of upcoming classes',
  );
  // const platformChannelSpecifics = NotificationDetails(android: android);

  await flutterLocalNotificationsPlugin.zonedSchedule(
    notificationId,
    'Lesson $notificationId',
    'Class will start at $startHour$startMin hrs',
    scheduledNotificationDateTime,
    const NotificationDetails(
      android: androidPlatformChannelSpecifics,
    ),
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}

Future<void> scheduleNotifications() async {
  for (Map<String, dynamic> schedule in mySchedules) {
    //TODO: To check if the time is before/after NOW
    await scheduleNotification(
        schedule['id'],
        (schedule['startTime'] as Time).hour,
        (schedule['startTime'] as Time).minute);
  }
}

void printHello() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  print(
      'LAT: ${position.latitude}, LON: ${position.longitude}, TIMESTAMP: ${position.timestamp}');
  print(Geolocator.distanceBetween(
      -1.276485, 36.75734, position.latitude, position.longitude));

  // print(Geolocator.distanceBetween(, position.latitude, position.longitude));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //* Request for permissions if not granted
  await [
    Permission.location,
  ].request();

  //* Initialize hive
  await Hive.initFlutter();

  //* Register adapters
   Hive.registerAdapter(UserTypeAdapter());
  Hive.registerAdapter(StudentAdapter());
  Hive.registerAdapter(LecturerAdapter());
  Hive.registerAdapter(AttendanceLocationAdapter());
  Hive.registerAdapter(SubjectAdapter());
  Hive.registerAdapter(ScheduleAdapter());

  //* Open boxes
  await Hive.openBox('user');
  await Hive.openBox<Schedule>('schedules');

  tz.initializeTimeZones();

  //* Initialize android alarm manager
  await AndroidAlarmManager.initialize();

  //* Initialize local notifs plugin
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  //TODO: Uncomment scheduling notifications
  //* Schedule notifications
  // await scheduleNotifications();

  runApp(const MyApp());

  await AndroidAlarmManager.periodic(const Duration(seconds: 30), 1, printHello,
      exact: true, allowWhileIdle: true
      // startAt: DateTime(2023, 4, 28, 11, 31),
      );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: LocalStorage().getUser(),
        builder: ((context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (!snapshot.hasError) {
                if (snapshot.data == null) {
                  return const DecisionScreen();
                } else {
                  if (snapshot.data!['userType'] == UserType.lecturer) {
                    return LecHomeScreen();
                  } else {
                    return StudHomeScreen();
                  }
                }
              } else {
                return Scaffold(
                  body: Center(
                    child: Text(
                      snapshot.error.toString(),
                    ),
                  ),
                );
              }
            default:
              //TODO: Return a more interesting widget for this
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
          }
        }),
      ),
      getPages: getPages,
      theme: appTheme,
      defaultTransition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 2500),
      initialBinding: InitialBindings(),
    );
  }
}

showNotification() async {
  const android = AndroidNotificationDetails('id', 'channel ',
      channelDescription: 'description',
      priority: Priority.max,
      importance: Importance.max);
  const platform = NotificationDetails(android: android);
  await flutterLocalNotificationsPlugin.show(
      0, 'Flutter devs', 'Flutter Local Notification Demo', platform,
      payload: 'Welcome to the Local Notification demo');
}
