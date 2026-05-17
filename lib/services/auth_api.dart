import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_config.dart';

class AuthApi {
  final http.Client _client;

  AuthApi({http.Client? client}) : _client = client ?? http.Client();

  Future<String> login({required String email, required String password}) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/login');

    final res = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('Login gagal (HTTP ${res.statusCode}): ${res.body}');
    }

    final data = jsonDecode(res.body) as Map<String, dynamic>;
    final token = data['token'] ?? data['accessToken'] ?? data['access_token'];
    if (token is! String || token.isEmpty) {
      throw Exception('Respons login tidak memiliki token. Body: ${res.body}');
    }

    return token;
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/users');

    final res = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'name': name,
      }),
    );

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('Register gagal (HTTP ${res.statusCode}): ${res.body}');
    }
  }

  Future<Map<String, dynamic>> fetchProfile({required String token}) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/profile');

    final res = await _client.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('Load profil gagal (HTTP ${res.statusCode}): ${res.body}');
    }

    final data = jsonDecode(res.body) as Map<String, dynamic>;
    return data;
  }
}

