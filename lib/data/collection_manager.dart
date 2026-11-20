import 'package:flutter/material.dart';

class CollectionManager extends ChangeNotifier {
  static final CollectionManager _instance = CollectionManager._internal();
  factory CollectionManager() {
    return _instance;
  }
  CollectionManager._internal();

  final List<String> _collections = ['All Favorites', 'Weekend Cravings', 'Late Night Snacks', 'Healthy Diet'];
  final Map<String, List<Map<String, String>>> _itemCollections = {
    'Weekend Cravings': [],
    'Late Night Snacks': [],
    'Healthy Diet': [],
  };

  List<String> get collections {
    return List.unmodifiable(_collections);
  }

  List<Map<String, String>> getItemsForCollection(String collectionName) {
    if (collectionName == 'All Favorites') {
      return [];
    }
    return List.unmodifiable(_itemCollections[collectionName] ?? []);
  }

  void assignToCollection(String collectionName, Map<String, String> item) {
    if (!_itemCollections.containsKey(collectionName)) {
      _itemCollections[collectionName] = [];
    }
    final list = _itemCollections[collectionName]!;
    final exists = list.any((i) {
      return i['title'] == item['title'];
    });
    if (!exists) {
      list.add(item);
      notifyListeners();
    }
  }

  void removeFromCollection(String collectionName, Map<String, String> item) {
    if (_itemCollections.containsKey(collectionName)) {
      _itemCollections[collectionName]!.removeWhere((i) {
        return i['title'] == item['title'];
      });
      notifyListeners();
    }
  }

  void addCollection(String name) {
    if (!_collections.contains(name)) {
      _collections.add(name);
      _itemCollections[name] = [];
      notifyListeners();
    }
  }
}
