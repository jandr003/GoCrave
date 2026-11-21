import 'package:flutter/material.dart';

class AuditManager extends ChangeNotifier {
  static final AuditManager _instance = AuditManager._internal();
  factory AuditManager() {
    return _instance;
  }
  AuditManager._internal();

  final List<Map<String, dynamic>> _logs = [];

  List<Map<String, dynamic>> get logs {
    return List.unmodifiable(_logs);
  }

  void logAction(String admin, String action, String ip) {
    _logs.insert(0, {
      'id': 'LOG-${_logs.length + 901}',
      'admin': admin,
      'action': action,
      'ip': ip,
      'timestamp': 'Just now',
    });
    notifyListeners();
  }
}
