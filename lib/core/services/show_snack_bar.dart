import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowSnackBar {
  static void showGetSnackbarError(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
      icon: const Icon(
        Icons.error,
        color: Colors.white,
      ),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }

  static void showGetSnackbarDone(String message) {
    Get.snackbar(
      "Done",
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
      icon: const Icon(
        Icons.done_rounded,
        color: Colors.white,
      ),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }
}
