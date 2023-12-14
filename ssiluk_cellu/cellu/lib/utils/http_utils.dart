import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cellu/services/logger_service.dart';

class HttpUtils {
  static String get backendUrl => dotenv.env['BACKEND_URL'] ?? "DEFAULT_URL";

  static Map<String, String> getHeaders(String token) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  static dynamic handleResponse(http.Response response) {
    if (response.headers['content-type']?.contains('application/json') ??
        false) {
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        LoggerService.error(
            'Non-success response: ${response.statusCode}, Body: ${response.body}');
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } else if (response.headers['content-type']?.contains('text/html') ??
        false) {
      LoggerService.info('Received HTML response: ${response.body}');
      if (response.body.contains('<h1>Hello, World!</h1>')) {
        return true;
      } else {
        throw Exception('Unexpected HTML format: ${response.body}');
      }
    } else {
      LoggerService.error(
          'Expected JSON, but received: ${response.headers['content-type']}, Body: ${response.body}');
      throw Exception(
          'Invalid response format: ${response.headers['content-type']}');
    }
  }
}
