// TODO: Buat model FoodItem
// 
// Model ini merepresentasikan data makanan/menu yang akan ditampilkan di aplikasi.
// 
// Field yang diperlukan:
// - id (String): ID unik makanan
// - name (String): Nama makanan
// - description (String): Deskripsi makanan
// - price (double): Harga dasar makanan
// - rating (double): Rating makanan (0.0 - 5.0)
// - imageUrl (String): URL gambar makanan
// - category (String): Kategori makanan
// - ingredients (List<String>): Daftar bahan-bahan
// - deliveryTime (String): Estimasi waktu pengiriman
// - sizeOptions (Map<String, double>): Opsi ukuran dengan harga tambahan
// - extras (List<ExtraItem>): Daftar extra item yang bisa ditambahkan
// - reviews (List<Review>): Daftar review
//
// Method yang perlu dibuat:
// - factory FoodItem.fromJson(Map<String, dynamic> json): Parse dari JSON API
// - Map<String, dynamic> toJson(): Convert ke JSON
//
// Lihat INSTRUKSI.md di folder models/ untuk panduan lengkap.
