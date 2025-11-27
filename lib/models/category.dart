// TODO: Buat model Category
// 
// Model ini merepresentasikan kategori makanan (Pizza, Burger, Chicken, dll).
// 
// Field yang diperlukan:
// - id (String): ID unik kategori
// - name (String): Nama kategori
// - isSelected (bool): Status apakah kategori sedang dipilih (untuk UI)
//
// Method yang perlu dibuat:
// - factory Category.fromJson(Map<String, dynamic> json): Parse dari JSON API
// - Map<String, dynamic> toJson(): Convert ke JSON
// - Category copyWith({bool? isSelected}): Method untuk membuat copy dengan nilai baru
//
// Lihat INSTRUKSI.md di folder models/ untuk panduan lengkap.

class Category {
  final String id;
  final String name;
  final bool isSelected; 

  Category({
    required this.id,
    required this.name,
    this.isSelected = false,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown Category',
      isSelected: false, 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isSelected': isSelected,
    };
  }

  Category copyWith({
    String? id,
    String? name,
    bool? isSelected,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}