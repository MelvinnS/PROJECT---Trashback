import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


/// SessionStorage menyimpan token & user di SharedPreferences.
///
/// Disediakan key sesuai spesifikasi task:
/// - token: 'token'
/// - user: 'user'
///
/// Untuk kompatibilitas dengan kode lama, masih menyimpan/ambil key lama:
/// - auth_token
/// - auth_email
class SessionStorage {
  static const _keyTokenLegacy = 'auth_token';
  static const _keyEmailLegacy = 'auth_email';

  // Key sesuai permintaan task
  static const _keyToken = 'token';
  static const _keyUser = 'user';
  static const _keyEmail = 'auth_email';

  // Expose prefs instance internal (dipakai oleh beberapa screen).
  Future<SharedPreferences> _prefs() => SharedPreferences.getInstance();

  Future<void> saveToken(String token) async {
    final prefs = await _prefs();
    await prefs.setString(_keyToken, token);
    await prefs.setString(_keyTokenLegacy, token);
  }

  Future<String?> getToken() async {
    final prefs = await _prefs();
    return prefs.getString(_keyToken) ?? prefs.getString(_keyTokenLegacy);
  }

  /// Simpan user (object) dalam bentuk JSON string.
  ///
  /// HomeScreen/profile_screen mengharapkan value ini bisa di-parse dengan jsonDecode().
  Future<void> saveUser(Object? user) async {
    final prefs = await _prefs();
    if (user == null) {
      await prefs.remove(_keyUser);
      return;
    }

    // Pastikan yang tersimpan adalah JSON string yang valid.
    // - jika user sudah berupa Map, encode sebagai JSON
    // - jika berupa String, anggap itu sudah JSON
    final jsonString =
        user is String ? user : (jsonEncode(user) as String);

    await prefs.setString(_keyUser, jsonString);
  }



  Future<String?> getUserRaw() async {

    final prefs = await _prefs();
    return prefs.getString(_keyUser);
  }

  Future<void> saveEmail(String email) async {
    final prefs = await _prefs();
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyEmailLegacy, email);
  }

  Future<String?> getEmail() async {
    final prefs = await _prefs();
    return prefs.getString(_keyEmail) ?? prefs.getString(_keyEmailLegacy);
  }

  Future<void> clear() async {
    final prefs = await _prefs();
    await prefs.remove(_keyToken);
    await prefs.remove(_keyTokenLegacy);
    await prefs.remove(_keyUser);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyEmailLegacy);
  }
}


