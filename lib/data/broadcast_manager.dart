import 'package:flutter/material.dart';

class BroadcastManager extends ChangeNotifier {
  static final BroadcastManager _instance = BroadcastManager._internal();
  factory BroadcastManager() {
    return _instance;
  }
  BroadcastManager._internal();

  final List<Map<String, dynamic>> _broadcasts = [];

  List<Map<String, dynamic>> get broadcasts {
    return List.unmodifiable(_broadcasts);
  }

  void sendBroadcast(String target, String title, String message) {
    _broadcasts.insert(0, {
      'id': 'BC-${_broadcasts.length + 101}',
      'title': title,
      'message': message,
      'target': target,
      'timestamp': 'Just now',
      'status': 'Delivered (Active Broadcast)',
    });
    notifyListeners();
  }

  void deleteBroadcast(String id) {
    _broadcasts.removeWhere((b) {
      return b['id'] == id;
    });
    notifyListeners();
  }
}
