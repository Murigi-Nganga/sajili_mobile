import 'package:get/get.dart';
import 'package:sajili_mobile/lecturer/controllers/lec_login_controller.dart';
import 'package:sajili_mobile/lecturer/controllers/lec_signup_controller.dart';
import 'package:sajili_mobile/student/controllers/stud_login_controller.dart';
import 'package:sajili_mobile/student/controllers/stud_signup_controller.dart';

class ControllersBinding implements Bindings {
  @override
  void dependencies() {
    // Student Controllers
    Get.lazyPut(() => StudSignupController(), fenix: true);
    Get.lazyPut(() => StudLoginController(), fenix: true);

    // Lecturer Controllers
    Get.lazyPut(() => LecSignupController(), fenix: true);
    Get.lazyPut(() => LecLoginController(), fenix: true);
  }
}
