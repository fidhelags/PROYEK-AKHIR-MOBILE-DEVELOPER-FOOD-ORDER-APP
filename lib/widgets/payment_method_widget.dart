// TODO: Buat widget PaymentMethodWidget
// 
// Widget untuk memilih metode pembayaran.
// 
// Parameter:
// - selectedMethod (String?): Metode yang dipilih
// - onMethodSelected (Function(String)): Callback saat metode dipilih
//
// Menampilkan:
// - Radio buttons untuk setiap metode pembayaran
//
// Lihat INSTRUKSI.md di folder widgets/ untuk panduan lengkap.
import 'package:flutter/material.dart';

class PaymentMethodWidget extends StatelessWidget {
  final String? selectedMethod;
  final ValueChanged<String> onMethodSelected;

  const PaymentMethodWidget({
    super.key,
    required this.selectedMethod,
    required this.onMethodSelected,
  });

  // Daftar metode pembayaran yang tersedia
  static const List<String> _availableMethods = [
    'Kartu Kredit/Debit',
    'Transfer Bank',
    'E-Wallet (GoPay/OVO)',
    'Bayar di Tempat (COD)',
  ];

  @override
  Widget build(BuildContext) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pilih Metode Pembayaran',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          
          // List Metode Pembayaran dengan RadioListTile
          ..._availableMethods.map((method) {
            return Column(
              children: [
                RadioListTile<String>(
                  title: Text(method),
                  value: method,
                  groupValue: selectedMethod,
                  onChanged: (String? value) {
                    if (value != null) {
                      onMethodSelected(value);
                    }
                  },
                  activeColor: const Color(0xFFE57373), // Warna utama aplikasi
                  contentPadding: EdgeInsets.zero, // Hapus padding default
                ),
                // Divider untuk memisahkan item (kecuali yang terakhir)
                if (method != _availableMethods.last)
                  const Divider(height: 0, thickness: 1, indent: 16),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}