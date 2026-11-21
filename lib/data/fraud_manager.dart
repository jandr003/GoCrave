import 'package:flutter/material.dart';

class FraudManager extends ChangeNotifier {
  static final FraudManager _instance = FraudManager._internal();
  factory FraudManager() {
    return _instance;
  }
  FraudManager._internal();

  final List<Map<String, dynamic>> _flags = [];

  List<Map<String, dynamic>> get flags {
    return List.unmodifiable(_flags);
  }

  void resolveFlag(String id) {
    final index = _flags.indexWhere((f) {
      return f['id'] == id;
    });
    if (index != -1) {
      _flags[index]['status'] = 'Cleared & Resolved';
      notifyListeners();
    }
  }

  void blockAccount(String id) {
    final index = _flags.indexWhere((f) {
      return f['id'] == id;
    });
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
