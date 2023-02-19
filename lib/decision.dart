// Implements the decision whether to have the student/lecturer 'mode'

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajili_mobile/routes/app_routes.dart';

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
      body: Center(
        child: GestureDetector(
          onTap: () => Get.toNamed(Routes.studPersonalSignupRoute),
          child: const Text('Hello Decision Tree :)'),
        ),
      ),
    );
  }
}
