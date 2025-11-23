# 📦 Instruksi: Membuat Model Data

Folder ini berisi model-model data yang digunakan di aplikasi. Model adalah representasi data dalam bentuk class di Dart.

## 🎯 Tujuan

Setelah mengerjakan folder ini, kamu akan:
- Memahami konsep model class di Dart
- Mampu membuat model dari JSON response API
- Mampu convert model ke JSON untuk request API

## 📚 Konsep Dasar

### Apa itu Model?

Model adalah class yang merepresentasikan struktur data. Contoh:
- `FoodItem` = data makanan (nama, harga, gambar, dll)
- `User` = data user (nama, email, dll)
- `CartItem` = item di keranjang (makanan, jumlah, ukuran, dll)

### JSON Parsing

API biasanya mengembalikan data dalam format JSON. Kita perlu:
1. **fromJson**: Convert JSON → Model object
2. **toJson**: Convert Model object → JSON

## 📝 File yang Perlu Dibuat

### 1. food_item.dart
Model untuk data makanan.

**Field yang diperlukan**:
```dart
- String id
- String name
- String description
- double price
- double rating
- String imageUrl
- String category
- List<String> ingredients
- String deliveryTime
- Map<String, double> sizeOptions  // {"Small": 0.0, "Large": 2.0}
- List<ExtraItem> extras
- List<Review> reviews
```

**Method yang perlu dibuat**:
```dart
// Constructor
FoodItem({required this.id, required this.name, ...})

// Parse dari JSON API
factory FoodItem.fromJson(Map<String, dynamic> json) {
  return FoodItem(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    price: (json['price'] ?? 0.0).toDouble(),
    // ... dst
  );
}

// Convert ke JSON
Map<String, dynamic> toJson() {
  return {
    'id': id,
    'name': name,
    'price': price,
    // ... dst
  };
}
```

**Contoh JSON dari API**:
```json
{
  "id": "1",
  "name": "Classic Beef Burger",
  "description": "Premium beef patty...",
  "price": 12.99,
  "rating": 4.8,
  "imageUrl": "https://api.example.com/images/burger.jpg",
  "category": "Burger",
  "ingredients": ["Beef", "Lettuce", "Tomato"],
  "deliveryTime": "15-20 min",
  "sizeOptions": {
    "Small": 0.0,
    "Medium": 2.0,
    "Large": 4.0
  }
}
```

### 2. category.dart
Model untuk kategori makanan.

**Field**:
```dart
- String id
- String name
- bool isSelected  // untuk UI state
```

**Method**:
- `fromJson`, `toJson`, `copyWith`

### 3. user.dart
Model untuk data user.

**Field**:
```dart
- String id
- String name
- String email
- String? imageUrl  // nullable
```

### 4. cart_item.dart
Model untuk item di keranjang.

**Field**:
```dart
- String id
- FoodItem foodItem
- int quantity
- String? selectedSize
- List<ExtraItem> selectedExtras
- String? specialInstructions
```

**Getter**:
```dart
double get totalPrice {
  // Hitung: (harga dasar + harga size + harga extras) * quantity
}
```

### 5. order.dart
Model untuk pesanan.

**Field**:
```dart
- String id
- String userId
- OrderStatus status  // enum: pending, processing, onDelivery, completed, cancelled
- List<OrderItem> items
- String deliveryAddress
- String paymentMethod
- String deliveryOption
- String? promoCode
- String? specialInstructions
- double subtotal
- double tax
- double deliveryFee
- double discount
- double total
- DateTime createdAt
- DateTime updatedAt
```

**Enum OrderStatus**:
```dart
enum OrderStatus {
  pending,
  processing,
  onDelivery,
  completed,
  cancelled,
}
```

### 6. order_item.dart
Model untuk item dalam order.

### 7. extra_item.dart
Model untuk extra item (contoh: extra cheese, extra egg).

### 8. review.dart
Model untuk review makanan.

### 9. auth_response.dart
Model untuk response authentication.

**Field**:
```dart
- bool success
- String? message
- String? token
- User? user
```

## 🔧 Langkah Pengerjaan

### Step 1: Buat Model Dasar (Pekan 1)
1. Buat `food_item.dart` dengan field dasar (id, name, price, imageUrl)
2. Buat `category.dart`
3. Test dengan membuat object manual:
   ```dart
   final food = FoodItem(
     id: '1',
     name: 'Burger',
     price: 10.0,
     // ...
   );
   ```

### Step 2: Tambah JSON Parsing (Pekan 4)
1. Tambahkan method `fromJson` dan `toJson` di semua model
2. Test dengan data JSON dari API

### Step 3: Lengkapi Model (Pekan 2-5)
1. Tambahkan field-field yang diperlukan sesuai kebutuhan fitur
2. Buat model-model lainnya (CartItem, Order, dll)

## 💡 Tips

1. **Gunakan Null Safety**: Gunakan `?` untuk field yang bisa null
2. **Default Values**: Berikan default value untuk field opsional
3. **Type Conversion**: Perhatikan konversi tipe (int → double, String → DateTime)
4. **Error Handling**: Handle null dengan `??` operator:
   ```dart
   id: json['id'] ?? '',  // jika null, gunakan empty string
   price: (json['price'] ?? 0.0).toDouble(),
   ```

## 📖 Referensi

- Dart Classes: https://dart.dev/language/classes
- JSON Serialization: https://docs.flutter.dev/development/data-and-backend/json

## ✅ Checklist

- [ ] Buat FoodItem model dengan field dasar
- [ ] Buat Category model
- [ ] Buat User model
- [ ] Tambahkan fromJson dan toJson di semua model
- [ ] Buat CartItem model
- [ ] Buat Order dan OrderItem model
- [ ] Buat ExtraItem dan Review model
- [ ] Buat AuthResponse model
- [ ] Test semua model dengan data JSON

---

**Lanjut ke**: `lib/pages/INSTRUKSI.md` untuk membuat halaman aplikasi.

