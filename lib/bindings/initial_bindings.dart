import 'package:get/get.dart';
import 'package:sajili_mobile/controllers/attendance_controller.dart';
import 'package:sajili_mobile/controllers/bottom_nav_controller.dart';
import 'package:sajili_mobile/controllers/lec_login_controller.dart';
import 'package:sajili_mobile/controllers/schedule_controller.dart';
import 'package:sajili_mobile/controllers/stud_login_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StudLoginController(), fenix: true);
    Get.lazyPut(() => LecLoginController(), fenix: true);
    Get.lazyPut(() => ScheduleController(), fenix: true);
    Get.lazyPut(() => BottomNavController(), fenix: true);
    Get.lazyPut(() => BottomNavController(), fenix: true);
    Get.lazyPut(() => AttendanceController(), fenix: true);
  }
}
