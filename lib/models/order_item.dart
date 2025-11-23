// TODO: Buat model OrderItem
// 
// Model ini merepresentasikan item dalam sebuah order.
// 
// Field yang diperlukan:
// - id (String): ID unik order item
// - foodItemId (String): ID makanan yang dipesan
// - name (String): Nama makanan (untuk display)
// - quantity (int): Jumlah
// - price (double): Harga per item
// - selectedSize (String?): Ukuran yang dipilih (nullable)
// - selectedExtras (List<String>): Daftar extra yang dipilih
// - specialInstructions (String?): Instruksi khusus (nullable)
//
// Method yang perlu dibuat:
// - factory OrderItem.fromJson(Map<String, dynamic> json): Parse dari JSON API
// - Map<String, dynamic> toJson(): Convert ke JSON
//
// Lihat INSTRUKSI.md di folder models/ untuk panduan lengkap.
