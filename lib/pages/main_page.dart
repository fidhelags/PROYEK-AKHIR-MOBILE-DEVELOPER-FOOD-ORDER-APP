// TODO: Buat halaman MainPage
// 
// Halaman utama aplikasi dengan bottom navigation bar.
// 
// Fungsi:
// - Menampilkan bottom navigation dengan tab: Home, Menu, Favorites, Profile
// - Switch antara halaman berdasarkan tab yang dipilih
// - Menggunakan IndexedStack atau PageView untuk switch halaman
//
// Widget yang digunakan:
// - Scaffold dengan bottomNavigationBar
// - IndexedStack atau PageView untuk switch halaman
// - BottomNavigationBar dengan 4 item
//
// Lihat INSTRUKSI.md di folder pages/ untuk panduan lengkap.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cart_cubit.dart';
import 'home_page.dart';
import 'menu_page.dart';
import 'cart_page.dart';
import 'favorites_page.dart';

class MainPage extends StatefulWidget {
  static const String routeName = '/main';
  
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const MenuPage(),
    const CartPage(),
    const FavoritesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),

      ///
      /// 🔥 BlocBuilder agar cart badge mengikuti perubahan jumlah item
      ///
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          int cartItemCount =
              state is CartLoaded ? state.itemCount : 0;

          return NavigationBar(
            backgroundColor: Colors.white,
            selectedIndex: _selectedIndex,
            indicatorColor: Colors.transparent,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            onDestinationSelected: (i) => setState(() => _selectedIndex = i),

            destinations: [
              /// HOME
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home, color: Colors.green),
                label: 'Home',
              ),

              /// MENU
              NavigationDestination(
                icon: Icon(Icons.restaurant_menu_outlined),
                selectedIcon: Icon(Icons.restaurant_menu, color: Colors.green),
                label: 'Menu',
              ),

              /// CART 🔥 dengan badge dinamis
              NavigationDestination(
                icon: _buildCartIcon(cartItemCount, false),
                selectedIcon: _buildCartIcon(cartItemCount, true),
                label: 'Cart',
              ),

              /// FAVORITES
              NavigationDestination(
                icon: Icon(Icons.favorite_outline),
                selectedIcon: Icon(Icons.favorite, color: Colors.green),
                label: 'Favorites',
              ),

              /// PROFILE
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person, color: Colors.green),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }

  ///
  /// 🔥 Widget Badge Cart
  ///
  Widget _buildCartIcon(int count, bool active) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(
          active ? Icons.shopping_cart : Icons.shopping_cart_outlined,
          color: active ? Colors.green : null,
        ),
        if (count > 0)
          Positioned(
            right: -6,
            top: -8,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Text(
                "$count",
                style: const TextStyle(
                    fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
      ],
    );
  }
}
