import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnack(String title, String subTitle, Color bgColor, IconData icon,
    double overlayBlur) {
  Get.snackbar(
    title,
    subTitle,
    backgroundColor: bgColor,
    overlayBlur: overlayBlur,
    colorText: Colors.white,
    icon: Icon(
      icon,
      color: Colors.white,
    ),
    shouldIconPulse: true,
  );
}
