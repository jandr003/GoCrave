import 'package:flutter/material.dart';

class DisputeManager extends ChangeNotifier {
  static final DisputeManager _instance = DisputeManager._internal();
  factory DisputeManager() {
    return _instance;
  }
  DisputeManager._internal();

  final List<Map<String, dynamic>> _disputes = [];

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
