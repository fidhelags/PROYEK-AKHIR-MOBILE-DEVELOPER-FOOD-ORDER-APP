// TODO: Buat halaman HomePage
// 
// Halaman utama yang menampilkan daftar makanan.
// 
// Fungsi:
// - Menampilkan header dengan search bar
// - Menampilkan kategori makanan (horizontal list)
// - Menampilkan daftar makanan (grid atau list view)
// - Filter makanan berdasarkan kategori yang dipilih
// - Navigasi ke FoodDetailPage saat item diklik
// - Fetch data makanan dari API menggunakan Cubit
//
// Widget yang digunakan:
// - Scaffold
// - CustomHeaderWidget (lihat widgets/)
// - SearchBarWidget (lihat widgets/)
// - CategoryItemWidget (lihat widgets/)
// - FoodCardWidget (lihat widgets/)
// - GridView atau ListView
// - BlocBuilder untuk listen data dari API
//
// Lihat INSTRUKSI.md di folder pages/ untuk panduan lengkap.
import 'package:flutter/material.dart';
import '../widgets/header_widget.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/category_item_widget.dart';
import '../widgets/offer_banner_widget.dart';
import '../widgets/view_switcher.dart';
import '../widgets/food_card_widget.dart';
import '../widgets/vertical_food_item_widget.dart';
import '../models/category.dart';
import '../models/food_item.dart';
import '../models/mock_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Category> categories = [];
  List<FoodItem> foodItems = [];
  String? selectedCategoryId; // Changed to nullable to allow no selection
  bool showOfferBanner = true; // Parameter to control offer banner visibility
  bool isGridView = false; // State to control view mode

  @override
  void initState() {
    super.initState();
    categories = MockData.getCategories();
    foodItems = MockData.getFoodItems();
  }

  void _selectCategory(String categoryId) {
    setState(() {
      // If clicking the same category, deselect it
      if (selectedCategoryId == categoryId) {
        selectedCategoryId = null;
        categories = categories.map((category) {
          return category.copyWith(isSelected: false);
        }).toList();
      } else {
        // Select new category
        selectedCategoryId = categoryId;
        categories = categories.map((category) {
          return category.copyWith(isSelected: category.id == categoryId);
        }).toList();
      }
    });
  }

  void _onViewChanged(bool isGridView) {
    setState(() {
      this.isGridView = isGridView;
    });
  }

  double _calculateGridHeight(int itemCount) {
    const double crossAxisCount = 2;
    const double childAspectRatio = 0.75;
    const double mainAxisSpacing = 16;

    // Calculate number of rows needed
    final double rowCount = (itemCount / crossAxisCount).ceil().toDouble();

    // Calculate height of each item
    // We need to estimate the width first, then calculate height based on aspect ratio
    final double screenWidth = MediaQuery.of(context).size.width;
    final double availableWidth =
        screenWidth - 40; // Subtract horizontal padding
    final double itemWidth =
        (availableWidth - 16) / 2; // Subtract spacing between items
    final double itemHeight = itemWidth / childAspectRatio;

    // Calculate total height
    final double totalHeight =
        (rowCount * itemHeight) + ((rowCount - 1) * mainAxisSpacing);

    return totalHeight + 20; // Add bottom spacing
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderWidget(),
              const SizedBox(height: 20),
              const SearchBarWidget(),
              const SizedBox(height: 24),
              // Categories Section
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return CategoryItemWidget(
                            category: categories[index],
                            onTap: () => _selectCategory(categories[index].id),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Offer Banner
              OfferBannerWidget(isVisible: showOfferBanner),
              const SizedBox(height: 24),
              // Food Items Section
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Popular Dishes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        ViewSwitcher(onViewChanged: _onViewChanged),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Conditional rendering based on view mode
                    isGridView
                        ? SizedBox(
                            height: _calculateGridHeight(foodItems.length),
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.75,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                  ),
                              itemCount: foodItems.length,
                              itemBuilder: (context, index) {
                                return FoodCardWidget(
                                  foodItem: foodItems[index],
                                );
                              },
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: foodItems.length,
                            itemBuilder: (context, index) {
                              return VerticalFoodItemWidget(
                                foodItem: foodItems[index],
                              );
                            },
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}