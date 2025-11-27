// TODO: Buat halaman MenuPage
// 
// Halaman yang menampilkan semua menu makanan.
// 
// Fungsi:
// - Menampilkan semua menu makanan dalam format grid atau list
// - Search functionality untuk mencari makanan
// - Filter berdasarkan kategori
// - Navigasi ke FoodDetailPage saat item diklik
//
// Widget yang digunakan:
// - Scaffold
// - SearchBarWidget
// - FoodCardWidget atau VerticalFoodItemWidget
// - GridView atau ListView
//
// Lihat INSTRUKSI.md di folder pages/ untuk panduan lengkap.
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'food_detail_page.dart';


abstract class FoodState {}
class FoodInitial extends FoodState {}
class FoodLoading extends FoodState {}
class FoodError extends FoodState { final String message; FoodError(this.message); }

class FoodItem {
  final String id;
  final String name;
  final double price;
  final String categoryId;
  final String description;
  FoodItem({required this.id, required this.name, required this.price, required this.categoryId, required this.description});
}

class Category {
  final String id;
  final String name;
  Category({required this.id, required this.name});
}

class FoodCubit extends Cubit<FoodState> {
  String _searchTerm = '';
  String _selectedCategoryId = 'all';

  FoodCubit() : super(FoodInitial());
  
  void setSearchTerm(String term) {
    _searchTerm = term;
    _applyFilterAndSearch();
  }

  void setCategoryFilter(String categoryId) {
    _selectedCategoryId = categoryId;
    _applyFilterAndSearch();
  }
  

  Future<void> fetchInitialData() async {
    emit(FoodLoading());
    await Future.delayed(const Duration(seconds: 1)); 
    emit(FoodLoaded(foodItems: _mockFoodItems, categories: _mockCategories));
  }

  void _applyFilterAndSearch() {
    if (state is! FoodLoaded) return;
    final currentState = state as FoodLoaded;

    final filteredItems = currentState.foodItems.where((item) {
      final nameMatches = item.name.toLowerCase().contains(_searchTerm.toLowerCase());
      final categoryMatches = _selectedCategoryId == 'all' || item.categoryId == _selectedCategoryId;
      return nameMatches && categoryMatches;
    }).toList();
    
    emit(FoodLoaded(foodItems: filteredItems, categories: currentState.categories));
  }

  final List<FoodItem> _mockFoodItems = [
    FoodItem(id: 'f1', name: 'Nasi Goreng Spesial', price: 25000.0, categoryId: 'c1', description: 'Nasi goreng dengan telur, ayam, dan sayuran.'),
    FoodItem(id: 'f2', name: 'Ayam Geprek Sambal Matah', price: 30000.0, categoryId: 'c2', description: 'Ayam krispi dengan sambal matah pedas.'),
    FoodItem(id: 'f3', name: 'Mie Ayam Bakso', price: 20000.0, categoryId: 'c1', description: 'Mie dengan ayam cincang dan bakso sapi.'),
    FoodItem(id: 'f4', name: 'Es Jeruk Manis', price: 10000.0, categoryId: 'c3', description: 'Minuman segar dari perasan jeruk.'),
    FoodItem(id: 'f5', name: 'Sate Ayam Madura', price: 35000.0, categoryId: 'c2', description: 'Sate ayam dengan bumbu kacang khas Madura.'),
  ];
  final List<Category> _mockCategories = [
    Category(id: 'c1', name: 'Nasi & Mie'),
    Category(id: 'c2', name: 'Ayam & Daging'),
    Category(id: 'c3', name: 'Minuman'),
  ];
}
class FoodLoaded extends FoodState {
  final List<FoodItem> foodItems;
  final List<Category> categories;
  FoodLoaded({required this.foodItems, required this.categories});
}
class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}
class _MenuPageState extends State<MenuPage> {
  String _searchTerm = '';
  String _selectedCategoryId = 'all';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FoodCubit>().fetchInitialData();
    });
  }

  List<FoodItem> _filterAndSearch(List<FoodItem> items) {
    return items.where((item) {
      final nameMatches = item.name.toLowerCase().contains(_searchTerm.toLowerCase());
      final categoryMatches = _selectedCategoryId == 'all' || item.categoryId == _selectedCategoryId;
      return nameMatches && categoryMatches;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semua Menu'),
        backgroundColor: const Color(0xFFE57373),
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<FoodCubit, FoodState>(
        builder: (context, state) {

          if (state is FoodLoading || state is FoodInitial) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFE57373)));
          }

          if (state is FoodError) {
            return Center(child: Text('Gagal memuat menu: ${state.message}'));
          }

          if (state is FoodLoaded) {
            final allItems = state.foodItems;
            final categories = state.categories;
            final filteredItems = _filterAndSearch(allItems);

            return Column(
              children: [
                _SearchBarWidget(
                  onChanged: (term) {
                    setState(() {
                      _searchTerm = term;
                    });
                  },
                ),
                
                _buildCategoryFilter(categories),

                Expanded(
                  child: filteredItems.isEmpty
                      ? const Center(child: Text('Menu tidak ditemukan.'))
                      : GridView.builder(
                          padding: const EdgeInsets.all(12.0),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, 
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 0.7, 
                          ),
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = filteredItems[index];
                            return _FoodCardWidget( 
                              foodItem: item,
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  FoodDetailPage.routeName,
                                  arguments: item,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Detail: ${item.name}'))
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildCategoryFilter(List<Category> categories) {
    final allCategories = [Category(id: 'all', name: 'Semua')] + categories;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: allCategories.length,
          itemBuilder: (context, index) {
            final category = allCategories[index];
            final isSelected = _selectedCategoryId == category.id;
            
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ChoiceChip(
                label: Text(category.name),
                selected: isSelected,
                selectedColor: const Color(0xFFE57373),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                onSelected: (selected) {
                  setState(() {
                    _selectedCategoryId = category.id;
                    _searchTerm = '';
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
class _SearchBarWidget extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const _SearchBarWidget({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Cari makanan...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        ),
      ),
    );
  }
}

class _FoodCardWidget extends StatelessWidget {
  final FoodItem foodItem;
  final VoidCallback onTap;

  const _FoodCardWidget({required this.foodItem, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(
                  'https://picsum.photos/400/300?foodId=${foodItem.id}', 
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foodItem.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp ${foodItem.price.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 18, color: Color(0xFFE57373), fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.add_shopping_cart, color: Colors.grey.shade600, size: 20),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}