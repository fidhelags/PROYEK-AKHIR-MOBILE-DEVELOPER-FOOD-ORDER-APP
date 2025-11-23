// TODO: Buat CartCubit untuk state management cart
// 
// State yang perlu dibuat:
// - CartInitial: State saat cart kosong
// - CartLoaded: State saat cart memiliki item (berisi List<CartItem>)
//
// Method yang perlu dibuat:
// - void addToCart(CartItem cartItem)
//   - Cek apakah item yang sama sudah ada (berdasarkan foodItem.id, size, dan extras)
//   - Jika sudah ada: update quantity
//   - Jika belum: tambahkan item baru
//   - Emit CartLoaded dengan list yang sudah diupdate
//
// - void removeFromCart(String cartItemId)
//   - Hapus item dari list berdasarkan ID
//   - Jika list kosong: emit CartInitial
//   - Jika masih ada item: emit CartLoaded
//
// - void updateQuantity(String cartItemId, int quantity)
//   - Update quantity item berdasarkan ID
//   - Jika quantity <= 0: hapus item
//   - Emit CartLoaded
//
// - void clearCart()
//   - Hapus semua item
//   - Emit CartInitial
//
// Getter yang perlu dibuat:
// - int get itemCount: Total jumlah item di cart
// - double get subtotal: Total harga sebelum tax dan delivery
// - double get tax: Pajak (8% dari subtotal)
// - double get deliveryFee: Biaya pengiriman (0.0 untuk free delivery)
// - double get total: Total akhir (subtotal + tax + deliveryFee)
//
// Catatan:
// - Extends Cubit<CartState>
// - Simpan list cart items sebagai private variable
//
// Lihat INSTRUKSI.md di folder cubit/ untuk panduan lengkap.
