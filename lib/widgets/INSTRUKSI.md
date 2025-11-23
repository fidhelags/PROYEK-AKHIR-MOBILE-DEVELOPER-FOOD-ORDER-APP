# 🧩 Instruksi: Membuat Reusable Widgets

Folder ini berisi widget-widget yang bisa digunakan kembali di berbagai halaman.

## 🎯 Tujuan

Setelah mengerjakan folder ini, kamu akan:
- Memahami konsep widget di Flutter
- Mampu membuat custom widget yang reusable
- Mampu mengorganisir code dengan baik

## 📚 Konsep Dasar

### Apa itu Widget?

Widget adalah building block di Flutter. Semua yang terlihat di layar adalah widget.

### StatelessWidget vs StatefulWidget

- **StatelessWidget**: Widget yang tidak berubah (contoh: Text, Image)
- **StatefulWidget**: Widget yang bisa berubah (contoh: TextField, Checkbox)

### Membuat Custom Widget

```dart
class MyWidget extends StatelessWidget {
  final String title;  // parameter
  
  const MyWidget({super.key, required this.title});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(title),
    );
  }
}
```

## 📝 Widget yang Perlu Dibuat

### 1. food_card_widget.dart (Pekan 1)
**Fungsi**: Card untuk menampilkan makanan dalam grid

**Parameter**:
```dart
- FoodItem foodItem
- Function() onTap
```

**Struktur**:
```dart
Card(
  child: Column(
    children: [
      Image.network(foodItem.imageUrl),
      Text(foodItem.name),
      Text('\$${foodItem.price}'),
      Row(
        children: [
          Icon(Icons.star),
          Text('${foodItem.rating}'),
        ],
      ),
    ],
  ),
)
```

---

### 2. vertical_food_item_widget.dart (Pekan 2)
**Fungsi**: Item makanan dalam format list (horizontal)

**Struktur**:
```dart
Row(
  children: [
    Image.network(foodItem.imageUrl, width: 100),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(foodItem.name),
          Text('\$${foodItem.price}'),
        ],
      ),
    ),
  ],
)
```

---

### 3. category_item_widget.dart (Pekan 1)
**Fungsi**: Item kategori makanan

**Parameter**:
```dart
- Category category
- Function() onTap
- bool isSelected
```

**Struktur**:
```dart
Container(
  decoration: BoxDecoration(
    color: isSelected ? Colors.green : Colors.grey[200],
    borderRadius: BorderRadius.circular(20),
  ),
  child: Column(
    children: [
      Icon(Icons.fastfood),
      Text(category.name),
    ],
  ),
)
```

---

### 4. cart_item_widget.dart (Pekan 3)
**Fungsi**: Item di cart

**Parameter**:
```dart
- CartItem cartItem
- Function(int) onQuantityChanged
- Function() onRemove
```

**Struktur**:
```dart
Card(
  child: Row(
    children: [
      Image.network(cartItem.foodItem.imageUrl),
      Expanded(
        child: Column(
          children: [
            Text(cartItem.foodItem.name),
            Text('Size: ${cartItem.selectedSize}'),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () => onQuantityChanged(cartItem.quantity - 1),
                ),
                Text('${cartItem.quantity}'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => onQuantityChanged(cartItem.quantity + 1),
                ),
              ],
            ),
          ],
        ),
      ),
      Text('\$${cartItem.totalPrice}'),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: onRemove,
      ),
    ],
  ),
)
```

---

### 5. header_widget.dart (Pekan 1)
**Fungsi**: Header di halaman utama

**Struktur**:
```dart
Container(
  padding: EdgeInsets.all(16),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('AlFood', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      Icon(Icons.shopping_cart),
    ],
  ),
)
```

---

### 6. search_bar_widget.dart (Pekan 1)
**Fungsi**: Search bar

**Parameter**:
```dart
- Function(String) onChanged
- String hintText
```

**Struktur**:
```dart
TextField(
  decoration: InputDecoration(
    hintText: hintText,
    prefixIcon: Icon(Icons.search),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  onChanged: onChanged,
)
```

---

### 7. Widget untuk FoodDetailPage (Pekan 2)

#### food_image_section.dart
Menampilkan gambar makanan dengan aspect ratio.

#### food_info_section.dart
Menampilkan nama, harga, rating, deskripsi.

#### size_selection_section.dart
Radio buttons untuk pilih ukuran.

#### extras_section.dart
CheckboxListTile untuk extra items.

#### special_instructions_section.dart
TextField untuk special instructions.

#### add_to_cart_section.dart
Tombol "Add to Cart" dengan loading indicator.

---

### 8. Widget untuk CartPage (Pekan 3)

#### order_summary_widget.dart
Menampilkan subtotal, tax, delivery, total.

**Struktur**:
```dart
Column(
  children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Subtotal'),
        Text('\$$subtotal'),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Tax'),
        Text('\$$tax'),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Total'),
        Text('\$$total', style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  ],
)
```

---

### 9. Widget untuk CheckoutPage (Pekan 5)

#### payment_method_widget.dart
Radio buttons untuk metode pembayaran.

#### delivery_address_widget.dart
TextField untuk alamat.

#### delivery_options_widget.dart
Dropdown untuk opsi pengiriman.

#### checkout_order_summary_widget.dart
Ringkasan pesanan di checkout.

---

## 🔧 Langkah Pengerjaan

### Pekan 1: Widget Dasar
1. Buat FoodCardWidget
2. Buat CategoryItemWidget
3. Buat HeaderWidget
4. Buat SearchBarWidget

### Pekan 2: Widget Detail
1. Buat widget-widget untuk FoodDetailPage
2. Buat VerticalFoodItemWidget

### Pekan 3: Widget Cart
1. Buat CartItemWidget
2. Buat OrderSummaryWidget

### Pekan 5: Widget Checkout
1. Buat widget-widget untuk CheckoutPage

## 💡 Tips

1. **Gunakan const constructor** jika widget tidak berubah
2. **Extract widget** jika code terlalu panjang
3. **Gunakan parameter** untuk membuat widget flexible
4. **Gunakan named parameters** untuk clarity
5. **Reuse widget** di berbagai tempat

## 📖 Referensi

- Widget Catalog: https://docs.flutter.dev/ui/widgets
- Building Layouts: https://docs.flutter.dev/ui/layout

## ✅ Checklist

- [ ] Buat FoodCardWidget (Pekan 1)
- [ ] Buat CategoryItemWidget (Pekan 1)
- [ ] Buat HeaderWidget dan SearchBarWidget (Pekan 1)
- [ ] Buat widget untuk FoodDetailPage (Pekan 2)
- [ ] Buat CartItemWidget (Pekan 3)
- [ ] Buat OrderSummaryWidget (Pekan 3)
- [ ] Buat widget untuk CheckoutPage (Pekan 5)

---

**Lanjut ke**: `lib/services/INSTRUKSI.md` untuk membuat service API.

