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

import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cart_item.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> cartItems;
  
  double get subtotal => cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  double get tax => subtotal * 0.08; 
  double get deliveryFee => 0.0; 
  double get total => subtotal + tax + deliveryFee;
  int get itemCount => cartItems.fold(0, (sum, item) => sum + item.quantity);

  CartLoaded(this.cartItems);
}
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => List.from(_cartItems);

  int get itemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);
  double get subtotal => _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  double get tax => subtotal * 0.08; 
  double get deliveryFee => 0.0; 
  double get total => subtotal + tax + deliveryFee;
  
  bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  void addToCart(CartItem cartItem) {
    final existingIndex = _cartItems.indexWhere(
      (item) =>
          item.foodItem.id == cartItem.foodItem.id &&
          item.selectedSize == cartItem.selectedSize &&
          _listEquals(item.selectedExtras, cartItem.selectedExtras),
    );

    if (existingIndex != -1) {
      _cartItems[existingIndex] = _cartItems[existingIndex].copyWith(
        quantity: _cartItems[existingIndex].quantity + cartItem.quantity,
      );
    } else {
      _cartItems.add(cartItem.copyWith(
        id: cartItem.id.isEmpty ? DateTime.now().microsecondsSinceEpoch.toString() : cartItem.id
      ));
    }

    emit(CartLoaded(List.from(_cartItems)));
  }

  void removeFromCart(String cartItemId) {
    _cartItems.removeWhere((item) => item.id == cartItemId);
    
    _emitCurrentState();
  }

  void updateQuantity(String cartItemId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(cartItemId);
      return;
    }

    final index = _cartItems.indexWhere((item) => item.id == cartItemId);
    if (index != -1) {
      _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);
      
      _emitCurrentState();
    }
  }

  void clearCart() {
    _cartItems.clear();
    _emitCurrentState();
  }
  
  void _emitCurrentState() {
    if (_cartItems.isEmpty) {
      emit(CartInitial());
    } else {
      emit(CartLoaded(List.from(_cartItems)));
    }
  }
}