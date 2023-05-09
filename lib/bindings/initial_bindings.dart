import 'package:get/get.dart';
import 'package:sajili_mobile/controllers/bottom_nav_controller.dart';
import 'package:sajili_mobile/controllers/gps_controller.dart';
import 'package:sajili_mobile/controllers/lec_login_controller.dart';
import 'package:sajili_mobile/controllers/schedule_controller.dart';
import 'package:sajili_mobile/controllers/stud_login_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    // Student Controllers
    Get.lazyPut(() => StudLoginController(), fenix: true);
    // Get.lazyPut(() => GPSController(), fenix: true);

    // Lecturer Controllers
    Get.lazyPut(() => LecLoginController(), fenix: true);
    
    //TODO: Add LocationController if it will be used

    Get.lazyPut(() => ScheduleController(), fenix: true);
    // Navigation Bar Controller
    Get.lazyPut(() => BottomNavController(), fenix: true);
  }
}
