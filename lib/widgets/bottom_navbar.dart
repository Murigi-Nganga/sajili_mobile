import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajili_mobile/controllers/bottom_nav_controller.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({
    super.key,
    required this.screens,
    required this.titles,
    required this.selectedIcons,
    required this.unselectedIcons,
  });

  final List<Widget> screens;
  final List<String> titles;
  final List<IconData> selectedIcons;
  final List<IconData> unselectedIcons;
  final BottomNavController _navController = Get.find<BottomNavController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.amber,
          selectedFontSize: 13,
          backgroundColor: Colors.indigo[700],
          selectedLabelStyle: const TextStyle(
            color: Colors.amber,
          ),
          unselectedLabelStyle: const TextStyle(
            color: Colors.black,
          ),
          currentIndex: _navController.selectedIndex.value,
          onTap: (index) => _navController.selectedIndex.value = index,
          items: List.generate(
            screens.length,
            (index) => BottomNavigationBarItem(
              icon: Icon(
                unselectedIcons[index],
              ),
              activeIcon: Icon(
                selectedIcons[index],
              ),
              label: titles[index],
            ),
          ),
        ));
  }
}
