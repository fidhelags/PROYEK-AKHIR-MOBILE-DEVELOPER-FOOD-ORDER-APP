// TODO: Buat class ApiService
// 
// Service ini menangani semua HTTP request ke backend API.
// 
// Method yang perlu dibuat:
// - static Future<Map<String, dynamic>> get(String endpoint, {bool includeToken = true})
// - static Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body, {bool includeToken = true})
// - static Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> body, {bool includeToken = true})
// - static Future<Map<String, dynamic>> delete(String endpoint, {bool includeToken = true})
// - static Map<String, String> _getHeaders({bool includeToken = true}): Helper untuk membuat headers
// - static Map<String, dynamic> _handleResponse(http.Response response): Helper untuk handle response
//
// Konstanta:
// - static const String baseUrl = 'http://api-alfood.zero-dev.my.id';
//   Base URL API yang sudah disediakan mentor
//
// Catatan:
// - Gunakan package http untuk HTTP request
// - Handle error dengan try-catch
// - Include token di header jika includeToken = true
// - Token diambil dari StorageService.getToken()
//
// Lihat INSTRUKSI.md di folder services/ untuk panduan lengkap.
