import 'package:flutter/material.dart';
import 'package:recicla_facil/utils/app_config.dart';

class ButtonTextBorder extends StatelessWidget {
  final bool withBorder;
  final Color? backgroundColor;
  final Color colorText;
  final double? fontSize;
  final Function()? onPressed;
  final String text;

  const ButtonTextBorder({
    super.key,
    this.onPressed,
    required this.text,
    required this.colorText,
    this.fontSize,
    this.withBorder = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: withBorder
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(
                  color: colorText,
                  width: 2,
                ),
              )
            : null,
        backgroundColor: backgroundColor ?? AppConfig.backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 10),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: colorText,
          fontSize: 20,
        ),
      ),
    );
  }
}
