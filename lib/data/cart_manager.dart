import 'package:flutter/material.dart';

class CartItem {
  final Map<String, String> foodItem;
  int quantity;

  CartItem({
    required this.foodItem,
    this.quantity = 1,
  });

  double get price {
    return double.tryParse(foodItem['price']?.replaceAll('₱', '') ?? '0') ?? 0;
  }

  double get total {
    return price * quantity;
  }
}

class CartManager extends ChangeNotifier {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() {
    return _instance;
  }
  CartManager._internal();

  final List<CartItem> _items = [];
  String? _appliedCouponCode;
  double _discountPercentage = 0.0;

  List<CartItem> get items {
    return List.unmodifiable(_items);
  }

  String? get appliedCouponCode {
    return _appliedCouponCode;
  }

  void addItem(Map<String, String> foodItem, int quantity) {
    final title = foodItem['title'];
    final index = _items.indexWhere((item) {
      return item.foodItem['title'] == title;
    });

    if (index >= 0) {
      _items[index].quantity += quantity;
    } else {
      _items.add(CartItem(foodItem: foodItem, quantity: quantity));
    }
    notifyListeners();
  }

  void updateQuantity(String title, int delta) {
    final index = _items.indexWhere((item) {
      return item.foodItem['title'] == title;
    });
    if (index >= 0) {
      _items[index].quantity += delta;
      if (_items[index].quantity <= 0) {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void removeItem(String title) {
    _items.removeWhere((item) {
      return item.foodItem['title'] == title;
    });
    notifyListeners();
  }

  void applyCoupon(String code, double percentage) {
    _appliedCouponCode = code;
    _discountPercentage = percentage;
    notifyListeners();
  }

  void removeCoupon() {
    _appliedCouponCode = null;
    _discountPercentage = 0.0;
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    _appliedCouponCode = null;
    _discountPercentage = 0.0;
    notifyListeners();
  }

  double get subtotal {
    return _items.fold(0, (sum, item) {
      return sum + item.total;
    });
  }

  double get discountAmount {
    return subtotal * _discountPercentage;
  }

  double get tax {
    if (_items.isEmpty) {
      return 0;
    }
    return 5.0;
  }

  double get deliveryFee {
    if (_items.isEmpty) {
      return 0;
    }
    return 20.0;
  }

  double get totalAmount {
    final total = subtotal - discountAmount + deliveryFee + tax;
    if (total > 0) {
      return total;
    }
    return 0;
  }
}
