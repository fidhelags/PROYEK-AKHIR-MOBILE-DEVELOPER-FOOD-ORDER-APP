// TODO: Buat widget FoodImageSection
// 
// Widget untuk menampilkan gambar makanan di detail page.
// 
// Parameter:
// - imageUrl (String): URL gambar makanan
//
// Menampilkan:
// - Image dengan aspect ratio yang sesuai
// - Loading indicator saat gambar sedang dimuat
//
// Lihat INSTRUKSI.md di folder widgets/ untuk panduan lengkap.
import 'package:flutter/material.dart';

class FoodImageSection extends StatelessWidget {
  final String imageUrl;
  final double rating;

  const FoodImageSection({
    super.key,
    required this.imageUrl,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.grey[200]),
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              imageUrl,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Rating badge
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green[400],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.white, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    rating.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}