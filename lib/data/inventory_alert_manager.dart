import 'package:flutter/material.dart';

class InventoryAlertItem {
  final String itemId;
  final String storeName;
  final String itemName;
  final int currentStock;
  final int threshold;

  InventoryAlertItem({
    required this.itemId,
    required this.storeName,
    required this.itemName,
    required this.currentStock,
    required this.threshold,
  });
}

class InventoryAlertManager extends ChangeNotifier {
  static final InventoryAlertManager _instance = InventoryAlertManager._internal();
  factory InventoryAlertManager() {
    return _instance;
  }
  InventoryAlertManager._internal();

  final List<InventoryAlertItem> _alerts = [
    InventoryAlertItem(
      itemId: 'INV-01',
      storeName: 'Bulacan Goto King',
      itemName: 'Special Goto with Chicharon',
      currentStock: 3,
      threshold: 5,
    ),
    InventoryAlertItem(
      itemId: 'INV-02',
      storeName: 'Malolos Litson Manok',
      itemName: 'Lechon Manok (Whole)',
      currentStock: 1,
      threshold: 4,
    ),
  ];

  List<InventoryAlertItem> get alerts {
    return List.unmodifiable(_alerts);
  }

  void updateStock(String itemId, int newStock) {
    final index = _alerts.indexWhere((a) {
      return a.itemId == itemId;
    });
    if (index != -1) {
      if (newStock <= _alerts[index].threshold) {
        
      } else {
        _alerts.removeAt(index);
      }
      notifyListeners();
    }
  }

  void addAlert(InventoryAlertItem alert) {
    _alerts.insert(0, alert);
    notifyListeners();
  }
}
