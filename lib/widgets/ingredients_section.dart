// TODO: Buat widget IngredientsSection
// 
// Widget untuk menampilkan daftar ingredients makanan.
// 
// Parameter:
// - ingredients (List<String>): Daftar ingredients
//
// Menampilkan:
// - List ingredients dengan bullet atau icon
//
// Lihat INSTRUKSI.md di folder widgets/ untuk panduan lengkap.
import 'package:flutter/material.dart';

class IngredientsSection extends StatelessWidget {
  final List<String> ingredients;

  const IngredientsSection({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ingredients',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 12),
          ingredients.isNotEmpty
              ? Row(
                  children: ingredients.map((ingredient) {
                    return Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _getIngredientIcon(ingredient),
                              color: Colors.green[600],
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            ingredient,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                )
              : const Text(
                  'No ingredients available',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  IconData _getIngredientIcon(String ingredient) {
    switch (ingredient.toLowerCase()) {
      case 'beef':
        return Icons.restaurant;
      case 'lettuce':
        return Icons.eco;
      case 'tomato':
        return Icons.circle;
      case 'cheese':
        return Icons.cake;
      case 'mozzarella':
        return Icons.cake;
      case 'tomato sauce':
        return Icons.circle;
      case 'basil':
        return Icons.eco;
      case 'olive oil':
        return Icons.opacity;
      case 'chicken':
        return Icons.restaurant;
      case 'spices':
        return Icons.local_fire_department;
      case 'flour':
        return Icons.circle;
      case 'oil':
        return Icons.opacity;
      case 'salmon':
        return Icons.restaurant;
      case 'herbs':
        return Icons.eco;
      case 'lemon':
        return Icons.circle;
      case 'pepperoni':
        return Icons.restaurant;
      case 'orange':
        return Icons.circle;
      case 'ice':
        return Icons.ac_unit;
      default:
        return Icons.restaurant;
    }
  }
}