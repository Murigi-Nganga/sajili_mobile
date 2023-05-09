import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajili_mobile/local_storage/local_storage.dart';
import 'package:sajili_mobile/routes/app_routes.dart';

class ScreenFour extends StatelessWidget {
  const ScreenFour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Text('Settings screen !!!'),
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed(Routes.lecLoginRoute);
                LocalStorage().removeUser();
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
