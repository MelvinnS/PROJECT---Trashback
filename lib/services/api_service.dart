import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

/// ApiService digunakan untuk semua komunikasi ke backend/MOCKOON.
///
/// Base URL dapat diubah lewat constructor agar mudah menyesuaikan emulator
/// Android/iOS atau HP fisik.
class ApiService {
  final String baseUrl;
  final http.Client _client;

  ApiService({
    this.baseUrl = 'http://localhost:3000',
    http.Client? client,
  }) : _client = client ?? http.Client();

  /// Helper untuk mengekstrak body error agar UI punya pesan yang informatif.
  String _extractErrorBody(http.Response res) {
    final body = res.body.trim();
    if (body.isEmpty) return 'HTTP ${res.statusCode}';
    return 'HTTP ${res.statusCode}: $body';
  }

  /// Helper: lempar exception koneksi dengan pesan yang lebih user-friendly.
  Never _throwConnectionError(Object e) {
    // Di Dart, jenis koneksi yang umum: SocketException, ClientException.
    throw Exception(
      'Tidak dapat terhubung ke server, pastikan Mockoon berjalan',
    );
  }

  /// Register user ke endpoint `/users`.
  ///
  /// POST /users body: {email, password, name}
  ///
  /// Success: 201 (atau 2xx lain).
  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/users');
      final res = await _client.post(
        uri,
        headers: const {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'name': name,
        }),
      );

      if (res.statusCode != 201 && (res.statusCode < 200 || res.statusCode >= 300)) {
        throw Exception('Registrasi gagal. ${_extractErrorBody(res)}');
      }
    } on http.ClientException catch (e) {
      _throwConnectionError(e);
    } on TimeoutException catch (e) {
      _throwConnectionError(e);
    } on Exception {
      rethrow;
    } catch (e) {
      _throwConnectionError(e);
    }
  }

  /// Login user ke endpoint `/login`.
  ///
  /// POST /login body: {email, password}
  ///
  /// Success: 200, response diharapkan {token, user} (atau token field lain).
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/login');
      final res = await _client.post(
        uri,
        headers: const {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (res.statusCode != 200 && (res.statusCode < 200 || res.statusCode >= 300)) {
        throw Exception('Login gagal. ${_extractErrorBody(res)}');
      }

      final data = jsonDecode(res.body) as Map<String, dynamic>;

      final token = (data['token'] ?? data['accessToken'] ?? data['access_token']);
      if (token is! String || token.isEmpty) {
        throw Exception('Login sukses tapi token tidak ditemukan di response');
      }

      final user = data['user'];
      return {
        'token': token,
        'user': user,
      };
    } on http.ClientException catch (e) {
      _throwConnectionError(e);
    } on TimeoutException catch (e) {
      _throwConnectionError(e);
    } on Exception {
      rethrow;
    } catch (e) {
      _throwConnectionError(e);
    }

    // unreachable
  }

  /// Mengambil profile user dari endpoint `/profile`.
  ///
  /// GET /profile header: Authorization: Bearer <token>
  Future<Map<String, dynamic>> getProfile({required String token}) async {
    try {
      final uri = Uri.parse('$baseUrl/profile');
      final res = await _client.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (res.statusCode == 401) {
        throw Exception('401');
      }

      if (res.statusCode < 200 || res.statusCode >= 300) {
        throw Exception('Gagal memuat profil. ${_extractErrorBody(res)}');
      }

      final data = jsonDecode(res.body) as Map<String, dynamic>;
      return data;
    } on http.ClientException catch (e) {
      _throwConnectionError(e);
    } on TimeoutException catch (e) {
      _throwConnectionError(e);
    } on Exception {
      rethrow;
    } catch (e) {
      _throwConnectionError(e);
    }

    // unreachable
  }

  /// Tutup http client.
  void close() {
    _client.close();
  }
}

