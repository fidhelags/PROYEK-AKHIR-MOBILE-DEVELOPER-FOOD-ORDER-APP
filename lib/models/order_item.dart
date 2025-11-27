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
class OrderItem {
  final String id;
  final String foodItemId;
  final String name;
  final int quantity;
  final double price; 
  final String? selectedSize;
  final List<String> selectedExtras; 
  final String? specialInstructions;

  OrderItem({
    required this.id,
    required this.foodItemId,
    required this.name,
    required this.quantity,
    required this.price,
    this.selectedSize,
    this.selectedExtras = const [],
    this.specialInstructions,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic value) {
      if (value is num) {
        return value.toDouble();
      }
      return 0.0;
    }

    return OrderItem(
      id: json['id'] ?? '',
      foodItemId: json['foodItemId'] ?? '',
      name: json['name'] ?? 'Unknown Item',
      quantity: (json['quantity'] as int?) ?? 1,
      price: parseDouble(json['price']),
      
      selectedSize: json['selectedSize'], 
      
      selectedExtras: List<String>.from(json['selectedExtras'] ?? []),
      
      specialInstructions: json['specialInstructions'], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'foodItemId': foodItemId,
      'name': name,
      'quantity': quantity,
      'price': price,
      'selectedSize': selectedSize,
      'selectedExtras': selectedExtras,
      'specialInstructions': specialInstructions,
    };
  }

  double get totalItemPrice => price * quantity;
}