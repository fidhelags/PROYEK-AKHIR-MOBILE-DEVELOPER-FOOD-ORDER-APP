// TODO: Buat CheckoutCubit untuk state management checkout
// 
// State yang perlu dibuat:
// - CheckoutInitial: State awal
// - CheckoutLoading: State saat proses create order
// - CheckoutSuccess: State saat order berhasil dibuat (berisi Order)
// - CheckoutError: State saat terjadi error (berisi error message)
//
// Method yang perlu dibuat:
// - Future<void> createOrder({required Map<String, dynamic> orderData})
//   - Set state ke CheckoutLoading
//   - Panggil CheckoutService.createOrder()
//   - Jika berhasil: emit CheckoutSuccess dengan Order
//   - Jika gagal: emit CheckoutError
//
// - Future<void> applyPromoCode(String promoCode)
//   - Panggil CheckoutService.applyPromoCode()
//   - Update discount di state
//
// Catatan:
// - Extends Cubit<CheckoutState>
// - Order data berisi: items, deliveryAddress, paymentMethod, dll
//
// Lihat INSTRUKSI.md di folder cubit/ untuk panduan lengkap.
