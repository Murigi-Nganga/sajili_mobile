import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajili_mobile/controllers/bottom_nav_controller.dart';
import 'package:sajili_mobile/views/lecturer/tabs/schedule_screen.dart';
import 'package:sajili_mobile/views/lecturer/tabs/screen_four.dart';
import 'package:sajili_mobile/views/lecturer/tabs/screen_three.dart';
import 'package:sajili_mobile/views/lecturer/tabs/screen_two.dart';
import 'package:sajili_mobile/widgets/bottom_navbar.dart';

class LecHomeScreen extends StatelessWidget {
  LecHomeScreen({super.key});

  final List<Widget> _pages = const [
    ScheduleScreen(),
    ScreenTwo(),
    ScreenThree(),
    ScreenFour(),
  ];

  final List<String> _titles = const [
    'Schedules',
    'Statistics',
    'Reports',
    'Settings',
  ];

  final List<IconData> _unselectedIcons = const [
    Icons.schedule_outlined,
    Icons.calculate_outlined,
    Icons.description_outlined,
    Icons.settings_suggest_outlined,
  ];

  final List<IconData> _selectedIcons = const [
    Icons.access_time_filled_rounded,
    Icons.calculate_rounded,
    Icons.description_rounded,
    Icons.settings_suggest_rounded,
  ];

  final _navController = Get.find<BottomNavController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _pages[_navController.selectedIndex.value]),
      bottomNavigationBar: BottomNavBar(
        screens: _pages,
        titles: _titles,
        selectedIcons: _selectedIcons,
        unselectedIcons: _unselectedIcons,
      ),
    );
  }
}
