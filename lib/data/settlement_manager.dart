import 'package:flutter/material.dart';

class SettlementManager extends ChangeNotifier {
  static final SettlementManager _instance = SettlementManager._internal();
  factory SettlementManager() => _instance;
  SettlementManager._internal();

  final List<Map<String, dynamic>> _settlements = [
    {
      'id': 'SET-8842',
      'recipient': 'Bulacan Goto King (Merchant)',
      'amount': '₱12,450.00',
      'commission': '₱2,197.00',
      'status': 'Settled',
      'date': 'Nov 5, 2026',
    },
    {
      'id': 'SET-8843',
      'recipient': 'Ricardo Dalisay (Rider)',
      'amount': '₱3,120.00',
      'commission': '₱0.00',
      'status': 'Pending Payout',
      'date': 'Nov 6, 2026',
    },
    {
      'id': 'SET-8844',
      'recipient': 'Malolos Litson Manok (Merchant)',
      'amount': '₱18,900.00',
      'commission': '₱3,335.00',
      'status': 'Processing',
      'date': 'Nov 7, 2026',
    },
  ];

  List<Map<String, dynamic>> get settlements => List.unmodifiable(_settlements);

  void markAsSettled(String id) {
    final index = _settlements.indexWhere((s) => s['id'] == id);
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
