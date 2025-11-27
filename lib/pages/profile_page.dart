// TODO: Buat halaman ProfilePage
// 
// Halaman profil user.
// 
// Fungsi:
// - Menampilkan informasi user (nama, email, foto profil)
// - Tombol logout yang clear token dan redirect ke LoginPage
// - Link ke OrderHistoryPage
//
// Widget yang digunakan:
// - Scaffold dengan AppBar
// - CircleAvatar untuk foto profil
// - ListTile untuk informasi user
// - ElevatedButton untuk logout
//
// Lihat INSTRUKSI.md di folder pages/ untuk panduan lengkap.
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
class User {
  final String id;
  final String name;
  final String email;
  final String? profileImageUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImageUrl,
  });
}

abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void logout() {
    print("User logged out. Token cleared.");
  }
}
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0), 
        child: SizedBox(),
      ),
      body: Center(child: Text('Login Page (Redirect Success)')),
    );
  }
}
class OrderHistoryPage extends StatelessWidget {
  static const String routeName = '/order-history';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Pesanan')),
      body: const Center(child: Text('Halaman Riwayat Pesanan')),
    );
  }
}

final User dummyUser = User(
  id: 'u-001',
  name: 'Budi Raharjo',
  email: 'budi.raharjo@email.com',
  profileImageUrl: 'https://i.pravatar.cc/150?u=budi.raharjo', 
);


class ProfilePage extends StatelessWidget {
  final User user;
  const ProfilePage({super.key, required this.user});

  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: const Color(0xFFE57373),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          _buildUserProfileHeader(context, user),
          const Divider(height: 30),

          _buildProfileOption(
            context,
            icon: Icons.history,
            title: 'Riwayat Pesanan',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => OrderHistoryPage(),
              ));
            },
          ),
          
          const Divider(),

          _buildProfileOption(
            context,
            icon: Icons.settings,
            title: 'Pengaturan Akun',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Halaman Pengaturan Akun'))
              );
            },
          ),
          
          const Divider(),
          const SizedBox(height: 40),

          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildUserProfileHeader(BuildContext context, User user) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(user.profileImageUrl ?? 'https://i.pravatar.cc/150?u=default'),
          backgroundColor: Colors.grey.shade200,
        ),
        const SizedBox(height: 16),
        Text(
          user.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildProfileOption(BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFE57373)),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.logout, color: Colors.white),
        label: const Text(
          'LOGOUT',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        onPressed: () {
          context.read<AuthCubit>().logout();
          
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade600,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}