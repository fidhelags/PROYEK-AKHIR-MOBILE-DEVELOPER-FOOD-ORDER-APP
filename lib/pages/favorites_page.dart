// TODO: Buat halaman FavoritesPage
// 
// Halaman favorit makanan (opsional, bisa diimplementasikan nanti).
// 
// Fungsi:
// - Menampilkan daftar makanan yang difavoritkan user
// - Bisa diimplementasikan di minggu berikutnya jika ada waktu
//
// Lihat INSTRUKSI.md di folder pages/ untuk panduan lengkap.
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
class FoodItem {
  final String id;
  final String name;
  final double price;
  final double rating;
  final String description;
  FoodItem({required this.id, required this.name, required this.price, required this.rating, required this.description});
}

abstract class FavoritesState {}
class FavoritesInitial extends FavoritesState {}
class FavoritesLoading extends FavoritesState {}
class FavoritesLoaded extends FavoritesState {
  final List<FoodItem> favoriteItems;
  FavoritesLoaded(this.favoriteItems);
}
class FavoritesError extends FavoritesState {
  final String message;
  FavoritesError(this.message);
}

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  Future<void> fetchFavorites() async {
    emit(FavoritesLoading());
    try {
      await Future.delayed(const Duration(seconds: 1)); 

      final mockFavorites = [
        FoodItem(id: 'f1', name: 'Nasi Goreng Spesial', price: 25000.0, rating: 4.8, description: 'Nasi goreng terbaik.'),
        FoodItem(id: 'f2', name: 'Ayam Geprek Sambal Matah', price: 30000.0, rating: 4.5, description: 'Ayam krispi dengan sambal matah pedas.'),
      ];
      emit(FavoritesLoaded(mockFavorites));
    } catch (e) {
      emit(FavoritesError('Gagal memuat favorit: ${e.toString()}'));
    }
  }
  
  void removeFavorite(String foodId) {
    if (state is FavoritesLoaded) {
      final currentList = (state as FavoritesLoaded).favoriteItems;
      final updatedList = currentList.where((item) => item.id != foodId).toList();
      emit(FavoritesLoaded(updatedList));
      print('Removed $foodId from favorites.');
    }
  }
}
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  static const String routeName = '/favorites';

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoritesCubit>().fetchFavorites();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Favorit'),
        backgroundColor: const Color(0xFFE57373),
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading || state is FavoritesInitial) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFE57373)));
          }

          if (state is FavoritesError) {
            return Center(
              child: Text('Gagal memuat favorit: ${state.message}'),
            );
          }

          if (state is FavoritesLoaded) {
            final favoriteItems = state.favoriteItems;

            if (favoriteItems.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text(
                      'Belum Ada Menu Favorit',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    const Text('Tambahkan menu yang Anda suka dengan menekan ikon ❤️'),
                  ],
                ),
              );
            }

            // 5. Item List
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final item = favoriteItems[index];
                return _FoodListItemWidget( 
                  foodItem: item,
                  onTap: () {
                    Navigator.of(context).pushNamed('/food_detail', arguments: item);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Detail: ${item.name}'))
                    );
                  },
                  onToggleFavorite: () {
                    context.read<FavoritesCubit>().removeFavorite(item.id);
                  },
                );
              },
            );
          }
          
          return const SizedBox.shrink(); 
        },
      ),
    );
  }
}
class _FoodListItemWidget extends StatelessWidget {
  final FoodItem foodItem;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;

  const _FoodListItemWidget({
    required this.foodItem,
    required this.onTap,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            'https://picsum.photos/100/100?foodId=${foodItem.id}',
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(foodItem.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rp ${foodItem.price.toStringAsFixed(0)}'),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                Text(foodItem.rating.toString()),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.favorite, color: Colors.red),
          onPressed: onToggleFavorite, 
        ),
        onTap: onTap,
      ),
    );
  }
}