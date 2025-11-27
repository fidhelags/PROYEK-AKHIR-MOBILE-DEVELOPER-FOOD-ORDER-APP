// TODO: Buat widget CheckoutOrderSummaryWidget
// 
// Widget untuk menampilkan ringkasan order di checkout page.
// 
// Parameter:
// - cartItems (List<CartItem>): Daftar item di cart
// - subtotal (double)
// - tax (double)
// - deliveryFee (double)
// - discount (double)
// - total (double)
//
// Menampilkan:
// - List item yang dipesan
// - Ringkasan harga
//
// Lihat INSTRUKSI.md di folder widgets/ untuk panduan lengkap.
import 'package:flutter/material.dart';

// --- Mock Class untuk Item Keranjang ---
// Biasanya kelas ini berada di file model/cart_item.dart
class CartItem {
  final String name;
  final int quantity;
  final double price;

  CartItem({required this.name, required this.quantity, required this.price});

  double get total => quantity * price;
}
// ----------------------------------------

class CheckoutOrderSummaryWidget extends StatelessWidget {
  final List<CartItem> cartItems;
  final double subtotal;
  final double tax;
  final double deliveryFee;
  final double discount;
  final double total;

  const CheckoutOrderSummaryWidget({
    Key? key,
    required this.cartItems,
    required this.subtotal,
    required this.tax,
    required this.deliveryFee,
    required this.discount,
    required this.total,
  }) : super(key: key);

  // Fungsi helper untuk memformat nilai mata uang (IDR sederhana)
  String _formatCurrency(double amount) {
    // Implementasi sederhana. Dalam aplikasi nyata, gunakan NumberFormat.
    return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    )}';
  }

  // Widget untuk satu baris ringkasan harga (misalnya, Subtotal, Pajak)
  Widget _buildSummaryRow(String title, double amount, {bool isTotal = false}) {
    final style = TextStyle(
      fontSize: isTotal ? 18.0 : 16.0,
      fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
      color: isTotal ? Colors.deepPurple : Colors.black87,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: style),
          Text(_formatCurrency(amount), style: style),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ringkasan Pesanan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const Divider(height: 20, thickness: 2),

            // --- Daftar Item ---
            ...cartItems.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${item.quantity}x ${item.name}',
                        style: const TextStyle(fontSize: 16.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      _formatCurrency(item.total),
                      style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              );
            }).toList(),
            
            const Divider(height: 20, thickness: 1),

            // --- Ringkasan Harga ---
            _buildSummaryRow('Subtotal', subtotal),
            _buildSummaryRow('Biaya Pengiriman', deliveryFee),
            
            // Baris diskon, ditampilkan hanya jika ada diskon
            if (discount > 0)
              _buildSummaryRow('Diskon', -discount),
              
            _buildSummaryRow('Pajak', tax),

            const Divider(height: 20, thickness: 2, color: Colors.deepPurple),

            // --- Total Pembayaran ---
            _buildSummaryRow('Total Pembayaran', total, isTotal: true),
          ],
        ),
      ),
    );
  }
}
