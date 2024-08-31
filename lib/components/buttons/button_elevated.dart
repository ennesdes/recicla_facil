import 'package:flutter/material.dart';
import 'package:recicla_facil/utils/app_font_size.dart';

class ButtonElevated extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Color backgroundColor;
  final double? fontSize;

  const ButtonElevated({
    super.key,
    required this.onPressed,
    required this.text,
    required this.backgroundColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? AppFontSize.getTitleFontSize(context),
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
