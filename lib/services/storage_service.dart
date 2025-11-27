// TODO: Buat class StorageService
// 
// Service ini menangani local storage menggunakan Hive untuk menyimpan token dan user data.
// 
// Method yang perlu dibuat:
// - static Future<void> init(): Initialize Hive box
// - static Future<void> saveToken(String token): Simpan token ke storage
// - static String? getToken(): Ambil token dari storage
// - static Future<void> saveUser(User user): Simpan user data ke storage
// - static User? getUser(): Ambil user data dari storage
// - static Future<void> clearAuth(): Hapus token dan user data
// - static bool isAuthenticated(): Cek apakah user sudah login (ada token)
//
// Catatan:
// - Gunakan package hive_flutter untuk local storage
// - Box name: 'auth_box'
// - Key untuk token: 'access_token'
// - Key untuk user: 'user_data'
//
// Lihat INSTRUKSI.md di folder services/ untuk panduan lengkap.

import 'package:hive_flutter/hive_flutter.dart';
import '../models/user.dart'; 
class StorageService {
  static const String _authBoxName = 'auth_box';
  static const String _tokenKey = 'access_token';
  static const String _userKey = 'user_data';

  static Box? _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_authBoxName);
  }

  static Future<void> saveToken(String token) async {
    await _box?.put(_tokenKey, token);
  }

  static String? getToken() {
    return _box?.get(_tokenKey);
  }

  static Future<void> saveUser(User user) async {
    await _box?.put(_userKey, user.toJson());
  }

  static User? getUser() {
    final userData = _box?.get(_userKey);
    
    if (userData != null && userData is Map) {
      return User.fromJson(Map<String, dynamic>.from(userData));
    }
    return null;
  }

  static Future<void> clearAuth() async {
    await _box?.delete(_tokenKey);
    await _box?.delete(_userKey);
  }

  static bool isAuthenticated() {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }
}