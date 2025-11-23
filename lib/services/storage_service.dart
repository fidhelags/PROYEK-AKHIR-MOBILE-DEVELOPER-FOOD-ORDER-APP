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
