import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajili_mobile/controllers/bottom_nav_controller.dart';
import 'package:sajili_mobile/views/student/tabs/schedules_screen.dart';
import 'package:sajili_mobile/views/student/tabs/screen_one.dart';
import 'package:sajili_mobile/views/student/tabs/screen_three.dart';
import 'package:sajili_mobile/views/student/tabs/screen_two.dart';
import 'package:sajili_mobile/widgets/bottom_navbar.dart';

class StudHomeScreen extends StatelessWidget {
  StudHomeScreen({super.key});

  final List<Widget> pages = const [
    SchedulesScreen(),
    ScreenOne(),
    ScreenTwo(),
    ScreenThree()
  ];

  final List<String> titles = const [
    'Schedules',
    'Statistics',
    'Motivation',
    'Settings',
  ];

  final List<IconData> _unselectedIcons = const [
    Icons.schedule_outlined,
    Icons.calculate_outlined,
    Icons.lightbulb_outline_rounded,
    Icons.settings_suggest_outlined,
  ];

  final List<IconData> _selectedIcons = const [
    Icons.access_time_filled_rounded,
    Icons.calculate_rounded,
    Icons.lightbulb,
    Icons.settings_suggest_rounded,
  ];

  final _navController = Get.find<BottomNavController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[_navController.selectedIndex.value]),
      bottomNavigationBar: BottomNavBar(
        screens: pages,
        titles: titles,
        selectedIcons: _selectedIcons,
        unselectedIcons: _unselectedIcons,
      ),
    );
  }
}
