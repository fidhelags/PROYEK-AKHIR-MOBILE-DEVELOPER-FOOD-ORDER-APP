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
