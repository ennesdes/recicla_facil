import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recicla_facil/utils/app_font_size.dart';

class CustomSnackbar {
  static void showSuccess(String message) {
    Get.snackbar(
      'Sucesso',
      message,
      colorText: Colors.white,
      backgroundColor: Colors.green.withOpacity(0.7),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static void showError(String message) {
    Get.snackbar(
      'Ocorreu um erro',
      message,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 5),
      colorText: Colors.white,
      backgroundColor: Colors.red.withOpacity(0.7),
      snackPosition: SnackPosition.BOTTOM,
      messageText: Text(
        message,
        style: TextStyle(
          fontSize: AppFontSize.getTextFontSize(Get.context!),
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
