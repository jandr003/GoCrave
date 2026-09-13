import 'package:flutter/material.dart';

class FavoriteManager extends ChangeNotifier {
  static final FavoriteManager _instance = FavoriteManager._internal();
  factory FavoriteManager() => _instance;
  FavoriteManager._internal();

  final List<Map<String, String>> _favorites = [];

  List<Map<String, String>> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(String title) {
    return _favorites.any((item) => item['title'] == title);
  }

  void toggleFavorite(Map<String, String> foodItem) {
    final title = foodItem['title'];
    final index = _favorites.indexWhere((item) => item['title'] == title);
    
    if (index >= 0) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(foodItem);
    }
    notifyListeners();
  }

  void addFavorite(Map<String, String> foodItem) {
    if (!isFavorite(foodItem['title']!)) {
      _favorites.add(foodItem);
      notifyListeners();
    }
  }

  void removeFavorite(String title) {
    _favorites.removeWhere((item) => item['title'] == title);
    notifyListeners();
  }
}
