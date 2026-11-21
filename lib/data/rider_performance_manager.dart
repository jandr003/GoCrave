import 'package:flutter/material.dart';

class RiderPerformanceManager extends ChangeNotifier {
  static final RiderPerformanceManager _instance = RiderPerformanceManager._internal();
  factory RiderPerformanceManager() {
    return _instance;
  }
  RiderPerformanceManager._internal();

  final List<Map<String, dynamic>> _performances = [];

  List<Map<String, dynamic>> get performances {
    return List.unmodifiable(_performances);
  }

  void updateShift(String id, String newShift) {
    final index = _performances.indexWhere((p) {
      return p['id'] == id;
    });
    if (index != -1) {
      _performances[index]['shift'] = newShift;
      notifyListeners();
    }
  }

  void addPerformance(Map<String, dynamic> perf) {
    _performances.insert(0, perf);
    notifyListeners();
  }
}
