import 'package:flutter/material.dart';

class BranchManager extends ChangeNotifier {
  static final BranchManager _instance = BranchManager._internal();
  factory BranchManager() {
    return _instance;
  }
  BranchManager._internal();

  final List<Map<String, dynamic>> _branches = [
    {
      'id': 'BR-01',
      'storeName': 'Bulacan Goto King',
      'branchName': 'Malolos Main Branch',
      'city': 'Malolos',
      'status': 'Active',
      'manager': 'Juan Santos',
      'sales': '₱142,500.00',
    },
    {
      'id': 'BR-02',
      'storeName': 'Bulacan Goto King',
      'branchName': 'Baliuag Highway Branch',
      'city': 'Baliuag',
      'status': 'Active',
      'manager': 'Pedro Penduko',
      'sales': '₱98,200.00',
    },
    {
      'id': 'BR-03',
      'storeName': 'Malolos Litson Manok',
      'branchName': 'Guinhawa Central Kitchen',
      'city': 'Malolos',
      'status': 'Active',
      'manager': 'Maria Clara',
      'sales': '₱215,800.00',
    },
  ];

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
