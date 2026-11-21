import 'package:flutter/material.dart';

class InventoryManager extends ChangeNotifier {
  static final InventoryManager _instance = InventoryManager._internal();
  factory InventoryManager() {
    return _instance;
  }
  InventoryManager._internal();

  final List<Map<String, dynamic>> _inventoryItems = [];

  List<Map<String, dynamic>> get inventoryItems {
    return List.unmodifiable(_inventoryItems);
  }

  void toggleStock(String id) {
    final index = _inventoryItems.indexWhere((i) {
      return i['id'] == id;
    });
    if (index != -1) {
      _inventoryItems[index]['inStock'] = !_inventoryItems[index]['inStock'];
      notifyListeners();
    }
  }

  void addItem(Map<String, dynamic> item) {
    _inventoryItems.insert(0, item);
    notifyListeners();
  }
}
