// TODO: Buat model User
// 
// Model ini merepresentasikan data user yang login.
// 
// Field yang diperlukan:
// - id (String): ID unik user
// - name (String): Nama lengkap user
// - email (String): Email user
// - imageUrl (String?): URL foto profil user (nullable)
//
// Method yang perlu dibuat:
// - factory User.fromJson(Map<String, dynamic> json): Parse dari JSON API
// - Map<String, dynamic> toJson(): Convert ke JSON
// - User copyWith({...}): Method untuk membuat copy dengan nilai baru
//
// Lihat INSTRUKSI.md di folder models/ untuk panduan lengkap.
class User {
  final String id;
  final String name;
  final String email;
  final String? imageUrl; 

  User({
    required this.id,
    required this.name,
    required this.email,
    this.imageUrl, 
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Guest User',
      email: json['email'] ?? 'no-email@example.com',
      imageUrl: json['imageUrl'], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl, 
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? imageUrl, 
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}