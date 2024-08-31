import 'dart:convert';

import 'package:recicla_facil/models/api_response.dart';
import 'package:recicla_facil/models/proposal.dart';
import 'package:recicla_facil/utils/api_service.dart';

class ListProposalService {
  Future<ApiResponse> getAllProposals() async {
    try {
      var response = await ApiService().post(
        'getAllProposals',
      );

      var proposals = <Proposal>[];

      if (response != null) {
        var body = jsonDecode(response['body'].toString());

        for (var proposal in body) {
          proposals.add(proposal);
        }

        return ApiResponse(success: true, data: proposals);
      }

      return ApiResponse(
          success: false, message: 'Erro ao realizar logout', data: []);
    } on Exception {
      return ApiResponse(
          success: false, message: 'Erro ao realizar logout', data: []);
    }
  }
}
