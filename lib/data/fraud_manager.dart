import 'package:flutter/material.dart';

class FraudManager extends ChangeNotifier {
  static final FraudManager _instance = FraudManager._internal();
  factory FraudManager() => _instance;
  FraudManager._internal();

  final List<Map<String, dynamic>> _flags = [
    {
      'id': 'FRD-881',
      'user': 'Customer: TestUser99',
      'reason': 'Multiple cancelled COD orders within 1 hour',
      'riskLevel': 'High Risk',
      'status': 'Flagged',
      'timestamp': '15 mins ago',
    },
    {
      'id': 'FRD-882',
      'user': 'Merchant: FakeStore PH',
      'reason': 'Suspicious menu pricing anomaly detected',
      'riskLevel': 'Medium Risk',
      'status': 'Under Review',
      'timestamp': '2 hours ago',
    },
  ];

  List<Map<String, dynamic>> get flags => List.unmodifiable(_flags);

  void resolveFlag(String id) {
    final index = _flags.indexWhere((f) => f['id'] == id);
    if (index != -1) {
      _flags[index]['status'] = 'Cleared & Resolved';
      notifyListeners();
    }
  }

  void blockAccount(String id) {
    final index = _flags.indexWhere((f) => f['id'] == id);
    if (index != -1) {
      _flags[index]['status'] = 'Blocked & Banned';
      notifyListeners();
    }
  }

  void addFlag(Map<String, dynamic> flag) {
    _flags.insert(0, flag);
    notifyListeners();
  }
}
