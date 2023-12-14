import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cellu/utils/http_utils.dart';
import 'package:cellu/services/logger_service.dart';

class UserInfoModel {
  final String token;

  UserInfoModel(this.token);

  Future<Map<String, dynamic>> fetchUserInfo() async {
    try {
      final url = '${HttpUtils.backendUrl}/user/profile';
      final headers = HttpUtils.getHeaders(token);

      var response = await http.get(Uri.parse(url), headers: headers);
      return HttpUtils.handleResponse(response);
    } catch (e, stackTrace) {
      LoggerService.error('Failed to fetch user info',
          error: e, stackTrace: stackTrace);
      throw e;
    }
  }
}
