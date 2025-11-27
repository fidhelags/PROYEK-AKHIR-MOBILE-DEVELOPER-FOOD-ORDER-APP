// TODO: Buat halaman OrderHistoryPage
// 
// Halaman riwayat pesanan.
// 
// Fungsi:
// - Menampilkan daftar semua pesanan user
// - Fetch data dari API menggunakan OrderCubit
// - Menampilkan status setiap pesanan
// - Navigasi ke OrderDetailPage saat item diklik
// - Handle empty state jika belum ada pesanan
//
// Widget yang digunakan:
// - Scaffold dengan AppBar
// - ListView untuk menampilkan orders
// - Card untuk setiap order item
// - BlocBuilder untuk listen OrderCubit
//
// Lihat INSTRUKSI.md di folder pages/ untuk panduan lengkap.
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

class Order {
  final String id;
  final DateTime date;
  final double totalAmount;
  final String status; 

  Order({
    required this.id,
    required this.date,
    required this.totalAmount,
    required this.status,
  });
}

abstract class OrderState {}
class OrderInitial extends OrderState {}
class OrderLoading extends OrderState {}
class OrderLoaded extends OrderState {
  final List<Order> orders;
  OrderLoaded(this.orders);
}
class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
}

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  Future<void> fetchOrders() async {
    emit(OrderLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));

      final mockOrders = [
        Order(
          id: 'ORD-1001',
          date: DateTime.now().subtract(const Duration(days: 1)),
          totalAmount: 75000.0,
          status: 'completed',
        ),
        Order(
          id: 'ORD-1002',
          date: DateTime.now().subtract(const Duration(hours: 5)),
          totalAmount: 45000.0,
          status: 'pending',
        ),
        Order(
          id: 'ORD-1003',
          date: DateTime.now().subtract(const Duration(days: 3)),
          totalAmount: 120000.0,
          status: 'canceled',
        ),
      ];

      emit(OrderLoaded(mockOrders));
    } catch (e) {
      emit(OrderError('Gagal memuat riwayat pesanan: ${e.toString()}'));
    }
  }
}
class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  static const String routeName = '/order-history';

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderCubit>().fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pesanan'),
        backgroundColor: const Color(0xFFE57373),
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading || state is OrderInitial) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFE57373)));
          }
          
          if (state is OrderError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${state.message}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () => context.read<OrderCubit>().fetchOrders(),
                      child: const Text('Coba Lagi', style: TextStyle(color: Color(0xFFE57373))),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is OrderLoaded) {
            final orders = state.orders;

            if (orders.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.history, size: 80, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text(
                      'Belum Ada Pesanan',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    const Text('Mulai buat pesanan pertama Anda!'),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return _OrderHistoryItem(
                  order: order,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      '/order-detail',
                      arguments: order.id,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Navigasi ke Detail Pesanan: ${order.id}'))
                    );
                  },
                );
              },
            );
          }
          
          return const Center(child: Text('State tidak valid.'));
        },
      ),
    );
  }
}

class _OrderHistoryItem extends StatelessWidget {
  final Order order;
  final VoidCallback onTap;

  const _OrderHistoryItem({
    required this.order,
    required this.onTap,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'canceled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatStatus(String status) {
    return status[0].toUpperCase() + status.substring(1);
  }

  @override
  @override
  Widget build(BuildContext context) {
    String _formatDate(DateTime date) {
      final d = date.toLocal();
      final day = d.day.toString().padLeft(2, '0');
      const monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
      final month = monthNames[d.month - 1];
      final year = d.year;
      final hour = d.hour.toString().padLeft(2, '0');
      final minute = d.minute.toString().padLeft(2, '0');
      return '$day $month $year, $hour:$minute';
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(order.status).withOpacity(0.1),
          child: Icon(Icons.receipt, color: _getStatusColor(order.status)),
        ),
        title: Text(
          'Pesanan #${order.id.split('-').last}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total: Rp ${order.totalAmount.toStringAsFixed(0)}'),
            Text('Tanggal: ${_formatDate(order.date)}'),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getStatusColor(order.status),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            _formatStatus(order.status),
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }
}