import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<List<dynamic>> {
  FavoritesCubit() : super([]);

  void toggleFavorite(item) {
    final list = [...state];
    if (list.contains(item)) {
      list.remove(item);
    } else {
      list.add(item);
    }
    emit(list);
  }
}
