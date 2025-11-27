// TODO: Buat halaman OrderDetailPage
// 
// Halaman detail pesanan.
// 
// Fungsi:
// - Menampilkan detail lengkap sebuah pesanan
// - Menampilkan semua item yang dipesan
// - Menampilkan alamat pengiriman
// - Menampilkan metode pembayaran
// - Menampilkan status pesanan
// - Menampilkan total harga
//
// Widget yang digunakan:
// - Scaffold dengan AppBar
// - ListView untuk menampilkan detail
// - Card untuk setiap section
//
// Lihat INSTRUKSI.md di folder pages/ untuk panduan lengkap.
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem {
  final String name;
  final int quantity;
  final double unitPrice;
  final String? selectedSize;
  final List<String> selectedExtras;

  OrderItem({
    required this.name,
    required this.quantity,
    required this.unitPrice,
    this.selectedSize,
    this.selectedExtras = const [],
  });
  
  double get totalPrice => unitPrice * quantity;
}
class Order {
  final String id;
  final DateTime date;
  final double subtotal;
  final double tax;
  final double deliveryFee;
  final double totalAmount;
  final String status;
  final String deliveryAddress;
  final String paymentMethod;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.date,
    required this.subtotal,
    required this.tax,
    required this.deliveryFee,
    required this.totalAmount,
    required this.status,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.items,
  });
}

final Order dummyOrder = Order(
  id: 'ORD-1002',
  date: DateTime.now().subtract(const Duration(hours: 5)),
  subtotal: 45000.0,
  tax: 4500.0,
  deliveryFee: 10000.0,
  totalAmount: 59500.0,
  status: 'pending',
  deliveryAddress: 'Jl. Contoh No. 123, Blok C, Jakarta Selatan. Dekat pos satpam.',
  paymentMethod: 'E-Wallet (Gopay)',
  items: [
    OrderItem(
      name: 'Ayam Geprek Sambal Matah',
      quantity: 1,
      unitPrice: 30000.0,
      selectedSize: 'Medium',
      selectedExtras: ['Tambahan Nasi'],
    ),
    OrderItem(
      name: 'Es Teh Manis',
      quantity: 2,
      unitPrice: 7500.0,
      selectedSize: null,
      selectedExtras: [],
    ),
  ],
);
class OrderDetailPage extends StatelessWidget {
  final Order order;
  const OrderDetailPage({super.key, required this.order});

  static const String routeName = '/order-detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pesanan #${order.id.split('-').last}'),
        backgroundColor: const Color(0xFFE57373),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          _buildStatusCard(order.status),
          
          const SizedBox(height: 16),
          
          _buildItemsCard(order.items),
          
          const SizedBox(height: 16),
          
          _buildInfoCard(
            title: 'Informasi Pengiriman',
            icon: Icons.location_on_outlined,
            details: [
              _buildDetailRow('Alamat', order.deliveryAddress),
              _buildDetailRow('Metode Pembayaran', order.paymentMethod),
              _buildDetailRow('Tanggal Pesan', DateFormat('dd MMM yyyy, HH:mm').format(order.date)),
            ],
          ),

          const SizedBox(height: 16),
          
          _buildSummaryCard(order),
        ],
      ),
    );
  }

  Widget _buildStatusCard(String status) {
    String formattedStatus = status[0].toUpperCase() + status.substring(1);
    Color statusColor;

    switch (status.toLowerCase()) {
      case 'completed':
        statusColor = Colors.green;
        break;
      case 'pending':
        statusColor = Colors.orange;
        break;
      case 'canceled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      elevation: 3,
      child: ListTile(
        leading: Icon(Icons.info_outline, color: statusColor, size: 30),
        title: const Text('Status Pesanan', style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          formattedStatus,
          style: TextStyle(
            color: statusColor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildItemsCard(List<OrderItem> items) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Item Pesanan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${item.quantity}x', style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.name, style: const TextStyle(fontWeight: FontWeight.w500)),
                        if (item.selectedSize != null) 
                          Text('Ukuran: ${item.selectedSize}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        if (item.selectedExtras.isNotEmpty)
                          Text('Extras: ${item.selectedExtras.join(', ')}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                  Text('Rp ${item.totalPrice.toStringAsFixed(0)}'),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required IconData icon, required List<Widget> details}) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFFE57373)),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            ...details,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
          const Text(': '),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(Order order) {
    Widget buildTotalRow(String title, double amount, {bool isTotal = false}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: isTotal ? 18 : 16,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Text(
              'Rp ${amount.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: isTotal ? 18 : 16,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? const Color(0xFFE57373) : Colors.black87,
              ),
            ),
          ],
        ),
      );
    }

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ringkasan Harga',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            buildTotalRow('Subtotal', order.subtotal),
            buildTotalRow('Pajak (Tax)', order.tax),
            buildTotalRow('Biaya Pengiriman', order.deliveryFee),
            const Divider(height: 20, thickness: 2),
            buildTotalRow('Total Pembayaran', order.totalAmount, isTotal: true),
          ],
        ),
      ),
    );
  }
}