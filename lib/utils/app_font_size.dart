import 'package:flutter/material.dart';

class AppFontSize {
  static double getTitleFontSize(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.06;
  }

  static double getSubtitleFontSize(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.045;
  }

  static double getTextFontSize(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.035;
  }
}
