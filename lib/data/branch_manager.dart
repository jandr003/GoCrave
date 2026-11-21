import 'package:flutter/material.dart';

class BranchManager extends ChangeNotifier {
  static final BranchManager _instance = BranchManager._internal();
  factory BranchManager() {
    return _instance;
  }
  BranchManager._internal();

  final List<Map<String, dynamic>> _branches = [];

  List<Map<String, dynamic>> get branches {
    return List.unmodifiable(_branches);
  }

  void toggleBranchStatus(String id) {
    final index = _branches.indexWhere((b) {
      return b['id'] == id;
    });
    if (index != -1) {
      _branches[index]['status'] = _branches[index]['status'] == 'Active' ? 'Inactive' : 'Active';
      notifyListeners();
    }
  }

  void addBranch(Map<String, dynamic> branch) {
    _branches.insert(0, branch);
    notifyListeners();
  }
}
