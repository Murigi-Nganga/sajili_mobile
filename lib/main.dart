import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajili_mobile/bindings/initial_bindings.dart';
import 'package:sajili_mobile/routes/app_routes.dart';

import 'constants/app_theme.dart';
import 'views/decision.dart';

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
      initialBinding: InitialBindings(),
      theme: appTheme,
      getPages: getPages,
      home: const DecisionScreen(),
    );
  }
}
