import 'package:flutter/material.dart';

class MultiStoreCheckoutManager extends ChangeNotifier {
  static final MultiStoreCheckoutManager _instance = MultiStoreCheckoutManager._internal();
  factory MultiStoreCheckoutManager() {
    return _instance;
  }
  MultiStoreCheckoutManager._internal();

  bool _isSplitCheckoutEnabled = true;

  bool get isSplitCheckoutEnabled {
    return _isSplitCheckoutEnabled;
  }

  void toggleSplitCheckout(bool enabled) {
    _isSplitCheckoutEnabled = enabled;
    notifyListeners();
  }

  List<Map<String, dynamic>> splitCartByStore(List<dynamic> cartItems) {
    final Map<String, List<dynamic>> storeMap = {};
    for (var item in cartItems) {
      final storeName = item.foodItem['storeName'] ?? item.foodItem['subtitle'] ?? 'GoCrave Partner Restaurant';
      if (!storeMap.containsKey(storeName)) {
        storeMap[storeName] = [];
      }
      storeMap[storeName]!.add(item);
    }

    final List<Map<String, dynamic>> result = [];
    storeMap.forEach((storeName, items) {
      result.add({
        'storeName': storeName,
        'items': items,
      });
    });
    return result;
  }
}
