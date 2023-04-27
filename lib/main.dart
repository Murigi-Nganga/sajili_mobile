// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// // import 'package:hive_flutter/hive_flutter.dart';
// // import 'package:hive/hive.dart';

// import 'package:sajili_mobile/bindings/initial_bindings.dart';
// import 'package:sajili_mobile/routes/app_routes.dart';

// import 'utils/app_theme.dart';
// import 'views/decision.dart';

// // part 'location.g.dart';

// // @HiveType(typeId: 0)
// // class Location {
// //   @HiveField(0)
// //   double latitude;

// //   @HiveField(1)
// //   double longitude;

// //   @HiveField(2)
// //   DateTime time;

// //   Location(this.latitude, this.longitude, this.time);
// // }

// void periodicCallback() async {
//   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     'repeatDailyAtTime channel id',
//     'repeatDailyAtTime channel name',
//     channelDescription: 'repeatDailyAtTime description',
//     importance: Importance.max,
//     priority: Priority.high,
//     channelShowBadge: true,
//     channelAction: AndroidNotificationChannelAction.createIfNotExists,
//   );
//   const NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);
//   await flutterLocalNotificationsPlugin.show(
//     0,
//     'Periodic Notification',
//     'This notification will be shown periodically after 1 minute',
//     platformChannelSpecifics,
//     payload: 'test payload',
//   );
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // await Hive.initFlutter();
//   // Hive.registerAdapter(LocationAdapter());
//   // await AndroidAlarmManager.initialize();

//   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   await flutterLocalNotificationsPlugin.initialize(
//     const InitializationSettings(
//       android: AndroidInitializationSettings('mipmap/ic_launcher'),
//     ),
//   );
//   await AndroidAlarmManager.initialize();
//   await AndroidAlarmManager.periodic(
//     const Duration(minutes: 1),
//     0,
//     periodicCallback,
//     startAt: DateTime.now().add(const Duration(minutes: 1)),
//     exact: true,
//     wakeup: true,
//   );

//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialBinding: InitialBindings(),
//       defaultTransition: Transition.circularReveal,
//       transitionDuration: const Duration(milliseconds: 1500),
//       theme: appTheme,
//       getPages: getPages,
//       home: const DecisionScreen(),
//     );
//   }
// }

import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/standalone.dart';
import 'package:timezone/timezone.dart' as tz;

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
    "startTime": const Time(14, 47, 0),
    "endTime": const Time(12, 45, 0)
  },
  {
    "id": 2,
    "subject": "English",
    "startTime": const Time(14, 48, 0),
    "endTime": const Time(13, 0, 0)
  }
];

// Future<void> _showNotification() async {
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     'your channel id',
//     'your channel name',
//     channelDescription: 'your channel description',
//     importance: Importance.max,
//     priority: Priority.high,
//   );
//   const NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);
//   await flutterLocalNotificationsPlugin.show(
//     0,
//     'Notification title',
//     'Notification body',
//     platformChannelSpecifics,
//     payload: 'item x',
//   );
// }

Future<void> scheduleNotification(
    int notificationId, int startHour, int startMin) async {
  final myLocation = getLocation('Africa/Nairobi');
  // const android = AndroidNotificationDetails('id', 'channel ',
  //     channelDescription: 'description',
  //     priority: Priority.max,
  //     importance: Importance.max);
  var scheduledNotificationDateTime =
      tz.TZDateTime(myLocation, 2023, 4, 27, startHour, startMin-5);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    '$notificationId',
    'Channel $notificationId',
    channelDescription: 'channel description',
  );
  // const platformChannelSpecifics = NotificationDetails(android: android);

  await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      'Notification Number $notificationId',
      'Class will start at $startHour$startMin hrs',
      scheduledNotificationDateTime,
      NotificationDetails(
        android: androidPlatformChannelSpecifics,
      ),
      // androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  // tz.setLocalLocation(tz.getLocation('EAT'));
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
// await AndroidAlarmManager.initialize();
  await scheduleNotifications();

  runApp(const MyApp());
  // await AndroidAlarmManager.periodic(
  //   const Duration(minutes: 1), // change duration to your liking
  //   0, // id for your job
  //   _showNotification,
  //   exact: true,
  //   wakeup: true,
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
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

class _MyHomePageState extends State<MyHomePage> {
  final cron = Cron();

  ScheduledTask? scheduledTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Cron Job Example"),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {}, child: const Text("Show Notification")),
            ],
          ),
        ));
  }

  // void scheduleTask() async {
  //   scheduledTask = cron.schedule(Schedule.parse("* */1 * * * *"), () async {
  //     print("Executing task : " + DateTime.now().toString());
  //   });
  // }

  // void cancelTask() {
  //   scheduledTask!.cancel();
  // }
}
