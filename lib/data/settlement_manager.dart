import 'package:flutter/material.dart';

class SettlementManager extends ChangeNotifier {
  static final SettlementManager _instance = SettlementManager._internal();
  factory SettlementManager() {
    return _instance;
  }
  SettlementManager._internal();

  final List<Map<String, dynamic>> _settlements = [];

  List<Map<String, dynamic>> get settlements {
    return List.unmodifiable(_settlements);
  }

  void markAsSettled(String id) {
    final index = _settlements.indexWhere((s) {
      return s['id'] == id;
    });
    if (index != -1) {
      _settlements[index]['status'] = 'Settled';
      notifyListeners();
    }
  }

  void addSettlement(Map<String, dynamic> settlement) {
    _settlements.insert(0, settlement);
    notifyListeners();
  }
}
