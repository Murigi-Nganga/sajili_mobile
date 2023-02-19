import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajili_mobile/bindings/controllers_binding.dart';
import 'package:sajili_mobile/decision.dart';
import 'package:sajili_mobile/lecturer/views/auth/lec_signup_screen.dart';
import 'package:sajili_mobile/routes/app_routes.dart';
import 'package:sajili_mobile/student/views/auth/signup/stud_personal_signup_screen.dart';
import 'constants/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: ControllersBinding(),
      theme: appTheme,
      getPages: getPages,
      home: StudPersonalSignupScreen(),
    );
  }
}
