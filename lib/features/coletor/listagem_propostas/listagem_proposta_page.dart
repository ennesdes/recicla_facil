import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import para usar inputFormatters
import 'package:get/get.dart';
import 'package:recicla_facil/components/inputs/input_text_field.dart';
import 'package:recicla_facil/enum/trash_type.dart';
import 'package:recicla_facil/features/coletor/listagem_propostas/listagem_proposta_controller.dart';
import 'package:recicla_facil/features/coletor/listagem_propostas/listagem_proposta_service.dart';
import 'package:recicla_facil/models/proposta.dart';
import 'package:recicla_facil/utils/app_config.dart';

class ListagemPropostaPage extends GetView<ListagemPropostaController> {
  const ListagemPropostaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ListagemPropostaController controller = Get.put(
      ListagemPropostaController(Get.put(ListagemPropostaService())),
    );

    // Dados de teste com apenas um item
    var propostaLocal = {
      "propostas": [
        {
          "id": "1",
          "nome": "Proposta de Teste",
          "local": "Local de Teste",
          "tipoColeta": "recyclable",
          "quantidade": 100.0,
          "orcamentos": [
            {
              "id": "1",
              "nome": "Orçamento de Teste",
              "valor": 5000.0,
              "propostaId": "1"
            }
          ]
        }
      ]
    };

    final propostas = (propostaLocal['propostas'] as List)
        .map((data) => Proposta.fromMap(data))
        .toList();

    return Scaffold(
      backgroundColor:
          AppConfig.backgroundColor ?? Colors.white, // Fundo da página
      appBar: AppBar(
        title: const Text(
          'Listagem Propostas',
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppConfig.primaryColor, // Cor primária
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: propostas.length,
          itemBuilder: (context, index) {
            final proposta = propostas[index];
            final valorTotal =
                proposta.orcamentos.fold(0.0, (sum, item) => sum + item.valor);

            // Um TextEditingController para o item
            final TextEditingController orcamentoEC = TextEditingController();

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
                      proposta.nome,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppConfig.textTitleColor ??
                            AppConfig.textColor, // Cor do título
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Local: ${proposta.local}',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppConfig.textColor, // Cor dos textos
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tipo de Coleta: ${proposta.tipoColeta.description}',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppConfig.textColor, // Cor dos textos
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Valor: R\$ ${valorTotal.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppConfig.textColor, // Cor do valor
                      ),
                    ),
                    const SizedBox(height: 16),
                    InputTextField(
                      controller: orcamentoEC,
                      icon: Icons.attach_money,
                      label: 'Valor do orçamento',
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // Permite apenas números
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Lógica para recusar a proposta
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red, // Cor do botão recusar
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
                            // Lógica para enviar a proposta
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.green, // Cor do botão enviar
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
