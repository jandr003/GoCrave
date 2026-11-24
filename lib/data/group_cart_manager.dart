import 'package:flutter/material.dart';

class GroupCartManager extends ChangeNotifier {
  static final GroupCartManager _instance = GroupCartManager._internal();
  factory GroupCartManager() {
    return _instance;
  }
  GroupCartManager._internal();

  bool _isGroupActive = false;
  String _groupSessionCode = 'GOC-SALOSALO-88';
  final List<Map<String, dynamic>> _sharedMembers = [
    {'name': 'John Andrew (Host)', 'itemsCount': 2, 'subtotal': '₱340.00'},
    {'name': 'Maria Clara', 'itemsCount': 1, 'subtotal': '₱185.00'},
  ];

  bool get isGroupActive {
    return _isGroupActive;
  }

  String get groupSessionCode {
    return _groupSessionCode;
  }

  List<Map<String, dynamic>> get sharedMembers {
    return List.unmodifiable(_sharedMembers);
  }

  void toggleGroupActive(bool active) {
    _isGroupActive = active;
    notifyListeners();
  }

  void addMember(String name, int itemsCount, double subtotal) {
    _sharedMembers.add({
      'name': name,
      'itemsCount': itemsCount,
      'subtotal': '₱${subtotal.toStringAsFixed(2)}',
    });
    notifyListeners();
  }

  void resetGroupSession() {
    _isGroupActive = false;
    _sharedMembers.clear();
    _sharedMembers.addAll([
      {'name': 'John Andrew (Host)', 'itemsCount': 2, 'subtotal': '₱340.00'},
    ]);
    notifyListeners();
  }
}
