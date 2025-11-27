// TODO: Buat widget HeaderWidget
// 
// Widget reusable untuk header di halaman (biasanya di HomePage).
// 
// Menampilkan:
// - Logo atau nama aplikasi
// - Lokasi pengiriman (opsional)
// - Icon notifikasi atau cart (opsional)
//
// Lihat INSTRUKSI.md di folder widgets/ untuk panduan lengkap.
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Hamburger menu icon
          Icon(Icons.menu, color: Colors.grey[800], size: 24),

          // Center content
          Column(
            children: [
              Text(
                'Food Order',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              Text(
                'Deliver to Home',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),

          // Right side icons
          Row(
            children: [
              // Notification bell with badge
              Stack(
                children: [
                  Icon(
                    Icons.notifications_outlined,
                    color: Colors.grey[800],
                    size: 24,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '2',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              // Profile icon
              Icon(Icons.person_outline, color: Colors.grey[800], size: 24),
            ],
          ),
        ],
      ),
    );
  }
}