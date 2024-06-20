import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pagination/screen/category/view/category_screen.dart';
import 'package:pagination/screen/photo/view/photo_screen.dart';

import '../controller/dash_controller.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({super.key});

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  List<Widget> screen = [
    const PhotoScreen(),
    const CategoryScreen(),
  ];

  DashController controller = DashController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
              () => PageView(
            controller: controller.pageController.value,
            onPageChanged: (value) {
              controller.screenIndex.value = value;
            },
            children: screen,
          ),
        ),
        bottomNavigationBar: Obx(
              () => NavigationBar(
            indicatorColor: Colors.yellow,
            selectedIndex: controller.screenIndex.value,
            onDestinationSelected: (value) {
              controller.pageController.value.animateToPage(value,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeIn);
              controller.screenIndex.value = value;
            },
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.home), label: "Home"),
              NavigationDestination(
                  icon: Icon(Icons.category), label: "Category"),
            ],
            animationDuration: const Duration(microseconds: 1000),
          ),
        ),
      ),
    );
  }
}