// TODO: Buat widget AddToCartSection
// 
// Widget untuk section add to cart di detail page.
// 
// Parameter:
// - onAddToCart (Function): Callback saat tombol add to cart diklik
// - isLoading (bool): Status loading
//
// Menampilkan:
// - Tombol "Add to Cart" dengan loading indicator
//
// Lihat INSTRUKSI.md di folder widgets/ untuk panduan lengkap.
import 'package:flutter/material.dart';

class AddToCartSection extends StatelessWidget {
  final int quantity;
  final double totalPrice;
  final VoidCallback onQuantityDecrease;
  final VoidCallback onQuantityIncrease;
  final VoidCallback onAddToCart;

  const AddToCartSection({
    super.key,
    required this.quantity,
    required this.totalPrice,
    required this.onQuantityDecrease,
    required this.onQuantityIncrease,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          // Quantity Selector
          Row(
            children: [
              // Minus Button
              GestureDetector(
                onTap: onQuantityDecrease,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[300]!, width: 1),
                  ),
                  child: Icon(Icons.remove, color: Colors.grey[600], size: 20),
                ),
              ),
              const SizedBox(width: 16),
              // Quantity Display
              Text(
                quantity.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 16),
              // Plus Button
              GestureDetector(
                onTap: onQuantityIncrease,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[300]!, width: 1),
                  ),
                  child: Icon(Icons.add, color: Colors.grey[600], size: 20),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Add to Cart Button
          Expanded(
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ElevatedButton(
                onPressed: onAddToCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Add to Cart -',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '\$${totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}