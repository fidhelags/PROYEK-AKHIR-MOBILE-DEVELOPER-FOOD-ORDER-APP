// TODO: Buat model Order
// 
// Model ini merepresentasikan data pesanan (order).
// 
// Field yang diperlukan:
// - id (String): ID unik order
// - userId (String): ID user yang membuat order
// - status (OrderStatus): Status order (pending, processing, onDelivery, completed, cancelled)
// - items (List<OrderItem>): Daftar item yang dipesan
// - deliveryAddress (String): Alamat pengiriman
// - paymentMethod (String): Metode pembayaran
// - deliveryOption (String): Opsi pengiriman
// - promoCode (String?): Kode promo jika ada (nullable)
// - specialInstructions (String?): Instruksi khusus (nullable)
// - subtotal (double): Subtotal sebelum tax dan delivery
// - tax (double): Pajak
// - deliveryFee (double): Biaya pengiriman
// - discount (double): Diskon dari promo code
// - total (double): Total akhir
// - createdAt (DateTime): Waktu pembuatan order
// - updatedAt (DateTime): Waktu update terakhir
//
// Enum OrderStatus:
// - pending, processing, onDelivery, completed, cancelled
//
// Method yang perlu dibuat:
// - factory Order.fromJson(Map<String, dynamic> json): Parse dari JSON API
// - Map<String, dynamic> toJson(): Convert ke JSON
// - String get statusDisplay: Getter untuk menampilkan status dalam format yang user-friendly
//
// Lihat INSTRUKSI.md di folder models/ untuk panduan lengkap.

enum OrderStatus {
  pending,
  processing,
  onDelivery,
  completed,
  cancelled,
}

class Order {
  final String id;
  final String userId;
  final OrderStatus status;
  final List<dynamic> items; 
  final String deliveryAddress;
  final String paymentMethod;
  final String deliveryOption;
  final String? promoCode;
  final String? specialInstructions;
  final double subtotal;
  final double tax;
  final double deliveryFee;
  final double discount;
  final double total;
  final DateTime createdAt;
  final DateTime updatedAt;

  Order({
    required this.id,
    required this.userId,
    required this.status,
    required this.items,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.deliveryOption,
    this.promoCode,
    this.specialInstructions,
    required this.subtotal,
    required this.tax,
    required this.deliveryFee,
    required this.discount,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
  });

  static OrderStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return OrderStatus.pending;
      case 'processing':
        return OrderStatus.processing;
      case 'ondelivery':
        return OrderStatus.onDelivery;
      case 'completed':
        return OrderStatus.completed;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending;
    }
  }

  static double _parseDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    return 0.0;
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    final List<dynamic> itemsJson = json['items'] as List<dynamic>? ?? [];

    return Order(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      status: _parseStatus(json['status'] ?? 'pending'),
      
      items: itemsJson, 

      deliveryAddress: json['deliveryAddress'] ?? 'N/A',
      paymentMethod: json['paymentMethod'] ?? 'N/A',
      deliveryOption: json['deliveryOption'] ?? 'Standard',
      
      promoCode: json['promoCode'], 
      specialInstructions: json['specialInstructions'], 
      subtotal: (json['subtotal'] is num) ? json['subtotal'].toDouble() : 0.0,
      tax: (json['tax'] is num) ? json['tax'].toDouble() : 0.0,
      deliveryFee: _parseDouble(json['deliveryFee']),
      discount: _parseDouble(json['discount']),
      total: _parseDouble(json['total']),

      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.name, 
      'items': items, 

      'deliveryAddress': deliveryAddress,
      'paymentMethod': paymentMethod,
      'deliveryOption': deliveryOption,
      'promoCode': promoCode,
      'specialInstructions': specialInstructions,
      'subtotal': subtotal,
      'tax': tax,
      'deliveryFee': deliveryFee,
      'discount': discount,
      'total': total,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  String get statusDisplay {
    switch (status) {
      case OrderStatus.pending:
        return 'Menunggu Pembayaran';
      case OrderStatus.processing:
        return 'Sedang Diproses';
      case OrderStatus.onDelivery:
        return 'Dalam Pengiriman';
      case OrderStatus.completed:
        return 'Selesai';
      case OrderStatus.cancelled:
        return 'Dibatalkan';
    }
  }
}