import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recicla_facil/utils/app_config.dart';

class InputTextField extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSecret;
  final bool readOnly;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;

  const InputTextField({
    super.key,
    required this.icon,
    required this.label,
    this.isSecret = false,
    this.readOnly = false,
    this.validator,
    this.controller,
    this.onChanged,
    this.inputFormatters,
  });

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        inputFormatters: widget.inputFormatters,
        controller: widget.controller,
        obscureText: isObscure,
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.icon,
            color: AppConfig.primaryColor,
          ),
          suffixIcon: widget.isSecret
              ? IconButton(
                  onPressed: () {
                    setState(() => isObscure = !isObscure);
                  },
                  icon: Icon(
                    isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                )
              : null,
          labelText: widget.label,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onChanged: widget.onChanged,
        cursorColor: AppConfig.primaryColor,
        validator: widget.validator,
        readOnly: widget.readOnly,
      ),
    );
  }
}
