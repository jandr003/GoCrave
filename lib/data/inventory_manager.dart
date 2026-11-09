import 'package:flutter/material.dart';

class InventoryManager extends ChangeNotifier {
  static final InventoryManager _instance = InventoryManager._internal();
  factory InventoryManager() => _instance;
  InventoryManager._internal();

  final List<Map<String, dynamic>> _inventoryItems = [
    {
      'id': 'INV-01',
      'store': 'Bulacan Goto King',
      'itemName': 'Special Goto with Chicharon',
      'price': '₱120.00',
      'inStock': true,
    },
    {
      'id': 'INV-02',
      'store': 'Malolos Litson Manok',
      'itemName': 'Lechon Manok (Whole)',
      'price': '₱450.00',
      'inStock': true,
    },
    {
      'id': 'INV-03',
      'store': 'Kapitolyo Sisig House',
      'itemName': 'Crispy Pork Sisig Meal',
      'price': '₱185.00',
      'inStock': false,
    },
    {
      'id': 'INV-04',
      'store': 'Bulacan Goto King',
      'itemName': 'Tokwa’t Baboy',
      'price': '₱95.00',
      'inStock': true,
    },
  ];

  List<Map<String, dynamic>> get inventoryItems => List.unmodifiable(_inventoryItems);

  void toggleStock(String id) {
    final index = _inventoryItems.indexWhere((i) => i['id'] == id);
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
