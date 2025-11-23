# 📄 Instruksi: Membuat Halaman (Pages)

Folder ini berisi semua halaman aplikasi. Setiap file adalah satu halaman/screen.

## 🎯 Tujuan

Setelah mengerjakan folder ini, kamu akan:
- Memahami cara membuat halaman dengan Scaffold
- Mampu melakukan navigasi antar halaman
- Mampu passing data antar halaman
- Mampu menggunakan BlocBuilder untuk state management

## 📚 Konsep Dasar

### Scaffold

Scaffold adalah widget dasar untuk membuat halaman. Struktur dasar:
```dart
Scaffold(
  appBar: AppBar(title: Text('Judul')),
  body: Center(child: Text('Isi halaman')),
)
```

### Navigasi

Untuk pindah halaman, gunakan `Navigator`:
```dart
// Push ke halaman baru
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => FoodDetailPage()),
);

// Pop (kembali)
Navigator.pop(context);

// Push dengan data
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => FoodDetailPage(foodItem: selectedFood),
  ),
);
```

### State Management dengan BlocBuilder

Untuk listen state dari Cubit:
```dart
BlocBuilder<CartCubit, CartState>(
  builder: (context, state) {
    if (state is CartLoaded) {
      return Text('Cart has ${state.cartItems.length} items');
    }
    return Text('Cart is empty');
  },
)
```

## 📝 Halaman yang Perlu Dibuat

### 1. splash_page.dart (Pekan 5)
**Fungsi**: Halaman pertama saat app dibuka

**Langkah**:
1. Tampilkan logo/splash screen
2. Di `initState()`, cek apakah user sudah login:
   ```dart
   if (StorageService.isAuthenticated()) {
     // Redirect ke MainPage
   } else {
     // Redirect ke LoginPage
   }
   ```
3. Gunakan `FutureBuilder` atau `initState` dengan delay

**Widget yang digunakan**:
- Scaffold
- Center
- Image atau Icon

---

### 2. login_page.dart (Pekan 5)
**Fungsi**: Halaman login

**Langkah**:
1. Buat form dengan TextField untuk email dan password
2. Buat tombol login
3. Di tombol login, panggil `AuthCubit.login()`
4. Listen state dengan BlocBuilder:
   ```dart
   BlocBuilder<AuthCubit, AuthState>(
     builder: (context, state) {
       if (state is AuthLoading) {
         return CircularProgressIndicator();
       }
       if (state is AuthError) {
         return Text('Error: ${state.message}');
       }
       // ...
     },
   )
   ```
5. Jika berhasil, navigasi ke MainPage
6. Link ke RegisterPage

**Widget yang digunakan**:
- Scaffold
- TextField
- ElevatedButton
- BlocBuilder
- Navigator

---

### 3. register_page.dart (Pekan 5)
**Fungsi**: Halaman registrasi

**Mirip dengan LoginPage**, tapi:
- Form: name, email, password
- Panggil `AuthCubit.register()`

---

### 4. main_page.dart (Pekan 2)
**Fungsi**: Halaman utama dengan bottom navigation

**Langkah**:
1. Buat Scaffold dengan `bottomNavigationBar`
2. Buat state untuk current index (0 = Home, 1 = Menu, 2 = Favorites, 3 = Profile)
3. Gunakan IndexedStack untuk switch halaman:
   ```dart
   IndexedStack(
     index: _currentIndex,
     children: [
       HomePage(),
       MenuPage(),
       FavoritesPage(),
       ProfilePage(),
     ],
   )
   ```
4. Update `_currentIndex` saat bottom nav diklik

**Widget yang digunakan**:
- Scaffold
- BottomNavigationBar
- IndexedStack

---

### 5. home_page.dart (Pekan 1 & 4)
**Fungsi**: Halaman utama menampilkan daftar makanan

**Langkah Pekan 1 (Data Statis)**:
1. Buat list makanan statis di `initState()`
2. Tampilkan dengan GridView atau ListView
3. Gunakan FoodCardWidget untuk setiap item

**Langkah Pekan 4 (Data dari API)**:
1. Fetch data dari API menggunakan Cubit (akan dibuat di pekan 4)
2. Listen state dengan BlocBuilder
3. Tampilkan loading indicator saat fetch
4. Tampilkan error jika gagal

**Struktur**:
```dart
Scaffold(
  body: Column(
    children: [
      HeaderWidget(),
      SearchBarWidget(),
      CategoryListWidget(),
      Expanded(
        child: GridView.builder(
          itemCount: foodItems.length,
          itemBuilder: (context, index) {
            return FoodCardWidget(foodItem: foodItems[index]);
          },
        ),
      ),
    ],
  ),
)
```

**Widget yang digunakan**:
- Scaffold
- Column
- GridView atau ListView
- BlocBuilder (pekan 4)

---

### 6. food_detail_page.dart (Pekan 2 & 3)
**Fungsi**: Halaman detail makanan

**Langkah**:
1. Terima `FoodItem` sebagai parameter
2. Tampilkan gambar, nama, harga, rating, deskripsi
3. Tampilkan opsi ukuran (jika ada)
4. Tampilkan extra items (checkbox)
5. Input special instructions
6. Tombol "Add to Cart":
   ```dart
   onPressed: () {
     final cartItem = CartItem(
       id: DateTime.now().toString(),
       foodItem: widget.foodItem,
       quantity: 1,
       selectedSize: selectedSize,
       selectedExtras: selectedExtras,
     );
     context.read<CartCubit>().addToCart(cartItem);
     Navigator.pop(context); // kembali ke halaman sebelumnya
   }
   ```

**Widget yang digunakan**:
- Scaffold
- Image
- Text
- Radio atau Chip (untuk size)
- CheckboxListTile (untuk extras)
- TextField
- ElevatedButton
- BlocBuilder

---

### 7. cart_page.dart (Pekan 3)
**Fungsi**: Halaman keranjang

**Langkah**:
1. Listen CartCubit dengan BlocBuilder
2. Tampilkan list cart items dengan CartItemWidget
3. Setiap item bisa:
   - Update quantity (tombol + dan -)
   - Hapus item
4. Tampilkan ringkasan harga (subtotal, tax, delivery, total)
5. Tombol "Checkout" navigasi ke CheckoutPage

**Struktur**:
```dart
BlocBuilder<CartCubit, CartState>(
  builder: (context, state) {
    if (state is CartLoaded) {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: state.cartItems.length,
              itemBuilder: (context, index) {
                return CartItemWidget(
                  cartItem: state.cartItems[index],
                  onQuantityChanged: (qty) {
                    context.read<CartCubit>().updateQuantity(
                      state.cartItems[index].id,
                      qty,
                    );
                  },
                );
              },
            ),
          ),
          OrderSummaryWidget(
            subtotal: context.read<CartCubit>().subtotal,
            tax: context.read<CartCubit>().tax,
            total: context.read<CartCubit>().total,
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(...),
            child: Text('Checkout'),
          ),
        ],
      );
    }
    return Text('Cart is empty');
  },
)
```

---

### 8. checkout_page.dart (Pekan 5)
**Fungsi**: Halaman checkout

**Langkah**:
1. Form input:
   - Alamat pengiriman (TextField)
   - Metode pembayaran (Radio)
   - Opsi pengiriman (Dropdown)
   - Promo code (TextField, opsional)
   - Special instructions (TextField, opsional)
2. Tampilkan ringkasan pesanan
3. Tombol "Place Order":
   ```dart
   context.read<CheckoutCubit>().createOrder(
     orderData: {
       'items': cartItems.map((item) => item.toJson()).toList(),
       'deliveryAddress': addressController.text,
       'paymentMethod': selectedPaymentMethod,
       // ... dst
     },
   );
   ```
4. Listen CheckoutCubit state
5. Jika berhasil, navigasi ke OrderHistoryPage

---

### 9. order_history_page.dart (Pekan 5)
**Fungsi**: Halaman riwayat pesanan

**Langkah**:
1. Di `initState()`, panggil `OrderCubit.fetchOrders()`
2. Listen OrderCubit dengan BlocBuilder
3. Tampilkan list orders
4. Navigasi ke OrderDetailPage saat item diklik

---

### 10. order_detail_page.dart (Pekan 5)
**Fungsi**: Halaman detail pesanan

**Langkah**:
1. Terima `Order` sebagai parameter
2. Tampilkan semua detail pesanan
3. Tampilkan status pesanan

---

### 11. profile_page.dart (Pekan 5)
**Fungsi**: Halaman profil

**Langkah**:
1. Ambil user data dari StorageService atau AuthCubit
2. Tampilkan informasi user
3. Tombol logout:
   ```dart
   onPressed: () {
     context.read<AuthCubit>().logout();
     Navigator.pushReplacement(
       context,
       MaterialPageRoute(builder: (context) => LoginPage()),
     );
   }
   ```

---

### 12. menu_page.dart & favorites_page.dart
**Fungsi**: Halaman menu dan favorit (opsional, bisa dibuat nanti)

## 🔧 Langkah Pengerjaan

### Pekan 1: HomePage dengan Data Statis
1. Buat HomePage dengan list makanan statis
2. Tampilkan dengan GridView
3. Gunakan FoodCardWidget

### Pekan 2: FoodDetailPage & Navigasi
1. Buat FoodDetailPage
2. Implementasi navigasi dari HomePage
3. Passing data FoodItem ke FoodDetailPage

### Pekan 3: CartPage
1. Buat CartPage
2. Integrasi dengan CartCubit
3. Implementasi update quantity dan hapus item

### Pekan 4: HomePage dengan API
1. Update HomePage untuk fetch data dari API
2. Tambahkan loading dan error handling

### Pekan 5: Authentication & Checkout
1. Buat LoginPage dan RegisterPage
2. Buat CheckoutPage
3. Buat OrderHistoryPage dan OrderDetailPage
4. Buat ProfilePage

## 💡 Tips

1. **Gunakan StatelessWidget jika tidak perlu state lokal**
2. **Gunakan StatefulWidget jika perlu state lokal** (contoh: form input)
3. **Passing data dengan constructor parameter**
4. **Gunakan BlocBuilder untuk listen state dari Cubit**
5. **Gunakan context.read<Cubit>() untuk akses Cubit tanpa listen**

## 📖 Referensi

- Scaffold: https://api.flutter.dev/flutter/material/Scaffold-class.html
- Navigator: https://docs.flutter.dev/cookbook/navigation
- BlocBuilder: https://bloclibrary.dev/#/flutterbloccoreconcepts

## ✅ Checklist

- [ ] Buat SplashPage
- [ ] Buat HomePage dengan data statis (Pekan 1)
- [ ] Buat FoodDetailPage (Pekan 2)
- [ ] Implementasi navigasi antar halaman (Pekan 2)
- [ ] Buat CartPage (Pekan 3)
- [ ] Update HomePage untuk fetch dari API (Pekan 4)
- [ ] Buat LoginPage dan RegisterPage (Pekan 5)
- [ ] Buat CheckoutPage (Pekan 5)
- [ ] Buat OrderHistoryPage (Pekan 5)
- [ ] Buat ProfilePage (Pekan 5)

---

**Lanjut ke**: `lib/widgets/INSTRUKSI.md` untuk membuat reusable widgets.

