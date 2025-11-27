// TODO: Buat widget BillDetailsWidget
// 
// Widget untuk menampilkan detail tagihan (mirip dengan OrderSummaryWidget).
// 
// Lihat INSTRUKSI.md di folder widgets/ untuk panduan lengkap.
import 'package:flutter/material.dart';

// --- Mock Class untuk Item Keranjang ---
// Kelas ini digunakan untuk struktur data item yang dipesan.
class BillItem {
  final String name;
  final int quantity;
  final double price;

  BillItem({required this.name, required this.quantity, required this.price});

  double get total => quantity * price;
}
// ----------------------------------------

class BillDetailsWidget extends StatelessWidget {
  final List<BillItem> billItems;
  final double subtotal;
  final double tax;
  final double deliveryFee;
  final double discount;
  final double total;

  const BillDetailsWidget({
    Key? key,
    required this.billItems,
    required this.subtotal,
    required this.tax,
    required this.deliveryFee,
    required this.discount,
    required this.total,
  }) : super(key: key);

  // Fungsi helper untuk memformat nilai mata uang (IDR sederhana)
  String _formatCurrency(double amount) {
    // Menggunakan pemformatan sederhana untuk tampilan rupiah
    return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    )}';
  }

  // Widget untuk satu baris detail tagihan (misalnya, Subtotal, Pajak)
  Widget _buildDetailRow(String title, double amount, {bool isTotal = false, Color? valueColor}) {
    final style = TextStyle(
      fontSize: isTotal ? 18.0 : 15.0,
      fontWeight: isTotal ? FontWeight.bold : FontWeight.w400,
      color: valueColor ?? (isTotal ? Colors.redAccent.shade700 : Colors.black87),
    );
    
    // Gaya untuk kolom judul
    final titleStyle = TextStyle(
      fontSize: isTotal ? 18.0 : 15.0,
      fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
      color: Colors.black54,
    );


    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: titleStyle),
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
      // Sudut yang lebih lembut dan elegan
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detail Tagihan',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const Divider(height: 20, thickness: 1.5, color: Colors.grey),

            // --- Daftar Item yang Dipesan ---
            ...billItems.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.quantity}x',
                      style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        item.name,
                        style: const TextStyle(fontSize: 16.0, color: Colors.black87),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
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
            
            const Divider(height: 20, thickness: 0.5),

            // --- Ringkasan Tagihan ---
            _buildDetailRow('Subtotal Barang', subtotal),
            _buildDetailRow('Biaya Pengiriman', deliveryFee),
            
            // Diskon, ditampilkan dengan warna hijau dan negatif
            if (discount > 0)
              _buildDetailRow(
                'Diskon/Promo', 
                -discount, 
                valueColor: Colors.green.shade700
              ),
              
            _buildDetailRow('Pajak (PPN/Lainnya)', tax),

            const Divider(height: 20, thickness: 2, color: Colors.black),

            // --- Total Pembayaran Akhir ---
            _buildDetailRow('Total Pembayaran', total, isTotal: true),
          ],
        ),
      ),
    );
  }
}
