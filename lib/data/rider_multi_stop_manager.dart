import 'package:flutter/material.dart';

class RiderMultiStopManager extends ChangeNotifier {
  static final RiderMultiStopManager _instance = RiderMultiStopManager._internal();
  factory RiderMultiStopManager() {
    return _instance;
  }
  RiderMultiStopManager._internal();

  final List<Map<String, dynamic>> _batchedOrders = [];

  List<Map<String, dynamic>> get batchedOrders {
    return List.unmodifiable(_batchedOrders);
  }

  void addBatchOrder(Map<String, dynamic> order) {
    if (_batchedOrders.length < 2) {
      _batchedOrders.add(order);
      notifyListeners();
    }
  }

  void removeBatchOrder(String orderId) {
    _batchedOrders.removeWhere((o) {
      return o['id'] == orderId;
    });
    notifyListeners();
  }
}
