import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sajili_mobile/bindings/initial_bindings.dart';
import 'package:sajili_mobile/local_storage/local_storage.dart';
import 'package:sajili_mobile/models/att_location.dart';
import 'package:sajili_mobile/models/att_track.dart';
import 'package:sajili_mobile/models/attendance.dart';
import 'package:sajili_mobile/models/latlng_adapter.dart';
import 'package:sajili_mobile/models/lecturer.dart';
import 'package:sajili_mobile/models/schedule.dart';
import 'package:sajili_mobile/models/student.dart';
import 'package:sajili_mobile/models/subject.dart';
import 'package:sajili_mobile/models/type_adapter.dart';
import 'package:sajili_mobile/routes/app_routes.dart';
import 'package:sajili_mobile/utils/app_theme.dart';
import 'package:sajili_mobile/utils/enums.dart';
import 'package:sajili_mobile/utils/permissions.dart';
import 'package:sajili_mobile/views/decision_screen.dart';
import 'package:sajili_mobile/views/lecturer/lec_home_screen.dart';
import 'package:sajili_mobile/views/student/stud_home_screen.dart';
import 'package:timezone/data/latest_all.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('mipmap/ic_launcher');

const InitializationSettings initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestPermissions();

  //* Initialize hive
  await Hive.initFlutter();

  //* Register adapters
  Hive.registerAdapter(UserTypeAdapter());
  Hive.registerAdapter(StudentAdapter());
  Hive.registerAdapter(LecturerAdapter());
  Hive.registerAdapter(AttendanceLocationAdapter());
  Hive.registerAdapter(SubjectAdapter());
  Hive.registerAdapter(ScheduleAdapter());
  Hive.registerAdapter(AttendanceAdapter());
  Hive.registerAdapter(AttendanceTrackAdapter());
  Hive.registerAdapter(TimeAdapter());
  Hive.registerAdapter(LatLngAdapter());

  //* Open hive boxes
  await Hive.openBox('user');
  await Hive.openBox<Schedule>('schedules');
  await Hive.openBox<Attendance>('attendances');
  await Hive.openBox<AttendanceTrack>('attendanceTracks');

  initializeTimeZones();

  //* Initialize local notifications plugin
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const MyApp());
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
                      '${snapshot.error.toString()} \n'
                      'Please contact your administrator',
                    ),
                  ),
                );
              }
            default:
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
