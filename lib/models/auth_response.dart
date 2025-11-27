// TODO: Buat model AuthResponse
// 
// Model ini merepresentasikan response dari API authentication (login/register).
// 
// Field yang diperlukan:
// - success (bool): Status apakah request berhasil
// - message (String?): Pesan response (nullable)
// - token (String?): Access token untuk autentikasi (nullable)
// - user (User?): Data user yang login/register (nullable)
//
// Method yang perlu dibuat:
// - factory AuthResponse.fromJson(Map<String, dynamic> json): Parse dari JSON API
//
// Lihat INSTRUKSI.md di folder models/ untuk panduan lengkap.
import 'user.dart'; 
class AuthResponse {
  final bool success;
  final String? message; 
  final String? token; 
  final User? user; 

  AuthResponse({
    required this.success,
    this.message,
    this.token,
    this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    final bool isSuccess = json['success'] as bool? ?? false;
    
    final Map<String, dynamic>? userJson = json['user'] as Map<String, dynamic>?;

    return AuthResponse(
      success: isSuccess,
      message: json['message'] as String?,
      token: json['token'] as String?,
      
      user: (isSuccess && userJson != null) 
          ? User.fromJson(userJson) 
          : null,
    );
  }
}