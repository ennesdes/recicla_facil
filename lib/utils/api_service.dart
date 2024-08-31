import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:recicla_facil/utils/token_manager.dart';

class ApiService {
  static const String baseUrl = 'https://gsv.vps-kinghost.net:9000';

  Map<String, String> _getHeaders() {
    var token = TokenManager().getToken();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  Future<Map<String, dynamic>?> get(
    String route, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      Uri uri = Uri.parse('$baseUrl/$route').replace(
        queryParameters: queryParams ?? {},
      );

      final response = await http.get(
        uri,
        headers: _getHeaders(),
      );

      return treatMessage(response);
    } catch (e) {
      printError(info: 'Erro ao fazer requisição GET: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> post(
    String route, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$route'),
        body: jsonEncode(body),
        headers: _getHeaders(),
      );

      return treatMessage(response);
    } catch (e) {
      printError(info: 'Erro ao fazer requisição POST: $e');

      return null;
    }
  }

  Future<Map<String, dynamic>?> put(
    String route, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$route'),
        body: jsonEncode(body),
        headers: _getHeaders(),
      );

      return treatMessage(response);
    } catch (e) {
      printError(info: 'Erro ao fazer requisição PUT: $e');

      return null;
    }
  }

  Future<Map<String, dynamic>?> delete(String route) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$route'),
        headers: _getHeaders(),
      );

      return treatMessage(response);
    } catch (e) {
      printError(info: 'Erro ao fazer requisição DELETE: $e');

      return null;
    }
  }

  Map<String, dynamic>? treatMessage(http.Response response) {
    var body;

    if (response.body.isNotEmpty) {
      body = jsonDecode(response.body);
    }

    switch (response.statusCode) {
      case 200:
        return {
          'body': response.body,
          'status': response.statusCode,
        };
      case 201:
        return {
          'body': response.body,
          'status': response.statusCode,
        };
      case 204:
        return {
          'body': response.body,
          'status': response.statusCode,
        };
      case 401:
        body['messages'][0]['message'] = 'Não autorizado';

        var modifiedResponse = http.Response(
          jsonEncode(body),
          response.statusCode,
        );

        return {
          'body': modifiedResponse.body,
          'status': modifiedResponse.statusCode,
        };
      case 404:
        body['messages'][0]['message'] = 'Não encontrado';

        var modifiedResponse = http.Response(
          jsonEncode(body),
          response.statusCode,
        );

        return {
          'body': modifiedResponse.body,
          'status': modifiedResponse.statusCode,
        };
      case 422:
        return {
          'body': response.body,
          'status': response.statusCode,
        };
      case 500:
        body['messages'][0]['message'] = 'Ocorreu um erro inesperado';

        var modifiedResponse = http.Response(
          jsonEncode(body),
          response.statusCode,
        );

        return {
          'body': modifiedResponse.body,
          'status': modifiedResponse.statusCode,
        };
    }

    return null;
  }
}
