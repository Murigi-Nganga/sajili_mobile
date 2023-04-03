// Implements the decision whether to have the student/lecturer 'mode'
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class DecisionScreen extends StatelessWidget {
  const DecisionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Decision Screen',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.lecLoginRoute);
              },
              child: const Text('Lecturer'),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.studLoginRoute);
              },
              child: const Text('Student'),
            ),
          ],
        ),
      ),
    );
  }
}
