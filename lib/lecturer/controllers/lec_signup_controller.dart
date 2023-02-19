import 'package:get/get.dart';

class LecSignupController extends GetxController {
  Rx<String> idNumber = Rx('');
  Rx<String> firstName = Rx('');
  Rx<String> secondName = Rx('');
  Rx<String> email = Rx('');
  Rx<String> phoneNumber = Rx('');
  Rx<String> password = Rx('');
  Rx<String> confirmPassword = Rx('');
}