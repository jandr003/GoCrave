import 'package:flutter/material.dart';

class RiderPerformanceManager extends ChangeNotifier {
  static final RiderPerformanceManager _instance = RiderPerformanceManager._internal();
  factory RiderPerformanceManager() => _instance;
  RiderPerformanceManager._internal();

  final List<Map<String, dynamic>> _performances = [
    {
      'id': 'RP-01',
      'name': 'Ricardo Dalisay',
      'shift': '08:00 AM - 04:00 PM',
      'acceptanceRate': '98.5%',
      'cancellationRate': '0.5%',
      'rating': '4.9',
      'completedTrips': '1,420',
      'status': 'On Duty',
    },
    {
      'id': 'RP-02',
      'name': 'Cardo D.',
      'shift': '12:00 PM - 08:00 PM',
      'acceptanceRate': '95.0%',
      'cancellationRate': '1.2%',
      'rating': '4.8',
      'completedTrips': '980',
      'status': 'On Duty',
    },
    {
      'id': 'RP-03',
      'name': 'Boy Tsuper',
      'shift': '04:00 PM - 12:00 AM',
      'acceptanceRate': '99.1%',
      'cancellationRate': '0.2%',
      'rating': '4.95',
      'completedTrips': '2,150',
      'status': 'Off Duty',
    },
  ];

  List<Map<String, dynamic>> get performances => List.unmodifiable(_performances);

  void updateShift(String id, String newShift) {
    final index = _performances.indexWhere((p) => p['id'] == id);
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
