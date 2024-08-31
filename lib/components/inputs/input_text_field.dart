import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; // Adiciona o pacote intl para formatação de data
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
  final bool isDateTime;
  final TextInputType? keyboardType;

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
    this.isDateTime = false,
    this.keyboardType = TextInputType.text,
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

  Future<void> _selectDateTime() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // Restrição para hoje e para frente
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppConfig.primaryColor,
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme: ColorScheme.light(primary: AppConfig.primaryColor!),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: AppConfig.primaryColor,
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              colorScheme: ColorScheme.light(primary: AppConfig.primaryColor!),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        },
      );

      if (selectedTime != null) {
        final dateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        // Formata a data e a hora para um formato amigável para o usuário
        final formattedDateTime = DateFormat('dd/MM/yyyy HH:mm').format(
          dateTime,
        );

        // Atualiza o texto do controlador com o formato amigável
        widget.controller?.text = formattedDateTime;
      }
    }
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
        readOnly: widget.readOnly || widget.isDateTime,
        onTap: widget.isDateTime ? _selectDateTime : null,
        keyboardType: widget.keyboardType,
      ),
    );
  }
}
