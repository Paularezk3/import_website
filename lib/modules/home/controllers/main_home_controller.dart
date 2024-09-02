// lib/modules/home/controllers/home_controller.dart

import 'package:get/get.dart';

class MainHomeController extends GetxController {
  var counter = 0.obs;

  void increment() {
    counter++;
  }
}
