import 'dart:convert';

import 'package:recicla_facil/models/api_response.dart';
import 'package:recicla_facil/models/proposta.dart';
import 'package:recicla_facil/utils/api_service.dart';

class ListagemPropostaService {
  Future<ApiResponse> getAllPropostas() async {
    try {
      var response = await ApiService().post(
        'getAllPropostas',
      );

      var propostas = <Proposta>[];

      if (response != null) {
        var body = jsonDecode(response['body'].toString());

        for (var proposta in body) {
          propostas.add(proposta);
        }

        return ApiResponse(success: true, data: propostas);
      }

      return ApiResponse(
          success: false, message: 'Erro ao realizar logout', data: []);
    } on Exception {
      return ApiResponse(
          success: false, message: 'Erro ao realizar logout', data: []);
    }
  }
}
