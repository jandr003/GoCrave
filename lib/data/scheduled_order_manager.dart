import 'package:flutter/material.dart';

class ScheduledOrderManager extends ChangeNotifier {
  static final ScheduledOrderManager _instance = ScheduledOrderManager._internal();
  factory ScheduledOrderManager() {
    return _instance;
  }
  ScheduledOrderManager._internal();

  bool _isScheduled = false;
  String _scheduledTimeLabel = 'ASAP (Default 20-25 mins)';

  bool get isScheduled {
    return _isScheduled;
  }

  String get scheduledTimeLabel {
    return _scheduledTimeLabel;
  }

  void setSchedule(String timeLabel) {
    _isScheduled = true;
    _scheduledTimeLabel = timeLabel;
    notifyListeners();
  }

  void clearSchedule() {
    _isScheduled = false;
    _scheduledTimeLabel = 'ASAP (Default 20-25 mins)';
    notifyListeners();
  }
}
