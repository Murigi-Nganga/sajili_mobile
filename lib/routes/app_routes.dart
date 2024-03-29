import 'package:get/get.dart';
import 'package:sajili_mobile/views/decision_screen.dart';
import 'package:sajili_mobile/views/lecturer/lec_home_screen.dart';
import 'package:sajili_mobile/views/lecturer/lec_login_screen.dart';
import 'package:sajili_mobile/views/lecturer/lec_schedule_screen.dart';
import 'package:sajili_mobile/views/student/stud_attendance_screen.dart';
import 'package:sajili_mobile/views/student/stud_home_screen.dart';
import 'package:sajili_mobile/views/student/stud_image_preview_screen.dart';
import 'package:sajili_mobile/views/student/stud_login_screen.dart';
import 'package:sajili_mobile/views/student/stud_take_picture_screen.dart';

class Routes {
  // Decision route
  static const decisionRoute = '/decision';

  // Student routes
  static const studLoginRoute = '/student/login';
  static const studTakePictureRoute = '/student/take-picture';
  static const studImagePreviewRoute = '/student/image-preview';
  static const studAttendanceRoute = '/student/take-attendance';
  static const studHomeRoute = '/student/home';

  // Lecturer routes
  static const lecLoginRoute = '/lecturer/login';
  static const lecHomeRoute = '/lecturer/home';
  static const lecScheduleRoute = '/lecturer/edit-schedule';
}

final getPages = [
  GetPage(
    name: Routes.decisionRoute,
    page: () => const DecisionScreen(),
  ),

  // Student Pages
  GetPage(
    name: Routes.studLoginRoute,
    page: () => StudLoginScreen(),
  ),
  GetPage(
    name: Routes.studHomeRoute,
    page: () => StudHomeScreen(),
  ),
  GetPage(
    name: Routes.studAttendanceRoute,
    page: () => const StudAttendanceScreen(),
  ),
  GetPage(
    name: Routes.studTakePictureRoute,
    page: () => const StudTakePictureScreen(),
  ),
  GetPage(
    name: Routes.studImagePreviewRoute,
    page: () => const StudImagePreviewScreen(),
  ),
  
  // Lecturer pages
  GetPage(
    name: Routes.lecLoginRoute,
    page: () => LecLoginScreen(),
  ),
  GetPage(
    name: Routes.lecHomeRoute,
    page: () => LecHomeScreen(),
  ),
   GetPage(
    name: Routes.lecScheduleRoute,
    page: () => const LecScheduleScreen(),
  ),
];
