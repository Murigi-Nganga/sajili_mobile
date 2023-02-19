import 'package:get/get.dart';
import 'package:sajili_mobile/decision.dart';
import 'package:sajili_mobile/lecturer/views/auth/lec_login_screen.dart';
import 'package:sajili_mobile/lecturer/views/auth/lec_signup_screen.dart';
import 'package:sajili_mobile/lecturer/views/lec_home_screen.dart';
import 'package:sajili_mobile/student/views/auth/login/stud_login_screen.dart';
import 'package:sajili_mobile/student/views/auth/signup/signup_password_details.dart';
import 'package:sajili_mobile/student/views/auth/signup/stud_image_signup_screen.dart';
import 'package:sajili_mobile/student/views/auth/signup/stud_school_signup_screen.dart';
import 'package:sajili_mobile/student/views/auth/signup/stud_personal_signup_screen.dart';
import 'package:sajili_mobile/student/views/stud_home_screen.dart';
import 'package:sajili_mobile/student/views/stud_take_picture_screen.dart';

class Routes {
  // Decision route
  static const decisionRoute = '/decision';

  // Student routes
  static const studPersonalSignupRoute = '/student/signup/personal';
  static const studPasswordSignupRoute = '/student/signup/password';
  static const studSchoolSignupRoute = '/student/signup/school';
  static const studImageSignupRoute = '/student/signup/image';
  static const studLoginRoute = '/student/login';
  static const studTakePictureRoute = '/student/take-picture';
  static const studHomeRoute = '/student/home';

  // Lecturer routes
  static const lecSignupRoute = '/lecturer/signup';
  static const lecLoginRoute = '/lecturer/login';
  static const lecHomeRoute = '/lecturer/home';
}

final getPages = [
  GetPage(
    name: Routes.decisionRoute,
    page: () => const DecisionScreen(),
  ),

  // Student Pgaes
  GetPage(
    name: Routes.studPersonalSignupRoute,
    page: () => StudPersonalSignupScreen(),
  ),
  GetPage(
    name: Routes.studSchoolSignupRoute,
    page: () => StudSchoolSignupScreen(),
  ),
  GetPage(
    name: Routes.studPasswordSignupRoute,
    page: () => StudPasswordSignupScreen(),
  ),
  GetPage(
    name: Routes.studImageSignupRoute,
    page: () => StudImageSignupScreen(),
  ),
  GetPage(
    name: Routes.studLoginRoute,
    page: () => StudLoginScreen(),
  ),
  GetPage(
    name: Routes.studHomeRoute,
    page: () => const StudHomeScreen(),
  ),
  GetPage(
    name: Routes.studTakePictureRoute,
    page: () => const StudTakePictureScreen(),
  ),

  // Lecturer pages
  GetPage(
    name: Routes.lecSignupRoute,
    page: () => LecSignupScreen(),
  ),
  GetPage(
    name: Routes.lecLoginRoute,
    page: () => LecLoginScreen(),
  ),
  GetPage(
    name: Routes.lecHomeRoute,
    page: () => const LecHomeScreen(),
  ),
];
