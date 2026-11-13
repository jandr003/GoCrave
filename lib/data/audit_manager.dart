import 'package:flutter/material.dart';

class AuditManager extends ChangeNotifier {
  static final AuditManager _instance = AuditManager._internal();
  factory AuditManager() {
    return _instance;
  }
  AuditManager._internal();

  final List<Map<String, dynamic>> _logs = [
    {
      'id': 'LOG-901',
      'admin': 'Admin01 (Super Admin)',
      'action': 'Approved Merchant Application: Malolos Litson Manok',
      'ip': '192.168.1.105',
      'timestamp': 'Just now',
    },
    {
      'id': 'LOG-902',
      'admin': 'Admin01 (Super Admin)',
      'action': 'Issued Refund for Dispute DISP-8842 (₱245.00)',
      'ip': '192.168.1.105',
      'timestamp': '12 mins ago',
    },
    {
      'id': 'LOG-903',
      'admin': 'Admin02 (Finance)',
      'action': 'Marked Settlement SET-8842 as Settled',
      'ip': '192.168.1.112',
      'timestamp': '1 hour ago',
    },
  ];

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
