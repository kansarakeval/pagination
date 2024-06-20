import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DashController extends GetxController {
  RxInt screenIndex = 0.obs;
  Rx<PageController> pageController = PageController(initialPage:0).obs;
}