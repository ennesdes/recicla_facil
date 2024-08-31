import 'package:get/get.dart';
import 'package:recicla_facil/models/proposta.dart';

import 'listagem_proposta_service.dart';

class ListagemPropostaController extends GetxController {
  final ListagemPropostaService _service;

  // Lista observável de propostas
  var propostas = <Proposta>[].obs;

  // Injeção do serviço via construtor
  ListagemPropostaController(this._service);

  @override
  void onInit() async {
    super.onInit(); // Chamando super.onInit()
    await getAllPropostas(); // Carregando propostas ao iniciar
  }

  Future<void> getAllPropostas() async {
    final result = await _service.getAllPropostas();

    if (result.success && result.data != null) {
      propostas.assignAll(result.data!); // Atualizando a lista de propostas
    } else {
      // Log de erro ou tratamento adicional
      print('Erro ao buscar propostas: ${result.message}');
    }
  }
}
