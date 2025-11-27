// TODO: Buat halaman CheckoutPage
// 
// Halaman checkout untuk menyelesaikan pesanan.
// 
// Fungsi:
// - Form input alamat pengiriman
// - Pilih metode pembayaran (radio button)
// - Pilih opsi pengiriman
// - Input promo code (opsional)
// - Input special instructions (opsional)
// - Menampilkan ringkasan pesanan
// - Tombol "Place Order" yang memanggil CheckoutCubit.createOrder()
// - Handle loading dan error state
// - Navigasi ke OrderHistoryPage setelah berhasil
//
// Widget yang digunakan:
// - Scaffold dengan AppBar
// - TextField untuk alamat
// - Radio untuk metode pembayaran
// - Dropdown untuk opsi pengiriman
// - TextField untuk promo code dan special instructions
// - CheckoutOrderSummaryWidget
// - ElevatedButton untuk place order
// - BlocBuilder untuk listen CheckoutCubit
//
// Lihat INSTRUKSI.md di folder pages/ untuk panduan lengkap.
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CheckoutState {}
class CheckoutInitial extends CheckoutState {}
class CheckoutLoading extends CheckoutState {}
class CheckoutSuccess extends CheckoutState { final String orderId; CheckoutSuccess(this.orderId); }
class CheckoutError extends CheckoutState { final String message; CheckoutError(this.message); }

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
  Future<void> createOrder({required Map<String, dynamic> orderData}) async {
    emit(CheckoutLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      
      emit(CheckoutSuccess('ORD-${DateTime.now().millisecondsSinceEpoch}'));
    } catch (e) {
      emit(CheckoutError('Gagal membuat pesanan: ${e.toString()}'));
    }
  }
}
class OrderTotals {
  final double subtotal;
  final double tax;
  final double deliveryFee;
  final double total;

  OrderTotals({required this.subtotal, required this.tax, required this.deliveryFee, required this.total});
}
class CartCubit {

  OrderTotals get orderTotals => OrderTotals(
    subtotal: 50000.0,
    tax: 5000.0,
    deliveryFee: 10000.0,
    total: 65000.0,
  );
  List<dynamic> get cartItems => [
    {'id': 'ci1', 'name': 'Nasi Goreng', 'quantity': 1},
    {'id': 'ci2', 'name': 'Es Jeruk', 'quantity': 2},
  ];
}
class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  static const String routeName = '/checkout';

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController _addressController = TextEditingController(text: 'Jl. Contoh No. 123, Kota Flutter');
  final TextEditingController _promoCodeController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _selectedPaymentMethod = 'COD'; 
  String _selectedDeliveryOption = 'Standard';
  final List<String> _paymentMethods = ['COD', 'E-Wallet', 'Transfer Bank'];
  final List<String> _deliveryOptions = ['Standard', 'Express (Tambahan Rp 15.000)'];

  @override
  void dispose() {
    _addressController.dispose();
    _promoCodeController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  void _placeOrder(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final cartCubit = context.read<CartCubit>();
    final checkoutCubit = context.read<CheckoutCubit>();

    final orderData = {
      'items': cartCubit.cartItems, 
      'subtotal': cartCubit.orderTotals.subtotal,
      'deliveryAddress': _addressController.text,
      'paymentMethod': _selectedPaymentMethod,
      'deliveryOption': _selectedDeliveryOption,
      'promoCode': _promoCodeController.text.trim(),
      'specialInstructions': _instructionsController.text.trim(),
    };
    
    checkoutCubit.createOrder(orderData: orderData);
  }

  @override
  Widget build(BuildContext context) {
    final totals = context.read<CartCubit>().orderTotals;
    
    return BlocListener<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        if (state is CheckoutSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Pesanan Berhasil Dibuat! ID: ${state.orderId}'),
              backgroundColor: Colors.green,
            ),
          );;
        } else if (state is CheckoutError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal: ${state.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
          backgroundColor: const Color(0xFFE57373),
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Alamat Pengiriman', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _addressController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan alamat lengkap Anda',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Alamat tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const Divider(height: 32),

                const Text('Metode Pembayaran', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ..._paymentMethods.map((method) => RadioListTile<String>(
                  title: Text(method),
                  value: method,
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() { _selectedPaymentMethod = value!; });
                  },
                  activeColor: const Color(0xFFE57373),
                )).toList(),
                const Divider(height: 32),

                const Text('Opsi Pengiriman', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                  value: _selectedDeliveryOption,
                  items: _deliveryOptions.map((option) {
                    return DropdownMenuItem(value: option, child: Text(option));
                  }).toList(),
                  onChanged: (value) {
                    setState(() { _selectedDeliveryOption = value!; });
                  },
                ),
                const Divider(height: 32),

                const Text('Kode Promo (Opsional)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  controller: _promoCodeController,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan kode promo jika ada',
                    border: OutlineInputBorder(),
                  ),
                ),
                const Divider(height: 32),

                const Text('Instruksi Tambahan (Opsional)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  controller: _instructionsController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hintText: 'Contoh: Titip di satpam, jangan tekan bel',
                    border: OutlineInputBorder(),
                  ),
                ),
                const Divider(height: 32),

                const Text('Ringkasan Pesanan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                _CheckoutOrderSummaryWidget(totals: totals), 
                const SizedBox(height: 32),
                
                BlocBuilder<CheckoutCubit, CheckoutState>(
                  builder: (context, state) {
                    final bool isLoading = state is CheckoutLoading;
                    
                    return ElevatedButton(
                      onPressed: isLoading ? null : () => _placeOrder(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE57373),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : const Text(
                              'PLACE ORDER',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class _CheckoutOrderSummaryWidget extends StatelessWidget {
  final OrderTotals totals;

  const _CheckoutOrderSummaryWidget({required this.totals});

  Widget _buildRow(String title, double amount, {bool isTotal = false}) {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildRow('Subtotal', totals.subtotal),
          _buildRow('Pajak (Tax)', totals.tax),
          _buildRow('Biaya Pengiriman', totals.deliveryFee),
          const Divider(height: 20),
          _buildRow('Total Pembayaran', totals.total, isTotal: true),
        ],
      ),
    );
  }
}