import 'package:flutter/material.dart';

class RiderBonusManager extends ChangeNotifier {
  static final RiderBonusManager _instance = RiderBonusManager._internal();
  factory RiderBonusManager() {
    return _instance;
  }
  RiderBonusManager._internal();

  int _completedToday = 0;
  int _targetGoal = 10;
  double _bonusReward = 300.00;

  int get completedToday {
    return _completedToday;
  }

  int get targetGoal {
    return _targetGoal;
  }

  double get bonusReward {
    return _bonusReward;
  }

  double get progress {
    if (_targetGoal <= 0) {
      return 0.0;
    }
    final p = _completedToday / _targetGoal;
    if (p > 1.0) {
      return 1.0;
    }
    return p;
  }

  void incrementCompleted() {
    _completedToday++;
    notifyListeners();
  }
}
