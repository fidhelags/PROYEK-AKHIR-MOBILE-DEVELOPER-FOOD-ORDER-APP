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
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/order.dart'; 
import '../services/checkout_service.dart'; 

abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {
  final double currentDiscount;
  final String? promoMessage;

  CheckoutInitial({
    this.currentDiscount = 0.0,
    this.promoMessage,
  });

  CheckoutInitial copyWith({
    double? currentDiscount,
    String? promoMessage,
  }) {
    return CheckoutInitial(
      currentDiscount: currentDiscount ?? this.currentDiscount,
      promoMessage: promoMessage,
    );
  }
}

class CheckoutLoading extends CheckoutState {}
class CheckoutSuccess extends CheckoutState {
  final Order order;
  CheckoutSuccess(this.order);
}
class CheckoutError extends CheckoutState {
  final String message;
  CheckoutError(this.message);
}
class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
  
  Future<void> createOrder({
    required Map<String, dynamic> orderData,
  }) async {
    emit(CheckoutLoading());
    
    try {
      final currentDiscount = (state is CheckoutInitial) 
          ? (state as CheckoutInitial).currentDiscount 
          : 0.0;
      
      orderData['discount'] = currentDiscount;
      
      final response = await CheckoutService.createOrder(orderData: orderData);
      
      if (response['success'] == true && response['data'] != null) {
        final order = Order.fromJson(response['data'] as Map<String, dynamic>);
        emit(CheckoutSuccess(order));
      } else {
        emit(CheckoutError(response['message'] ?? 'Gagal membuat pesanan.'));
      }
    } catch (e) {
      emit(CheckoutError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> applyPromoCode(String promoCode) async {
    if (state is! CheckoutInitial) return; 

    try {
      final promoData = await CheckoutService.applyPromoCode(promoCode); 

      final discountAmount = promoData['discount'] as double? ?? 0.0;
      final message = promoData['message'] as String? ?? 'Kode promo berhasil diterapkan.';
      
      // Update state dengan diskon baru
      emit((state as CheckoutInitial).copyWith(
        currentDiscount: discountAmount,
        promoMessage: message,
      ));

    } catch (e) {
      final errorMessage = e.toString().replaceAll('Exception: ', '');
      emit((state as CheckoutInitial).copyWith(
        currentDiscount: 0.0,
        promoMessage: errorMessage,
      ));
    }
  }

  void reset() {
    emit(CheckoutInitial());
  }
}