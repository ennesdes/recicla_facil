import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import para usar inputFormatters
import 'package:get/get.dart';
import 'package:recicla_facil/components/inputs/input_text_field.dart';
import 'package:recicla_facil/enum/trash_type.dart';
import 'package:recicla_facil/features/collector/list_proposal_controller.dart';
import 'package:recicla_facil/models/proposal.dart';
import 'package:recicla_facil/utils/app_config.dart';

class ListProposalPage extends GetView<ListProposalController> {
  const ListProposalPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dados de teste com apenas um item
    var proposalLocal = {
      "proposals": [
        {
          "id": "1",
          "nome": "Proposal de Teste",
          "local": "Local de Teste",
          "tipoColeta": "recyclable",
          "quantidade": 100.0,
          "budgets": [
            {
              "id": "1",
              "nome": "Orçamento de Teste",
              "valor": 5000.0,
              "proposalId": "1"
            }
          ]
        }
      ]
    };

    final proposals = (proposalLocal['proposals'] as List)
        .map((data) => Proposal.fromMap(data))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'List Proposals',
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.toNamed('/login_page'),
          icon: const Icon(Icons.exit_to_app),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: proposals.length,
          itemBuilder: (context, index) {
            final proposal = proposals[index];
            final valorTotal =
                proposal.budgets.fold(0.0, (sum, item) => sum + item.valor);

            // Um TextEditingController para o item
            final TextEditingController budgetEC = TextEditingController();

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      proposal.nome,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppConfig.textTitleColor ?? AppConfig.textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Local: ${proposal.local}',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppConfig.textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tipo de Coleta: ${proposal.tipoColeta.description}',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppConfig.textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Valor: R\$ ${valorTotal.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppConfig.textColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    InputTextField(
                      controller: budgetEC,
                      icon: Icons.attach_money,
                      label: 'Valor do orçamento',
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Lógica para recusar a proposal
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Recusar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Lógica para enviar a proposal
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Enviar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
