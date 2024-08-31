import 'package:flutter/material.dart';
import 'package:recicla_facil/components/buttons/button_elevated.dart';
import 'package:recicla_facil/components/buttons/button_text_border.dart';
import 'package:recicla_facil/utils/app_config.dart';

class AppAlertDialog {
  static Future<bool?> showColoredDialog({
    required BuildContext context,
    required String title,
    required String content,
  }) async {
    return await showModalBottomSheet<bool>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: AppConfig.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppConfig.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppConfig.textColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonTextBorder(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      text: 'Não',
                      colorText: Colors.red,
                      withBorder: true,
                    ),
                    ButtonElevated(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      text: 'Sim',
                      backgroundColor: Colors.green,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
