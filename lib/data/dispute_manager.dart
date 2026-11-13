import 'package:flutter/material.dart';

class DisputeManager extends ChangeNotifier {
  static final DisputeManager _instance = DisputeManager._internal();
  factory DisputeManager() {
    return _instance;
  }
  DisputeManager._internal();

  final List<Map<String, dynamic>> _disputes = [
    {
      'id': 'DISP-8842',
      'orderId': '#GOC10482',
      'customerName': 'Juan Dela Cruz',
      'storeName': 'Bulacan Goto King',
      'issue': 'Wrong drink delivered (Iced Tea instead of Soda)',
      'amount': '₱245.00',
      'status': 'Open',
      'timestamp': '10 mins ago',
    },
    {
      'id': 'DISP-9912',
      'orderId': '#GOC10450',
      'customerName': 'Maria Santos',
      'storeName': 'Malolos Litson Manok',
      'issue': 'Missing extra rice order item',
      'amount': '₱480.00',
      'status': 'Open',
      'timestamp': '45 mins ago',
    },
    {
      'id': 'DISP-7721',
      'orderId': '#GOC10398',
      'customerName': 'Pedro Penduko',
      'storeName': 'Kapitolyo Sisig House',
      'issue': 'Delayed delivery past estimated time',
      'amount': '₱195.00',
      'status': 'Resolved',
      'timestamp': '2 hours ago',
    },
  ];

  List<Map<String, dynamic>> get disputes {
    return List.unmodifiable(_disputes);
  }

  void resolveDispute(String id) {
    final index = _disputes.indexWhere((d) {
      return d['id'] == id;
    });
    if (index != -1) {
      _disputes[index]['status'] = 'Resolved';
      notifyListeners();
    }
  }

  void issueRefund(String id) {
    final index = _disputes.indexWhere((d) {
      return d['id'] == id;
    });
    if (index != -1) {
      _disputes[index]['status'] = 'Refunded';
      notifyListeners();
    }
  }

  void addDispute(Map<String, dynamic> dispute) {
    _disputes.insert(0, dispute);
    notifyListeners();
  }
}
