// TODO: Buat model ExtraItem
// 
// Model ini merepresentasikan extra item yang bisa ditambahkan ke makanan (contoh: extra cheese, extra egg).
// 
// Field yang diperlukan:
// - id (String): ID unik extra item
// - name (String): Nama extra item
// - price (double): Harga tambahan untuk extra item
//
// Method yang perlu dibuat:
// - factory ExtraItem.fromJson(Map<String, dynamic> json): Parse dari JSON API
// - Map<String, dynamic> toJson(): Convert ke JSON
//
// Lihat INSTRUKSI.md di folder models/ untuk panduan lengkap.

class ExtraItem {
  final String id;
  final String name;
  final double price; 
  final String description;

  ExtraItem({
    required this.id,
    required this.name,
    required this.price,
    this.description = '',
  });

  static double _parseDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    return 0.0;
  }

  factory ExtraItem.fromJson(Map<String, dynamic> json) {
    return ExtraItem(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Extra Item',
      price: ExtraItem._parseDouble(json['price']),
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
    };
  }
}