// TODO: Buat model CartItem
// 
// Model ini merepresentasikan item yang ada di keranjang belanja.
// 
// Field yang diperlukan:
// - id (String): ID unik cart item
// - foodItem (FoodItem): Data makanan yang dipilih
// - quantity (int): Jumlah item
// - selectedSize (String?): Ukuran yang dipilih (nullable)
// - selectedExtras (List<ExtraItem>): Daftar extra yang dipilih
// - specialInstructions (String?): Instruksi khusus (nullable)
//
// Method yang perlu dibuat:
// - double get totalPrice: Getter untuk menghitung total harga (harga dasar + size + extras) * quantity
// - CartItem copyWith({...}): Method untuk membuat copy dengan nilai baru
//
// Lihat INSTRUKSI.md di folder models/ untuk panduan lengkap.
