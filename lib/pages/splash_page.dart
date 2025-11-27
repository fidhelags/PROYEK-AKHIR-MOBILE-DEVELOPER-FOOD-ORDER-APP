// TODO: Buat halaman SplashPage
// 
// Halaman ini adalah halaman pertama yang muncul saat aplikasi dibuka.
// 
// Fungsi:
// - Menampilkan logo/splash screen
// - Mengecek apakah user sudah login (cek token di storage)
// - Jika sudah login, redirect ke MainPage
// - Jika belum login, redirect ke LoginPage
//
// Widget yang digunakan:
// - Scaffold
// - Center
// - Image atau Icon untuk logo
// - FutureBuilder atau initState untuk cek authentication
//
// Lihat INSTRUKSI.md di folder pages/ untuk panduan lengkap.
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import '../services/storage_service.dart';
import 'main_page.dart'; 
import 'login_page.dart'; 

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const String routeName = '/splash';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  @override
  void initState() {
    super.initState();
    _checkAuthenticationStatus();
  }

  void _checkAuthenticationStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    final isLoggedIn = StorageService.isAuthenticated();

    if (isLoggedIn) {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(MainPage.routeName);
      }
    } else {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.restaurant_menu,
              size: 100,
              color: Color(0xFFE57373),
            ),
            SizedBox(height: 16),
            Text(
              'Food Delivery App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 50),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE57373)),
            ),
          ],
        ),
      ),
    );
  }
}