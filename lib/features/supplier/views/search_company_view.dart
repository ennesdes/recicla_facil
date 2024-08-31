import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recicla_facil/components/buttons/button_elevated.dart';
import 'package:recicla_facil/components/inputs/input_text_field.dart';
import 'package:recicla_facil/enum/trash_type.dart';
import 'package:recicla_facil/features/supplier/modals/proposal_modal.dart';
import 'package:recicla_facil/features/supplier/supplier_controller.dart';
import 'package:recicla_facil/utils/app_config.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class SearchCompanyView extends GetView {
  @override
  final SupplierController controller;

  const SearchCompanyView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    SimpleFontelicoProgressDialog dialog = SimpleFontelicoProgressDialog(
      context: context,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Empresa'),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            controller.getProposal(dialog);
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(() {
              return DropdownButton<TrashTypeEnum>(
                value: controller.selectedType.value,
                onChanged: (TrashTypeEnum? newValue) {
                  if (newValue != null) {
                    controller.selectedType.value = newValue;
                  }
                },
                items: TrashTypeEnum.values
                    .map<DropdownMenuItem<TrashTypeEnum>>((TrashTypeEnum type) {
                  return DropdownMenuItem<TrashTypeEnum>(
                    value: type,
                    child: Text(type.description),
                  );
                }).toList(),
              );
            }),
            InputTextField(
              controller: controller.searchController,
              icon: Icons.business,
              label: 'Buscar por nome',
            ),
            ButtonElevated(
              onPressed: () async {
                dialog.show(
                  message: 'Aguarde...',
                  textStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  type: SimpleFontelicoProgressDialogType.phoenix,
                  backgroundColor: Colors.black54,
                  indicatorColor: AppConfig.primaryColor,
                );

                await controller.getCollectors(dialog);

                dialog.hide();
              },
              text: 'Buscar',
              backgroundColor: AppConfig.primaryColor!,
            ),
            const SizedBox(height: 16),
            Obx(() {
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.companyResults.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(controller.companyResults[index].name),
                        ),
                      ),
                      onTap: () {
                        Get.dialog(
                          ProposalModal(
                            company: controller.companyResults[index],
                            controller: controller,
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
