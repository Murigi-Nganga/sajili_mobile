import 'dart:io';

import 'package:get/get.dart';

enum ImageStatus { initial, loading, done }

// Manages the state of the signup form
class StudSignupController extends GetxController {
  Rx<String> regNo = Rx('');
  Rx<String> firstName = Rx('');
  Rx<String> secondName = Rx('');
  Rx<String> email = Rx('');
  Rx<String> phoneNumber = Rx('');
  Rx<String> courseName = Rx('');
  Rx<int> yearOfStudy = Rx(1);
  Rx<File?> image = Rx(null);
  Rx<String> password = Rx('');
  Rx<String> confirmPassword = Rx('');
  Rx<ImageStatus> imageStatus = Rx(ImageStatus.initial);
}
