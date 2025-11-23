# 📚 Instruksi Pengerjaan Project AlFood App

Selamat datang di template project AlFood App! Project ini akan membantu kamu belajar Flutter step-by-step dari minggu 1 hingga minggu 5.

## 🎯 Tujuan Project

Membangun aplikasi Food Order end-to-end menggunakan Flutter, mulai dari UI dasar, integrasi API, manajemen state, hingga deployment aplikasi.

## 📋 Struktur Project

Project ini sudah disiapkan dengan struktur folder yang jelas. Setiap folder memiliki instruksi khusus untuk membantu kamu belajar:

### 📁 lib/models/
**Tujuan**: Menyimpan model data (FoodItem, Category, User, dll)

**Instruksi lengkap**: Lihat `lib/models/INSTRUKSI.md`

**Yang akan kamu pelajari**:
- Cara membuat model class di Dart
- JSON parsing (fromJson, toJson)
- Konsep data modeling

---

### 📁 lib/pages/
**Tujuan**: Menyimpan semua halaman aplikasi (HomePage, LoginPage, CartPage, dll)

**Instruksi lengkap**: Lihat `lib/pages/INSTRUKSI.md`

**Yang akan kamu pelajari**:
- Membuat halaman dengan Scaffold
- Navigasi antar halaman
- Passing data antar halaman
- State management dengan BlocBuilder

---

### 📁 lib/widgets/
**Tujuan**: Menyimpan reusable widgets (FoodCardWidget, CartItemWidget, dll)

**Instruksi lengkap**: Lihat `lib/widgets/INSTRUKSI.md`

**Yang akan kamu pelajari**:
- Konsep widget di Flutter
- Membuat custom widget
- Reusability dan code organization

---

### 📁 lib/services/
**Tujuan**: Menyimpan service untuk API dan storage (ApiService, AuthService, StorageService)

**Instruksi lengkap**: Lihat `lib/services/INSTRUKSI.md`

**Yang akan kamu pelajari**:
- HTTP request dengan package http
- Async/await dan Future
- Error handling
- Local storage dengan Hive
- Cara menggunakan API yang sudah disediakan mentor

---

### 📁 lib/cubit/
**Tujuan**: Menyimpan state management dengan Cubit (AuthCubit, CartCubit, dll)

**Instruksi lengkap**: Lihat `lib/cubit/INSTRUKSI.md`

**Yang akan kamu pelajari**:
- Konsep state management
- Menggunakan Cubit dan BlocProvider
- Managing app state

---

## 🗓️ Alur Pengerjaan (Mengikuti Silabus)

### Pekan 1 - Setup & UI Dasar
1. Setup project (tidak perlu install package tambahan untuk pekan ini)
2. Buat model dasar (FoodItem, Category)
3. Buat HomePage dengan daftar makanan statis
4. **Lihat**: `lib/models/INSTRUKSI.md` dan `lib/pages/INSTRUKSI.md`

### Pekan 2 - Layout & Halaman Detail
1. Buat FoodDetailPage
2. Implementasi navigasi dari HomePage ke FoodDetailPage
3. Buat widget-widget reusable
4. **Lihat**: `lib/pages/INSTRUKSI.md` dan `lib/widgets/INSTRUKSI.md`

### Pekan 3 - State Management & Keranjang
1. **Install package**: `flutter pub add flutter_bloc` (lihat `DEPENDENCIES.md`)
2. Setup Cubit untuk cart management
3. Implementasi CartCubit
4. Buat CartPage
5. Implementasi add to cart dari FoodDetailPage
6. **Lihat**: `lib/cubit/INSTRUKSI.md` dan `lib/pages/INSTRUKSI.md`

### Pekan 4 - Integrasi API
1. **Install package**: `flutter pub add http` (lihat `DEPENDENCIES.md`)
2. Setup ApiService
3. Setup API Base URL di `lib/services/api_service.dart`
4. Fetch data makanan dari API
5. Update HomePage dan FoodDetailPage untuk menggunakan data dari API
6. Error handling dan loading indicator
7. **Lihat**: `lib/services/INSTRUKSI.md` dan `API_DOCUMENTATION.md` (untuk mentor)

### Pekan 5 - Checkout & Authentication
1. **Install packages**: `flutter pub add hive hive_flutter path_provider` (lihat `DEPENDENCIES.md`)
2. Buat AuthService dan AuthCubit
3. Implementasi LoginPage dan RegisterPage
4. Buat CheckoutPage
5. Implementasi CheckoutService dan CheckoutCubit
6. Simpan session user dengan StorageService
7. **Lihat**: `lib/services/INSTRUKSI.md` dan `lib/cubit/INSTRUKSI.md`

---

## 🔧 Setup Awal

1. **Install dependencies**:
   ```bash
   flutter pub get
   ```
   
   **PENTING**: Package akan diinstall secara bertahap sesuai pekan pembelajaran.
   - **Pekan 1-2**: Tidak perlu install package tambahan
   - **Pekan 3**: Install `flutter_bloc`
   - **Pekan 4**: Install `http`
   - **Pekan 5**: Install `hive`, `hive_flutter`, `path_provider`
   
   **Lihat**: `DEPENDENCIES.md` untuk detail lengkap package yang perlu diinstall.

2. **Setup API Base URL** (Pekan 4):
   - Buka `lib/services/api_service.dart`
   - Set `baseUrl = 'http://api-alfood.zero-dev.my.id'` (sudah disediakan mentor)
   - **Lihat**: `lib/services/INSTRUKSI.md` untuk detail

3. **Run aplikasi**:
   ```bash
   flutter run
   ```

---

## 📖 File Penting

- **silabus.md**: Referensi materi pembelajaran mingguan
- **API_DOCUMENTATION.md**: Dokumentasi API untuk mentor (jangan diubah oleh peserta)
- **README.md**: Overview project

---

## ⚠️ Catatan Penting

1. **Jangan Copy-Paste Langsung dari Git Reference**
   - Ada referensi project di: https://github.com/MDhafaR/tamplate-alfoodapp
   - **TETAPI**: Project tersebut masih memiliki bug dan ketidaksesuaian
   - Gunakan hanya sebagai referensi visual/struktur, bukan untuk copy-paste
   - Fokus belajar dan memahami konsep, bukan hanya menyalin kode

2. **Ikuti Instruksi di Setiap Folder**
   - Setiap folder memiliki `INSTRUKSI.md` dengan panduan spesifik
   - Baca instruksi sebelum mulai coding
   - Jangan skip langkah-langkah

3. **Tanyakan Mentor jika Bingung**
   - Jika ada yang tidak jelas, tanyakan ke mentor
   - Jangan stuck terlalu lama di satu masalah

4. **Commit Progress Secara Berkala**
   - Commit setiap kali menyelesaikan satu fitur
   - Ini membantu tracking progress dan rollback jika ada masalah

---

## 🎨 UI Reference

Kamu bisa melihat design UI di Figma:
https://www.figma.com/design/a32ZvvvwBNZijQz3MMQJmT/alfath?node-id=0-1

**Catatan**: UI bisa dibuat kreatif sesuai keinginan, tidak harus sama persis dengan Figma.

---

## 🚀 Selamat Belajar!

Ikuti instruksi di setiap folder dan jangan terburu-buru. Fokus pada pemahaman konsep, bukan hanya menyelesaikan tugas. Good luck! 🎉

