# 🍔 AlFood App - Template Project Flutter Bootcamp

Template project untuk bootcamp Mobile Developer dengan Flutter. Project ini akan membantu peserta belajar step-by-step dari minggu 1 hingga minggu 5.

## 📚 Tentang Project

AlFood App adalah aplikasi Food Order yang dibangun dengan Flutter. Peserta akan belajar:
- Dasar Flutter & Dart
- UI Development
- State Management dengan Cubit
- Integrasi API
- Authentication
- Local Storage

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (versi terbaru)
- Android Studio / VS Code
- Emulator atau device fisik

### Installation

1. Clone repository ini
2. Install dependencies dasar:
   ```bash
   flutter pub get
   ```
   
   **Catatan**: Package akan diinstall secara bertahap sesuai pekan pembelajaran.
   - Lihat `DEPENDENCIES.md` untuk daftar lengkap package yang perlu diinstall.
3. Setup API Base URL (Pekan 4):
   - Buka `lib/services/api_service.dart`
   - Set `baseUrl = 'http://api-alfood.zero-dev.my.id'` (sudah disediakan mentor)
4. Run aplikasi:
   ```bash
   flutter run
   ```

## 📖 Dokumentasi

### Instruksi Utama
Baca **INSTRUKSI.md** di root folder untuk overview dan navigasi ke instruksi spesifik.

### Instruksi per Folder
Setiap folder memiliki instruksi lengkap:
- `lib/models/INSTRUKSI.md` - Cara membuat model data
- `lib/pages/INSTRUKSI.md` - Cara membuat halaman
- `lib/widgets/INSTRUKSI.md` - Cara membuat reusable widgets
- `lib/services/INSTRUKSI.md` - Cara membuat service API
- `lib/cubit/INSTRUKSI.md` - Cara membuat state management

### Dokumentasi API
- `API_DOCUMENTATION.md` - Spesifikasi API untuk mentor (jangan diubah peserta)

### Dependencies
- `DEPENDENCIES.md` - Daftar package yang perlu diinstall per pekan

### Silabus
- `silabus.md` - Referensi materi pembelajaran mingguan

## 📁 Struktur Project

```
lib/
├── models/          # Model data (FoodItem, User, Order, dll)
├── pages/           # Halaman aplikasi (HomePage, LoginPage, dll)
├── widgets/         # Reusable widgets
├── services/        # Service untuk API dan storage
├── cubit/           # State management dengan Cubit
└── main.dart        # Entry point aplikasi
```

## 🗓️ Alur Pembelajaran

### Pekan 1 - Setup & UI Dasar
- Setup project
- Buat model dasar
- Buat HomePage dengan data statis

### Pekan 2 - Layout & Halaman Detail
- Buat FoodDetailPage
- Implementasi navigasi
- Buat reusable widgets

### Pekan 3 - State Management & Keranjang
- Setup Cubit untuk cart
- Buat CartPage
- Implementasi add to cart

### Pekan 4 - Integrasi API
- Setup ApiService
- Fetch data dari API
- Update UI dengan data dinamis

### Pekan 5 - Checkout & Authentication
- Implementasi login/register
- Buat CheckoutPage
- Simpan session user

## ⚠️ Catatan Penting

### ⛔ Jangan Copy-Paste Langsung dari Git Reference

Ada referensi project di: https://github.com/MDhafaR/tamplate-alfoodapp

**TETAPI**:
- Project tersebut masih memiliki **bug** dan **ketidaksesuaian**
- Gunakan hanya sebagai **referensi visual/struktur**, bukan untuk copy-paste
- **Fokus belajar dan memahami konsep**, bukan hanya menyalin kode
- Jika stuck, tanyakan ke mentor, jangan langsung copy dari git

### 📝 Ikuti Instruksi

- Setiap folder memiliki `INSTRUKSI.md` dengan panduan spesifik
- Baca instruksi sebelum mulai coding
- Jangan skip langkah-langkah

### 🎨 UI Design

Kamu bisa melihat design UI di Figma:
https://www.figma.com/design/a32ZvvvwBNZijQz3MMQJmT/alfath?node-id=0-1

**Catatan**: UI bisa dibuat kreatif sesuai keinginan, tidak harus sama persis dengan Figma.

## 🛠️ Dependencies

Package akan diinstall secara bertahap sesuai pekan pembelajaran:

- **Pekan 3**: `flutter_bloc` - State management
- **Pekan 4**: `http` - HTTP requests
- **Pekan 5**: `hive`, `hive_flutter`, `path_provider` - Local storage

**Lihat `DEPENDENCIES.md` untuk detail lengkap dan cara install.**

## 📞 Support

Jika ada pertanyaan atau masalah:
1. Baca instruksi di folder terkait
2. Tanyakan ke mentor
3. Jangan stuck terlalu lama di satu masalah

## 🎯 Tujuan Akhir

Setelah menyelesaikan project ini, peserta diharapkan:
- Memahami dasar Flutter & Dart
- Mampu membuat UI yang baik
- Mampu mengintegrasikan API
- Mampu menggunakan state management
- Mampu membuat aplikasi mobile end-to-end

## 📄 License

Template project untuk bootcamp Mobile Developer.

---

**Selamat Belajar!** 🚀
