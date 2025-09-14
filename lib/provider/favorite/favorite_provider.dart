import 'package:flutter/material.dart';
import 'package:restaurant_api_dicoding/data/db/database_helper.dart';
import 'package:restaurant_api_dicoding/data/model/restauran.dart';

class FavoriteProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  FavoriteProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  List<Restauran> _favorites = [];
  List<Restauran> get favorites => _favorites;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // ambil semua favorite dari database
  Future<void> _getFavorites() async {
    _isLoading = true;
    notifyListeners();

    _favorites = await databaseHelper.getFavorites();

    _isLoading = false;
    notifyListeners();
  }

  // cek apakah id restoran ada di favorit
  bool isFavorite(String id) {
    return _favorites.any((resto) => resto.id == id);
  }

  // tambah ke favorit
  Future<void> addFavorite(Restauran restauran) async {
    await databaseHelper.insertFavorite(restauran);
    await _getFavorites(); // refresh list
  }

  // hapus dari favorit
  Future<void> removeFavorite(String id) async {
    await databaseHelper.removeFavorite(id);
    await _getFavorites(); // refresh list
  }
}
