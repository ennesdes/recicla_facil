import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:recicla_facil/components/alerts/custom_snackbar.dart';
import 'package:recicla_facil/enum/trash_type.dart';
import 'package:recicla_facil/features/supplier/supplier_service.dart';
import 'package:recicla_facil/models/api_response.dart';
import 'package:recicla_facil/models/company_model.dart';
import 'package:recicla_facil/models/proposal.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class SupplierController extends GetxController {
  late String? token;

  var selectedType = TrashTypeEnum.recyclable.obs;
  var searchController = TextEditingController();
  var amountController = TextEditingController();
  var observationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  var companyResults = <CompanyModel>[].obs;
  var proposalResults = <Proposal>[].obs;

  Future<void> getCollectors(SimpleFontelicoProgressDialog dialog) async {
    try {
      final ApiResponse response = await SupplierService().getCollectors(
        name: searchController.text,
        type: selectedType.value.number,
      );

      if (response.success) {
        companyResults.clear();
        companyResults.value = response.data;
      } else {
        CustomSnackbar.showError(response.message!);
      }
    } on Exception catch (ex) {
      companyResults.clear();
      printError(info: 'Erro ao realizar consulta de empresas: $ex');
      dialog.hide();
    }
  }

  Future<void> addProposal(
    String collectorId,
    SimpleFontelicoProgressDialog dialog,
  ) async {
    try {
      // Criar um objeto DateTime a partir da string
      DateFormat inputFormat = DateFormat("dd/MM/yyyy HH:mm");
      DateTime dateTime = inputFormat.parse(dateController.text);

      // Converter o DateTime para o formato ISO 8601 com Z no final
      String isoDateString = dateTime.toUtc().toIso8601String();

      var response = await SupplierService().addProposal(
        type: selectedType.value.number,
        amount: int.tryParse(amountController.text) ?? 0,
        observation: observationController.text,
        collectorId: collectorId,
        date: isoDateString,
      );

      if (response.success) {
        Get.back();
        CustomSnackbar.showSuccess(response.message!);
        amountController.text = '';
        observationController.text = '';
        dateController.text = '';
        dialog.hide();
      } else {
        CustomSnackbar.showError(response.message!);
      }
    } on Exception catch (ex) {
      CustomSnackbar.showError('Erro ao realizar login');
      printError(info: 'Erro ao realizar login: $ex');
    } finally {
      dialog.hide();
    }
  }

  Future<void> getProposal(SimpleFontelicoProgressDialog dialog) async {
    try {
      final ApiResponse response = await SupplierService().getProposal();

      if (response.success) {
        proposalResults.clear();
        proposalResults.value = response.data;
      } else {
        CustomSnackbar.showError(response.message!);
      }
    } on Exception catch (ex) {
      proposalResults.clear();
      printError(info: 'Erro ao realizar consulta das propostas: $ex');
    } finally {
      dialog.hide();
    }
  }
}
