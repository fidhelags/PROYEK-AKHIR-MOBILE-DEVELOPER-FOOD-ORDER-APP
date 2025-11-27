// TODO: Buat model FoodItem
// 
// Model ini merepresentasikan data makanan/menu yang akan ditampilkan di aplikasi.
// 
// Field yang diperlukan:
// - id (String): ID unik makanan
// - name (String): Nama makanan
// - description (String): Deskripsi makanan
// - price (double): Harga dasar makanan
// - rating (double): Rating makanan (0.0 - 5.0)
// - imageUrl (String): URL gambar makanan
// - category (String): Kategori makanan
// - ingredients (List<String>): Daftar bahan-bahan
// - deliveryTime (String): Estimasi waktu pengiriman
// - sizeOptions (Map<String, double>): Opsi ukuran dengan harga tambahan
// - extras (List<ExtraItem>): Daftar extra item yang bisa ditambahkan
// - reviews (List<Review>): Daftar review
//
// Method yang perlu dibuat:
// - factory FoodItem.fromJson(Map<String, dynamic> json): Parse dari JSON API
// - Map<String, dynamic> toJson(): Convert ke JSON
//
// Lihat INSTRUKSI.md di folder models/ untuk panduan lengkap.

import 'extra_item.dart';
import 'review.dart';
class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final String imageUrl;
  final String category;
  final List<String> ingredients;
  final String deliveryTime;
  final Map<String, double> sizeOptions; // {"Small": 0.0, "Large": 2.0}
  final List<ExtraItem> extras;
  final List<Review> reviews;

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.category,
    this.ingredients = const [],
    this.deliveryTime = '15-20 min',
    this.sizeOptions = const {},
    this.extras = const [],
    this.reviews = const [],
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    // Helper untuk mengkonversi data List/Map bertipe dinamis menjadi List/Map objek spesifik.
    final List<dynamic>? extrasJson = json['extras'] as List<dynamic>?;
    final List<dynamic>? reviewsJson = json['reviews'] as List<dynamic>?;

    double parseDouble(dynamic value) {
      if (value is num) {
        return value.toDouble();
      }
      return 0.0;
    }

    return FoodItem(
      id: json['id'] ?? '',
      name: json['name'] ?? 'No Name',
      description: json['description'] ?? 'No description provided.',
      price: parseDouble(json['price']),
      rating: parseDouble(json['rating']),
      imageUrl: json['imageUrl'] ?? '',
      category: json['category'] ?? 'General',
      
      ingredients: List<String>.from(json['ingredients'] ?? []),

      deliveryTime: json['deliveryTime'] ?? '15-20 min',

      sizeOptions: (json['sizeOptions'] as Map<String, dynamic>? ?? {})
          .map<String, double>((key, value) => MapEntry(key, parseDouble(value))),

      extras: extrasJson != null
          ? extrasJson.map((item) => ExtraItem.fromJson(item)).toList()
          : const [],

      // Parsing List<Review>
      reviews: reviewsJson != null
          ? reviewsJson.map((item) => Review.fromJson(item)).toList()
          : const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'rating': rating,
      'imageUrl': imageUrl,
      'category': category,
      'ingredients': ingredients,
      'deliveryTime': deliveryTime,
      'sizeOptions': sizeOptions,
      // Serialisasi objek turunan (ExtraItem dan Review)
      'extras': extras.map((e) => e.toJson()).toList(),
      'reviews': reviews.map((e) => e.toJson()).toList(),
    };
  }
}