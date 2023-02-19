import 'package:get/get.dart';

// Manages the state of the login form
class StudLoginController extends GetxController {
  Rx<String> email = Rx('');
  Rx<String> password = Rx('');
}
