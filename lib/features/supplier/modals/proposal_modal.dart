import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:recicla_facil/components/buttons/button_elevated.dart';
import 'package:recicla_facil/components/buttons/button_text_border.dart';
import 'package:recicla_facil/components/inputs/input_text_field.dart';
import 'package:recicla_facil/features/supplier/supplier_controller.dart';
import 'package:recicla_facil/models/company_model.dart';
import 'package:recicla_facil/utils/app_config.dart';
import 'package:recicla_facil/utils/app_font_size.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ProposalModal extends StatefulWidget {
  final CompanyModel company;
  final SupplierController controller;

  const ProposalModal({
    super.key,
    required this.company,
    required this.controller,
  });

  @override
  _ProposalModalState createState() => _ProposalModalState();
}

class _ProposalModalState extends State<ProposalModal> {
  DateTime? _selectedDateTime;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Limpa os campos quando o modal é fechado
    widget.controller.amountController.clear();
    widget.controller.observationController.clear();
    widget.controller.dateController.clear();
    super.dispose();
  }

  Future<void> _selectDateTime() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
      );

      if (selectedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
        });
        widget.controller.dateController.text =
            _formatDateTime(_selectedDateTime!);
      }
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final nowUtc = dateTime.toUtc();
    return '${nowUtc.toIso8601String()}Z'; // Adiciona 'Z' para indicar UTC
  }

  @override
  Widget build(BuildContext context) {
    SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(
      context: context,
    );

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        'Criar proposta de entrega para empresa coletora ${widget.company.name}',
        style: TextStyle(
          fontSize: AppFontSize.getSubtitleFontSize(context),
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputTextField(
                controller: widget.controller.amountController,
                icon: Icons.scale,
                label: 'Quantidade de Kilos',
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              InputTextField(
                controller: widget.controller.observationController,
                icon: Icons.note,
                label: 'Observação',
              ),
              const SizedBox(height: 20),
              InputTextField(
                controller: widget.controller.dateController,
                icon: Icons.calendar_today,
                label: 'Data e Hora',
                isDateTime: true,
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        ButtonTextBorder(
          text: 'Cancelar',
          colorText: Colors.red,
          onPressed: () {
            // Limpa os campos ao cancelar
            widget.controller.amountController.clear();
            widget.controller.observationController.clear();
            widget.controller.dateController.clear();
            Get.back(); // Fecha o modal
          },
          withBorder: true,
        ),
        const SizedBox(width: 10),
        ButtonElevated(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              dialog.show(
                message: 'Aguarde...',
                textStyle: const TextStyle(
                  color: Colors.white,
                ),
                type: SimpleFontelicoProgressDialogType.phoenix,
                backgroundColor: Colors.black54,
                indicatorColor: AppConfig.primaryColor,
              );

              await widget.controller.addProposal(widget.company.id, dialog);

              dialog.hide();
            }
          },
          text: 'Salvar',
          backgroundColor: Colors.blue,
        ),
      ],
    );
  }
}
