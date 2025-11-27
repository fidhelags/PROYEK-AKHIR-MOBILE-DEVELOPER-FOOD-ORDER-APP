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

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'storage_service.dart';

class ApiService {
  // Base URL API yang sudah disediakan mentor
  static const String baseUrl = 'http://api-alfood.zero-dev.my.id';

  static Future<Map<String, dynamic>> get(
    String endpoint, {
    bool includeToken = true,
    Map<String, String>? queryParameters,
  }) async {
    try {
      String path = endpoint;

      // Tambahkan query jika ada
      if (queryParameters != null && queryParameters.isNotEmpty) {
        final queryString = queryParameters.entries
            .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
            .join('&');
        path += '?$queryString';
      }

      final url = Uri.parse('$baseUrl$path');

      final response = await http.get(
        url,
        headers: _getHeaders(includeToken: includeToken),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }

  static Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body, {
    bool includeToken = true,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');

      final response = await http.post(
        url,
        headers: _getHeaders(includeToken: includeToken),
        body: json.encode(body),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }

  static Map<String, String> _getHeaders({bool includeToken = true}) {
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    if (includeToken) {
      final token = StorageService.getToken();
      if (token != null && token.isNotEmpty) {
        headers["Authorization"] = "Bearer $token";
      }
    }

    return headers;
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    final responseData = json.decode(response.body) as Map<String, dynamic>;
  
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return responseData;
    } else {
      // Handle berbagai status code sesuai API_DOCUMENTATION.md
      final message = responseData['message'] ?? 'Request failed';
      final errors = responseData['errors'];
      
      switch (response.statusCode) {
        case 400:
          // Bad Request - Validation errors atau invalid data
          if (errors != null && errors is Map) {
            final errorMessages = errors.entries
                .map((e) => '${e.key}: ${e.value}')
                .join(', ');
            throw Exception('Validation Error: $errorMessages');
          }
          throw Exception('Bad Request: $message');
        case 401:
          // Unauthorized - Token invalid atau missing
          throw Exception('Unauthorized: Invalid or missing token');
        case 403:
          // Forbidden - No permission
          throw Exception('Forbidden: You don\'t have permission');
        case 404:
          // Not Found - Resource tidak ditemukan
          throw Exception('Not Found: $message');
        case 500:
          // Internal Server Error
          throw Exception('Server Error: Internal server error');
        default:
          throw Exception('Request failed (${response.statusCode}): $message');
      }
    }
  }
}
