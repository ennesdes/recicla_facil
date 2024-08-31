import 'dart:convert';

import 'package:recicla_facil/models/api_response.dart';
import 'package:recicla_facil/models/company_model.dart';
import 'package:recicla_facil/models/proposal.dart';
import 'package:recicla_facil/utils/api_service.dart';

class SupplierService {
  Future<ApiResponse> getCollectors({
    required String name,
    required int type,
  }) async {
    try {
      var response = await ApiService().get(
        'Company/GetCollectors',
        queryParams: {
          'name': name.isEmpty ? null : name,
          'type': type.toString(),
        },
      );

      if (response != null && response['status'] == 200) {
        // Decodifique o JSON em um Map
        var body = jsonDecode(response['body']) as Map<String, dynamic>;
        var data = body['data'] as List<dynamic>;

        List<CompanyModel> companyList = data
            .map((item) => CompanyModel.fromJson(item as Map<String, dynamic>))
            .toList();

        return ApiResponse(
          success: true,
          data: companyList,
        );
      } else if (response != null) {
        var body = jsonDecode(response['body']) as Map<String, dynamic>;

        return ApiResponse(
          success: false,
          message: body['messages'][0]['message'],
        );
      }

      return ApiResponse(
        success: false,
        message: 'Erro ao realizar consulta de empresas coletoras',
      );
    } on Exception {
      return ApiResponse(
        success: false,
        message: 'Erro ao realizar busca de empresas',
      );
    }
  }

  Future<ApiResponse> addProposal({
    required int type,
    required int amount,
    required String observation,
    required String collectorId,
    required String date,
  }) async {
    try {
      var response = await ApiService().post(
        'Proposal',
        body: {
          'type': type,
          'amount': amount,
          'observation': observation,
          'collectorId': collectorId,
          'date': date,
        },
      );

      if (response != null) {
        var body = jsonDecode(response['body']);

        if (body['success'] == false) {
          return ApiResponse(
            success: false,
            message: body['messages'][0]['message'] ?? 'Erro ao criar proposta',
          );
        }

        if (body['success'] == true) {
          return ApiResponse(
            success: true,
            message: 'Proposta enviada com sucesso',
          );
        }

        return ApiResponse(
          success: false,
          message: body['messages'][0]['message'] ?? 'Erro ao criar proposta',
        );
      }

      return ApiResponse(
        success: false,
        message: 'Erro ao criar proposta',
      );
    } on Exception {
      return ApiResponse(
        success: false,
        message: 'Erro ao criar proposta de entrega',
      );
    }
  }

  Future<ApiResponse> getProposal({
    String? name,
    int? type,
    String? date,
  }) async {
    try {
      var response = await ApiService().get(
        'Proposal',
        queryParams: {
          'name': name == null || name.isEmpty ? null : name,
          'type': type?.toString(),
          'date': date,
        },
      );

      if (response != null && response['status'] == 200) {
        // Decodifique o JSON em um Map
        var body = jsonDecode(response['body']) as Map<String, dynamic>;
        var data = body['data'] as List<dynamic>;

        List<Proposal> companyList = data
            .map((item) => Proposal.fromMap(item as Map<String, dynamic>))
            .toList();

        return ApiResponse(
          success: true,
          data: companyList,
        );
      } else if (response != null) {
        var body = jsonDecode(response['body']) as Map<String, dynamic>;

        return ApiResponse(
          success: false,
          message: body['messages'][0]['message'],
        );
      }

      return ApiResponse(
        success: false,
        message: 'Erro ao realizar consulta de propostas',
      );
    } on Exception {
      return ApiResponse(
        success: false,
        message: 'Erro ao realizar busca de propostas',
      );
    }
  }
}
