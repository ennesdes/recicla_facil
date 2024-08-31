import 'dart:convert';

import 'package:recicla_facil/models/api_response.dart';
import 'package:recicla_facil/utils/api_service.dart';
import 'package:recicla_facil/utils/token_manager.dart';

class SupplierService {
  Future<ApiResponse> login(String login, String password) async {
    try {
      var response = await ApiService().post(
        'Authentication/GenerateToken',
        body: {
          'email': login,
          'password': password,
        },
      );

      if (response != null) {
        var body = jsonDecode(response['body']);

        if (body['data'] == null) {
          return ApiResponse(
            success: false,
            message: body['messages'][0]['message'] ?? 'Erro ao realizar login',
          );
        }

        if (body['data']['token'] != null && body['data']['token'] != '') {
          TokenManager().saveToken(body['data']['token']);

          return ApiResponse(
            success: true,
            message: 'Login realizado com sucesso',
          );
        }

        return ApiResponse(
          success: false,
          message: body['messages'][0]['message'] ?? 'Erro ao realizar login',
        );
      }

      return ApiResponse(
        success: false,
        message: 'Erro ao realizar login',
      );
    } on Exception {
      return ApiResponse(
        success: false,
        message: 'Erro ao realizar login',
      );
    }
  }

  Future<ApiResponse> logout() async {
    try {
      var response = await ApiService().post(
        'auth/logout',
      );

      if (response != null) {
        var body = jsonDecode(response['body'].toString());

        if (response['status'] == 200 || response['status'] == 401) {
          TokenManager().removeToken();

          return ApiResponse(
            success: true,
            message: 'Logout realizado com sucesso',
          );
        }

        return ApiResponse(
          success: false,
          message: body['messages'][0]['message'] ?? 'Erro ao realizar logout',
        );
      }

      return ApiResponse(
        success: false,
        message: 'Erro ao realizar logout',
      );
    } on Exception {
      return ApiResponse(
        success: false,
        message: 'Erro ao realizar logout',
      );
    }
  }
}
