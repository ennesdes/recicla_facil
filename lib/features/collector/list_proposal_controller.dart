import 'package:get/get.dart';
import 'package:recicla_facil/features/collector/list_proposal_service.dart';
import 'package:recicla_facil/models/proposal.dart';

class ListProposalController extends GetxController {
  final ListProposalService _service;

  // Lista observável de proposals
  var proposals = <Proposal>[].obs;

  // Injeção do serviço via construtor
  ListProposalController(this._service);

  @override
  void onInit() async {
    super.onInit(); // Chamando super.onInit()
    await getAllProposals(); // Carregando proposals ao iniciar
  }

  Future<void> getAllProposals() async {
    final result = await _service.getAllProposals();

    if (result.success && result.data != null) {
      proposals.assignAll(result.data!); // Atualizando a lista de proposals
    } else {
      // Log de erro ou tratamento adicional
      print('Erro ao buscar proposals: ${result.message}');
    }
  }
}
