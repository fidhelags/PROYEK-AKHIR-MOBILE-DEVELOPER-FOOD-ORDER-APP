// TODO: Buat OrderCubit untuk state management order history
// 
// State yang perlu dibuat:
// - OrderInitial: State awal
// - OrderLoading: State saat fetch data
// - OrderLoaded: State saat data berhasil diambil (berisi List<Order>)
// - OrderError: State saat terjadi error (berisi error message)
//
// Method yang perlu dibuat:
// - Future<void> fetchOrders()
//   - Set state ke OrderLoading
//   - Panggil ApiService.get('/orders')
//   - Parse response menjadi List<Order>
//   - Emit OrderLoaded dengan list orders
//   - Jika error: emit OrderError
//
// - Future<void> fetchOrderDetail(String orderId)
//   - Panggil ApiService.get('/orders/$orderId')
//   - Parse response menjadi Order
//   - Return Order
//
// Catatan:
// - Extends Cubit<OrderState>
// - Gunakan ApiService untuk fetch data
//
// Lihat INSTRUKSI.md di folder cubit/ untuk panduan lengkap.
