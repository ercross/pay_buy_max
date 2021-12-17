import 'package:dio/dio.dart';

import '../models/api_response.dart';

class Api {
  static const String _base = "https://tobby-epay.herokuapp.com/api";
  static const String _registerUser = "/signup";
  static const String _login = "/signin";

  final Dio _client = Dio(BaseOptions(
    connectTimeout: 20000,
    baseUrl: _base,
    headers: {"Accept": "application/json", "Content-Type": "application/json"},
    receiveTimeout: 20000,
    sendTimeout: 20000,
  ));

  Future<ApiResponse> signup(Map<String, String> credentials) async {
    try {
      final response = await _client.post(_registerUser, options: Options(method: "POST"), data: credentials);
      return ApiResponse.from(response.data);
    } on DioError catch (e) {
      return e.toApiError();
    }
  }

  Future<ApiResponse> signin(Map<String, dynamic> credentials) async {
    try {
      final response = await _client.post(_login, options: Options(method: "POST"), data: credentials);
      return ApiResponse.from(response.data);
    } on DioError catch (e) {
      return e.toApiError();
    }
  }
}
