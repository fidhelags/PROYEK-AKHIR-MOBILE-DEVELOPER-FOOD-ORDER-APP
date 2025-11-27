// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FoodState {}

class FoodInitial extends FoodState {}

class FoodLoading extends FoodState {}

class FoodLoaded extends FoodState {
  final List<dynamic> foodItems;
  final List<dynamic> categories; 

  FoodLoaded({
    required this.foodItems,
    required this.categories,
  });
}

class FoodError extends FoodState {
  final String message;
  FoodError(this.message);
}

class FoodCubit extends Cubit<FoodState> {
  FoodCubit() : super(FoodInitial());
  Future<void> fetchInitialData() async {
    if (state is FoodLoaded) return; 

    emit(FoodLoading());
    
    try {
      final foodResponse = await Future.delayed(
        const Duration(seconds: 1), 
        () => {'success': true, 'data': _mockFoodItems}
      ); 

      final categoryResponse = await Future.delayed(
        const Duration(seconds: 1), 
        () => {'success': true, 'data': _mockCategories}
      );

      if (foodResponse['success'] == true && categoryResponse['success'] == true) {
        final foodItems = foodResponse['data'] as List<dynamic>;
        final categories = categoryResponse['data'] as List<dynamic>;

        emit(FoodLoaded(foodItems: foodItems, categories: categories));
      } else {
        emit(FoodError('Gagal memuat data menu.'));
      }
    } catch (e) {
      emit(FoodError(e.toString()));
    }
  }

  final List<Map<String, dynamic>> _mockFoodItems = [
    {'id': 'f1', 'name': 'Nasi Goreng Spesial', 'price': 25000.0, 'categoryId': 'c1'},
    {'id': 'f2', 'name': 'Ayam Geprek Sambal Matah', 'price': 30000.0, 'categoryId': 'c2'},
    {'id': 'f3', 'name': 'Mie Ayam Bakso', 'price': 20000.0, 'categoryId': 'c1'},
    {'id': 'f4', 'name': 'Es Jeruk', 'price': 10000.0, 'categoryId': 'c3'},
  ];

  final List<Map<String, dynamic>> _mockCategories = [
    {'id': 'c1', 'name': 'Nasi & Mie'},
    {'id': 'c2', 'name': 'Ayam'},
    {'id': 'c3', 'name': 'Minuman'},
  ];
}