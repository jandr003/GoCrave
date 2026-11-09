import 'package:flutter/material.dart';

class SurgeManager extends ChangeNotifier {
  static final SurgeManager _instance = SurgeManager._internal();
  factory SurgeManager() => _instance;
  SurgeManager._internal();

  double _baseDeliveryFee = 25.0;
  double _surgeMultiplier = 1.0;
  bool _isSurgeActive = false;

  double get baseDeliveryFee => _baseDeliveryFee;
  double get surgeMultiplier => _surgeMultiplier;
  bool get isSurgeActive => _isSurgeActive;

  void updateBaseFee(double fee) {
    _baseDeliveryFee = fee;
    notifyListeners();
  }

  void updateSurge(bool isActive, double multiplier) {
    _isSurgeActive = isActive;
    _surgeMultiplier = multiplier;
    notifyListeners();
  }
}
