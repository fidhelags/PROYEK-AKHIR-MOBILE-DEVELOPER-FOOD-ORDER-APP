// TODO: Buat widget DeliveryOptionsWidget
// 
// Widget untuk memilih opsi pengiriman.
// 
// Parameter:
// - selectedOption (String?): Opsi yang dipilih
// - onOptionSelected (Function(String)): Callback saat opsi dipilih
//
// Menampilkan:
// - Radio buttons atau Dropdown untuk opsi pengiriman
//
// Lihat INSTRUKSI.md di folder widgets/ untuk panduan lengkap.
import 'package:flutter/material.dart';

class OfferBannerWidget extends StatelessWidget {
  final bool isVisible;

  const OfferBannerWidget({super.key, this.isVisible = true});

  @override
  Widget build(BuildContext context) {
    if (!isVisible) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF4CAF50), // Light green
            Color(0xFF388E3C), // Darker green
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Special Offer!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Get 30% off on your first order',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Handle order now button tap
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF4CAF50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'Order Now',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}