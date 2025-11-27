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
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/order.dart'; 
import '../services/api_service.dart'; 

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<Order> orders;
  OrderLoaded(this.orders);
}

class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
}

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());
  
  Future<void> fetchOrders({String? status}) async {
    emit(OrderLoading());
    
    try {
      Map<String, String>? queryParams;
      if (status != null && status.isNotEmpty) {
        queryParams = {'status': status};
      }
      
      final response = await ApiService.get(
        '/orders',
        queryParameters: queryParams,
      );
      
      if (response['success'] == true && response['data'] != null) {
        final List<dynamic> ordersData = response['data'] as List<dynamic>;
        final orders = ordersData.map((json) => Order.fromJson(json)).toList();
        
        emit(OrderLoaded(orders));
      } else {
        emit(OrderError(response['message'] ?? 'Gagal mengambil daftar pesanan.'));
      }
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
  
  Future<Order?> fetchOrderDetail(String orderId) async {
    try {
      final response = await ApiService.get('/orders/$orderId');
      
      if (response['success'] == true && response['data'] != null) {
        return Order.fromJson(response['data'] as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {

      return null;
    }
  }
}