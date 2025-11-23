// TODO: Buat class AuthService
// 
// Service ini menangani authentication (login dan register).
// 
// Method yang perlu dibuat:
// - static Future<AuthResponse> register({required String name, required String email, required String password})
//   - Memanggil ApiService.post('/auth/register', {...})
//   - Return AuthResponse
//
// - static Future<AuthResponse> login({required String email, required String password})
//   - Memanggil ApiService.post('/auth/login', {...})
//   - Return AuthResponse
//
// - static Future<AuthResponse> getCurrentUser()
//   - Memanggil ApiService.get('/auth/me')
//   - Return AuthResponse dengan user data
//
// Catatan:
// - Semua method return AuthResponse
// - Handle error dengan try-catch dan return AuthResponse dengan success: false
//
// Lihat INSTRUKSI.md di folder services/ untuk panduan lengkap.
