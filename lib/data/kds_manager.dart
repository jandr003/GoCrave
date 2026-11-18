import 'package:flutter/material.dart';

class KdsOrder {
  final String id;
  final String storeName;
  final String customerName;
  final List<Map<String, dynamic>> items;
  final String totalAmount;
  final String orderTime;
  String kitchenStatus;

  KdsOrder({
    required this.id,
    required this.storeName,
    required this.customerName,
    required this.items,
    required this.totalAmount,
    required this.orderTime,
    this.kitchenStatus = 'Incoming',
  });
}

class KdsManager extends ChangeNotifier {
  static final KdsManager _instance = KdsManager._internal();
  factory KdsManager() {
    return _instance;
  }
  KdsManager._internal();

  final List<KdsOrder> _kdsOrders = [
    KdsOrder(
      id: '#GC-KDS-01',
      storeName: 'Bulacan Goto King',
      customerName: 'Juan Dela Cruz',
      items: [
        {'name': 'Special Goto with Chicharon', 'qty': 2},
        {'name': 'Tokwa\'t Baboy', 'qty': 1},
      ],
      totalAmount: '₱335.00',
      orderTime: '10 mins ago',
      kitchenStatus: 'Incoming',
    ),
    KdsOrder(
      id: '#GC-KDS-02',
      storeName: 'Bulacan Goto King',
      customerName: 'Maria Santos',
      items: [
        {'name': 'Plain Lugaw', 'qty': 1},
        {'name': 'Lumpiang Shanghai', 'qty': 2},
      ],
      totalAmount: '₱180.00',
      orderTime: '25 mins ago',
      kitchenStatus: 'Cooking',
    ),
  ];

  List<KdsOrder> get kdsOrders {
    return List.unmodifiable(_kdsOrders);
  }

  void startCooking(String orderId) {
    final index = _kdsOrders.indexWhere((o) {
      return o.id == orderId;
    });
    if (index != -1) {
      _kdsOrders[index].kitchenStatus = 'Cooking';
      notifyListeners();
    }
  }

  void markReady(String orderId) {
    final index = _kdsOrders.indexWhere((o) {
      return o.id == orderId;
    });
    if (index != -1) {
      _kdsOrders[index].kitchenStatus = 'Ready';
      notifyListeners();
    }
  }

  void completeOrder(String orderId) {
    final index = _kdsOrders.indexWhere((o) {
      return o.id == orderId;
    });
    if (index != -1) {
      _kdsOrders.removeAt(index);
      notifyListeners();
    }
  }

  void addOrder(KdsOrder order) {
    _kdsOrders.insert(0, order);
    notifyListeners();
  }
}
