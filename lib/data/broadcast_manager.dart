import 'package:flutter/material.dart';

class BroadcastManager extends ChangeNotifier {
  static final BroadcastManager _instance = BroadcastManager._internal();
  factory BroadcastManager() => _instance;
  BroadcastManager._internal();

  final List<Map<String, dynamic>> _broadcasts = [
    {
      'id': 'BC-101',
      'title': 'Weekend Free Delivery Promo!',
      'message': 'Enjoy ₱0 delivery fee across all Malolos restaurants this Saturday & Sunday.',
      'target': 'All Customers',
      'timestamp': 'Nov 7, 2026 • 10:30 AM',
      'status': 'Delivered (1,420 users)',
    },
    {
      'id': 'BC-102',
      'title': 'Rider Safety Advisory: Heavy Rain',
      'message': 'All active delivery fleet riders are advised to exercise caution and wear rain gear.',
      'target': 'All Riders',
      'timestamp': 'Nov 6, 2026 • 02:15 PM',
      'status': 'Delivered (48 riders)',
    },
  ];

  List<Map<String, dynamic>> get broadcasts => List.unmodifiable(_broadcasts);

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
    _broadcasts.removeWhere((b) => b['id'] == id);
    notifyListeners();
  }
}
