// TODO: Buat model Order
// 
// Model ini merepresentasikan data pesanan (order).
// 
// Field yang diperlukan:
// - id (String): ID unik order
// - userId (String): ID user yang membuat order
// - status (OrderStatus): Status order (pending, processing, onDelivery, completed, cancelled)
// - items (List<OrderItem>): Daftar item yang dipesan
// - deliveryAddress (String): Alamat pengiriman
// - paymentMethod (String): Metode pembayaran
// - deliveryOption (String): Opsi pengiriman
// - promoCode (String?): Kode promo jika ada (nullable)
// - specialInstructions (String?): Instruksi khusus (nullable)
// - subtotal (double): Subtotal sebelum tax dan delivery
// - tax (double): Pajak
// - deliveryFee (double): Biaya pengiriman
// - discount (double): Diskon dari promo code
// - total (double): Total akhir
// - createdAt (DateTime): Waktu pembuatan order
// - updatedAt (DateTime): Waktu update terakhir
//
// Enum OrderStatus:
// - pending, processing, onDelivery, completed, cancelled
//
// Method yang perlu dibuat:
// - factory Order.fromJson(Map<String, dynamic> json): Parse dari JSON API
// - Map<String, dynamic> toJson(): Convert ke JSON
// - String get statusDisplay: Getter untuk menampilkan status dalam format yang user-friendly
//
// Lihat INSTRUKSI.md di folder models/ untuk panduan lengkap.
