# 📦 Dependencies yang Perlu Diinstall

File ini berisi daftar package yang perlu diinstall selama pembelajaran. **Jangan install semua sekaligus!** Install sesuai dengan pekan pembelajaran.

## 🔧 Cara Install Package

Gunakan command berikut untuk install package:

```bash
flutter pub add <package_name>
```

Contoh:
```bash
flutter pub add flutter_bloc
```

Atau edit `pubspec.yaml` secara manual, lalu jalankan:
```bash
flutter pub get
```

---

## 📅 Dependencies per Pekan

### Pekan 1-2: UI Dasar
**Tidak perlu install package tambahan** - cukup menggunakan Flutter SDK default.

---

### Pekan 3: State Management

**Package yang perlu diinstall**:

```bash
flutter pub add flutter_bloc
```

**Kegunaan**: 
- State management dengan Cubit
- Digunakan untuk CartCubit

**Versi yang direkomendasikan**: `^8.1.6`

**Cara menggunakan**:
- Import: `import 'package:flutter_bloc/flutter_bloc.dart';`
- Lihat `lib/cubit/INSTRUKSI.md` untuk detail penggunaan

---

### Pekan 4: Integrasi API

**Package yang perlu diinstall**:

```bash
flutter pub add http
```

**Kegunaan**: 
- HTTP request ke backend API
- Digunakan di ApiService

**Versi yang direkomendasikan**: `^1.1.0`

**Cara menggunakan**:
- Import: `import 'package:http/http.dart' as http;`
- Lihat `lib/services/INSTRUKSI.md` untuk detail penggunaan

---

### Pekan 5: Authentication & Local Storage

**Package yang perlu diinstall**:

```bash
# Untuk local storage
flutter pub add hive
flutter pub add hive_flutter
flutter pub add path_provider
```

**Kegunaan**: 
- `hive` & `hive_flutter`: Local storage untuk menyimpan token dan user data
- `path_provider`: Helper untuk mendapatkan path storage

**Versi yang direkomendasikan**: 
- `hive: ^2.2.3`
- `hive_flutter: ^1.1.0`
- `path_provider: ^2.1.1`

**Cara menggunakan**:
- Import: `import 'package:hive_flutter/hive_flutter.dart';`
- Lihat `lib/services/INSTRUKSI.md` untuk detail penggunaan

---

## 📋 Daftar Lengkap Dependencies

Berikut adalah daftar lengkap semua package yang akan digunakan (untuk referensi):

### Wajib (Required)

1. **flutter_bloc** `^8.1.6`
   - Install di: Pekan 3
   - Untuk: State management

2. **http** `^1.1.0`
   - Install di: Pekan 4
   - Untuk: HTTP requests

3. **hive** `^2.2.3`
   - Install di: Pekan 5
   - Untuk: Local storage

4. **hive_flutter** `^1.1.0`
   - Install di: Pekan 5
   - Untuk: Local storage (Flutter integration)

5. **path_provider** `^2.1.1`
   - Install di: Pekan 5
   - Untuk: Path helper untuk storage

### Opsional (Optional)

Package berikut bisa diinstall jika diperlukan, tapi tidak wajib:

1. **equatable** `^2.0.7`
   - Untuk: Compare objects dengan mudah
   - Bisa digunakan di model untuk membandingkan object

2. **flutter_svg** `^2.0.9`
   - Untuk: Menampilkan SVG icons
   - Jika menggunakan SVG icons dari assets

3. **slide_switcher** `^1.1.2`
   - Untuk: UI components (switch widget)
   - Jika ingin menggunakan komponen UI tambahan

---

## ⚠️ Catatan Penting

1. **Jangan install semua sekaligus!**
   - Install sesuai dengan pekan pembelajaran
   - Ini membantu kamu memahami kegunaan setiap package

2. **Versi Package**
   - Versi yang disebutkan adalah versi yang sudah ditest
   - Bisa menggunakan versi terbaru, tapi pastikan kompatibel

3. **Setelah Install**
   - Selalu jalankan `flutter pub get` setelah menambah package
   - Restart aplikasi jika perlu

4. **Troubleshooting**
   - Jika ada error setelah install, coba:
     ```bash
     flutter clean
     flutter pub get
     ```
   - Pastikan Flutter SDK versi terbaru

---

## 📖 Referensi

- Flutter Packages: https://pub.dev/
- flutter_bloc: https://pub.dev/packages/flutter_bloc
- http: https://pub.dev/packages/http
- hive: https://pub.dev/packages/hive

---

**Selamat belajar!** 🚀

