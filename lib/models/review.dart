// TODO: Buat model Review
// 
// Model ini merepresentasikan review/rating dari user untuk makanan.
// 
// Field yang diperlukan:
// - id (String): ID unik review
// - userId (String): ID user yang memberikan review
// - userName (String): Nama user
// - rating (double): Rating (1.0 - 5.0)
// - comment (String): Komentar review
// - createdAt (DateTime): Waktu review dibuat
//
// Method yang perlu dibuat:
// - factory Review.fromJson(Map<String, dynamic> json): Parse dari JSON API
// - Map<String, dynamic> toJson(): Convert ke JSON
//
// Lihat INSTRUKSI.md di folder models/ untuk panduan lengkap.
class Review {
  final String id;
  final String userId;
  final String userName;
  final double rating; 
  final String comment;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic value) {
      if (value is num) {
        return value.toDouble();
      }
      return 0.0;
    }

    return Review(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? 'Anonymous User',
      rating: parseDouble(json['rating']),
      comment: json['comment'] ?? 'No comment provided.',
      
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(), 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(), 
    };
  }
}