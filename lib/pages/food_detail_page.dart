// TODO: Buat halaman FoodDetailPage
// 
// Halaman detail makanan yang dipilih.
// 
// Fungsi:
// - Menampilkan gambar makanan
// - Menampilkan nama, harga, rating, deskripsi
// - Menampilkan opsi ukuran (jika ada)
// - Menampilkan extra items yang bisa ditambahkan
// - Input special instructions
// - Tombol "Add to Cart" yang memanggil CartCubit.addToCart()
// - Navigasi ke CartPage setelah add to cart
//
// Widget yang digunakan:
// - Scaffold dengan AppBar
// - Image untuk gambar makanan
// - Text untuk informasi makanan
// - Radio atau Chip untuk pilih ukuran
// - CheckboxListTile untuk extra items
// - TextField untuk special instructions
// - ElevatedButton untuk add to cart
// - BlocBuilder untuk listen CartCubit
//
// Lihat INSTRUKSI.md di folder pages/ untuk panduan lengkap.
import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../widgets/food_detail_header.dart';
import '../widgets/food_image_section.dart';
import '../widgets/food_info_section.dart';
import '../widgets/ingredients_section.dart';
import '../widgets/size_selection_section.dart';
import '../widgets/extras_section.dart';
import '../widgets/special_instructions_section.dart';
import '../widgets/reviews_section.dart';
import '../widgets/add_to_cart_section.dart';

class FoodDetailPage extends StatefulWidget {
  final FoodItem foodItem;
  static const String routeName = '/food-detail';
  const FoodDetailPage({super.key, required this.foodItem});

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  String selectedSize = '';
  bool isFavorite = false;
  Set<String> selectedExtras = {};
  TextEditingController specialInstructionsController = TextEditingController();
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    // Set default size to the first option
    if (widget.foodItem.sizeOptions.isNotEmpty) {
      selectedSize = widget.foodItem.sizeOptions.keys.first;
    }
  }

  @override
  void dispose() {
    specialInstructionsController.dispose();
    super.dispose();
  }

  double getTotalPrice() {
    double basePrice = widget.foodItem.price;

    // Add size price
    if (widget.foodItem.sizeOptions.isNotEmpty && selectedSize.isNotEmpty) {
      basePrice += widget.foodItem.sizeOptions[selectedSize] ?? 0.0;
    }

    // Add extras price
    double extrasPrice = 0.0;
    for (String extraId in selectedExtras) {
      final extra = widget.foodItem.extras.firstWhere(
        (e) => e.id == extraId,
        orElse: () => widget.foodItem.extras.first,
      );
      extrasPrice += extra.price;
    }

    return (basePrice + extrasPrice) * quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            FoodDetailHeader(
              title: 'Food Details',
              isFavorite: isFavorite,
              onBackPressed: () => Navigator.pop(context),
              onFavoritePressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Food Image
                    FoodImageSection(
                      imageUrl: widget.foodItem.imageUrl,
                      rating: widget.foodItem.rating,
                    ),
                    // Food Info
                    FoodInfoSection(
                      name: widget.foodItem.name,
                      description: widget.foodItem.description,
                      price: widget.foodItem.price,
                      deliveryTime: widget.foodItem.deliveryTime,
                    ),
                    // Ingredients
                    IngredientsSection(
                      ingredients: widget.foodItem.ingredients,
                    ),
                    // Size Selection
                    SizeSelectionSection(
                      sizeOptions: widget.foodItem.sizeOptions,
                      selectedSize: selectedSize,
                      onSizeSelected: (size) {
                        setState(() {
                          selectedSize = size;
                        });
                      },
                    ),
                    // Extras
                    ExtrasSection(
                      extras: widget.foodItem.extras,
                      selectedExtras: selectedExtras,
                      onExtraChanged: (extraId, isSelected) {
                        setState(() {
                          if (isSelected) {
                            selectedExtras.add(extraId);
                          } else {
                            selectedExtras.remove(extraId);
                          }
                        });
                      },
                    ),
                    // Special Instructions
                    SpecialInstructionsSection(
                      controller: specialInstructionsController,
                    ),
                    // Reviews
                    ReviewsSection(reviews: widget.foodItem.reviews),
                    // Add to Cart
                    AddToCartSection(
                      quantity: quantity,
                      totalPrice: getTotalPrice(),
                      onQuantityDecrease: () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                        }
                      },
                      onQuantityIncrease: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      onAddToCart: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${widget.foodItem.name} (${quantity}x) added to cart!',
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}