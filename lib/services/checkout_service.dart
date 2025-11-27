// TODO: Buat class CheckoutService
// 
// Service ini menangani proses checkout dan pembuatan order.
// 
// Method yang perlu dibuat:
// - static Future<Map<String, dynamic>> createOrder({required Map<String, dynamic> orderData})
//   - Memanggil ApiService.post('/orders', orderData)
//   - Return response dari API
//
// - static Future<Map<String, dynamic>> applyPromoCode(String promoCode)
//   - Memanggil ApiService.post('/promo/validate', {'code': promoCode})
//   - Return response dengan discount info
//
// Catatan:
// - Handle error dengan try-catch
//
// Lihat INSTRUKSI.md di folder services/ untuk panduan lengkap.

import 'dart:async';
import 'api_service.dart'; 

class CheckoutService {
  

  static Future<Map<String, dynamic>> createOrder({
    required Map<String, dynamic> orderData,
  }) async {
    try {
      final response = await ApiService.post('/orders', orderData);
      
      return response;
    } catch (e) {
      throw Exception('Gagal membuat pesanan (Create Order): $e');
    }
  }

  static Future<Map<String, dynamic>> applyPromoCode(String promoCode) async {
    try {
      final response = await ApiService.post(
        '/promo/validate',
        {'code': promoCode},
        includeToken: false, 
      );
      
      if (response['success'] == true && response['data'] != null) {
        return response['data'] as Map<String, dynamic>;
      } else {
        final message = response['message'] ?? 'Kode promo tidak valid atau kadaluarsa.';
        throw Exception(message);
      }
    } catch (e) {
      throw Exception('Gagal memvalidasi kode promo: ${e.toString()}');
    }
  }
}