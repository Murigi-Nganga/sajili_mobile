import 'package:get/get.dart';
import 'package:sajili_mobile/geofence-feature/current_location_screen.dart';
import 'package:sajili_mobile/views/decision.dart';
import 'package:sajili_mobile/views/lecturer/lec_home_screen.dart';
import 'package:sajili_mobile/views/lecturer/lec_login_screen.dart';
import 'package:sajili_mobile/views/student/stud_home_screen.dart';
import 'package:sajili_mobile/views/student/stud_login_screen.dart';
import 'package:sajili_mobile/views/student/stud_take_picture_screen.dart';

class Routes {
  // Decision route
  static const decisionRoute = '/decision';

  // Student routes
  static const studLoginRoute = '/student/login';
  static const studTakePictureRoute = '/student/take-picture';
  static const studHomeRoute = '/student/home';
  static const currentLocationRoute = '/student/current-route';

  // Lecturer routes
  static const lecLoginRoute = '/lecturer/login';
  static const lecHomeRoute = '/lecturer/home';
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
    name: Routes.studTakePictureRoute,
    page: () => const StudTakePictureScreen(),
  ),
  GetPage(
    name: Routes.currentLocationRoute,
    page: () => const CurrentLocationScreen(),
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
];
