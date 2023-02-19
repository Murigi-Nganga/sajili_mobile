import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajili_mobile/routes/app_routes.dart';

class LecHomeScreen extends StatelessWidget {
  const LecHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Home Screen'),
          ElevatedButton(
            onPressed: () => Get.offAllNamed(Routes.lecLoginRoute),
            child: const Text('LogOut'),
          ),
          TextButton.icon(
            onPressed: () => {},
            icon: const Icon(Icons.abc),
            label: const Text('My Text button'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}