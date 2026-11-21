import 'package:flutter/material.dart';

class RiderShiftManager extends ChangeNotifier {
  static final RiderShiftManager _instance = RiderShiftManager._internal();
  factory RiderShiftManager() {
    return _instance;
  }
  RiderShiftManager._internal();

  bool _isClockedIn = false;
  String _currentShift = 'Morning Shift (08:00 AM - 04:00 PM)';
  int _totalDeliveriesCompleted = 142;
  double _acceptanceRate = 98.5;
  double _customerRating = 4.9;

  bool get isClockedIn {
    return _isClockedIn;
  }

  String get currentShift {
    return _currentShift;
  }

  int get totalDeliveriesCompleted {
    return _totalDeliveriesCompleted;
  }

  double get acceptanceRate {
    return _acceptanceRate;
  }

  double get customerRating {
    return _customerRating;
  }

  void toggleClockIn() {
    _isClockedIn = !_isClockedIn;
    notifyListeners();
  }

  void setShift(String shiftName) {
    _currentShift = shiftName;
    notifyListeners();
  }

  void incrementDelivery() {
    _totalDeliveriesCompleted++;
    notifyListeners();
  }
}
