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

import 'food_item.dart';
import 'extra_item.dart';

class CartItem {
  final String id;
  final FoodItem foodItem;
  final int quantity;
  final String? selectedSize;
  final List<ExtraItem> selectedExtras;
  final String? specialInstructions;

  CartItem({
    required this.id,
    required this.foodItem,
    required this.quantity,
    this.selectedSize,
    this.selectedExtras = const [],
    this.specialInstructions,
  }) : assert(quantity > 0, 'Quantity must be greater than 0.');

  double get totalPrice {
    double itemPrice = foodItem.price;

    if (selectedSize != null) {
      final sizeAddition = foodItem.sizeOptions[selectedSize];
      if (sizeAddition != null) {
        itemPrice += sizeAddition;
      }
    }

    double extrasPrice = selectedExtras.fold(
      0.0,
      (sum, extra) => sum + extra.price,
    );
    itemPrice += extrasPrice;

    return itemPrice * quantity;
  }

  CartItem copyWith({
    String? id,
    FoodItem? foodItem,
    int? quantity,
    String? selectedSize,
    List<ExtraItem>? selectedExtras,
    String? specialInstructions,
  }) {
    return CartItem(
      id: id ?? this.id,
      foodItem: foodItem ?? this.foodItem,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedExtras: selectedExtras ?? this.selectedExtras,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }
}