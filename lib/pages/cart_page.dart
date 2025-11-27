// TODO: Buat halaman CartPage
// 
// Halaman keranjang belanja.
// 
// Fungsi:
// - Menampilkan semua item di cart
// - Update quantity item (tambah/kurang)
// - Hapus item dari cart
// - Menampilkan subtotal, tax, delivery fee, dan total
// - Tombol "Checkout" yang navigasi ke CheckoutPage
// - Handle empty cart state
//
// Widget yang digunakan:
// - Scaffold dengan AppBar
// - ListView untuk menampilkan cart items
// - CartItemWidget untuk setiap item
// - OrderSummaryWidget untuk ringkasan harga
// - ElevatedButton untuk checkout
// - BlocBuilder untuk listen CartCubit
//
// Lihat INSTRUKSI.md di folder pages/ untuk panduan lengkap.
import 'package:flutter/material.dart';
import '../widgets/cart_item_widget.dart';
import '../widgets/delivery_info_widget.dart';
import '../widgets/promo_code_widget.dart';
import '../widgets/order_summary_widget.dart';
import '../models/cart_item.dart';
import '../models/food_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // Show more options
            },
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          // TODO: Implement state management for cart data
          final cartItems = _getStaticCartItems();
          final subtotal = _calculateSubtotal(cartItems);
          final deliveryFee = 0.0;
          final tax = subtotal * 0.08;
          final total = subtotal + deliveryFee + tax;

          if (cartItems.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add some delicious food to get started!',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Cart Items Section
                      ...cartItems.map(
                        (cartItem) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: CartItemWidget(cartItem: cartItem),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Delivery Information Section
                      const DeliveryInfoWidget(),

                      const SizedBox(height: 20),

                      // Promo Code Section
                      const PromoCodeWidget(),

                      const SizedBox(height: 20),

                      // Order Summary Section
                      OrderSummaryWidget(
                        subtotal: subtotal,
                        deliveryFee: deliveryFee,
                        tax: tax,
                        total: total,
                      ),

                      const SizedBox(height: 100), // Space for bottom bar
                    ],
                  ),
                ),
              ),

              // Bottom Action Bar
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Total Amount',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Text(
                          '\$${total.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to checkout
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Proceeding to checkout...'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Proceed to Checkout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // TODO: Replace with state management
  List<CartItem> _getStaticCartItems() {
    return [
      CartItem(
        id: '1',
        foodItem: FoodItem(
          id: '1',
          name: 'Chicken Burger',
          description: 'With cheese, lettuce & tomato',
          price: 12.99,
          rating: 4.8,
          imageUrl: 'assets/images/classic-beef-burger.jpeg',
          category: 'Burger',
        ),
        quantity: 2,
      ),
      CartItem(
        id: '2',
        foodItem: FoodItem(
          id: '2',
          name: 'French Fries',
          description: 'Large portion with sea salt',
          price: 6.99,
          rating: 4.5,
          imageUrl: 'assets/images/crispy-chicken-wings.jpeg',
          category: 'Side',
        ),
        quantity: 1,
      ),
      CartItem(
        id: '3',
        foodItem: FoodItem(
          id: '3',
          name: 'Coca Cola',
          description: '500ml bottle, chilled',
          price: 2.99,
          rating: 4.0,
          imageUrl: 'assets/images/margherita-pizza.png',
          category: 'Drink',
        ),
        quantity: 3,
      ),
    ];
  }

  double _calculateSubtotal(List<CartItem> cartItems) {
    return cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }
}