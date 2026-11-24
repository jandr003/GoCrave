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

  final List<InventoryAlertItem> _alerts = [];

  List<InventoryAlertItem> get alerts {
    return List.unmodifiable(_alerts);
  }

  void updateStock(String itemId, int newStock) {
    final index = _alerts.indexWhere((a) {
      return a.itemId == itemId;
    });
    if (index != -1) {
      if (newStock > _alerts[index].threshold) {
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
