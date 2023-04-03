import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajili_mobile/routes/app_routes.dart';

class LecHomeScreen extends StatelessWidget {
  const LecHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Screen'),
            ElevatedButton(
              onPressed: () => Get.offAllNamed(Routes.lecLoginRoute),
              child: const Text('LogOut'),
            ),
          ],
        ),
      ),
    );
  }
}
