import 'package:flutter/material.dart';

class MerchantManager extends ChangeNotifier {
  static final MerchantManager _instance = MerchantManager._internal();
  factory MerchantManager() {
    return _instance;
  }
  MerchantManager._internal();

  final List<Map<String, dynamic>> _merchants = [];

  List<Map<String, dynamic>> get merchants {
    return List.unmodifiable(_merchants);
  }

  List<Map<String, dynamic>> get pendingMerchants {
    return _merchants.where((m) {
      return m['status'] == 'Pending';
    }).toList();
  }

  List<Map<String, dynamic>> get approvedMerchants {
    return _merchants.where((m) {
      return m['status'] == 'Approved';
    }).toList();
  }

  void approveMerchant(String id, double commissionRate) {
    final index = _merchants.indexWhere((m) {
      return m['id'] == id;
    });
    if (index != -1) {
      _merchants[index]['status'] = 'Approved';
      _merchants[index]['commission'] = commissionRate;
      notifyListeners();
    }
  }

  void rejectMerchant(String id) {
    final index = _merchants.indexWhere((m) {
      return m['id'] == id;
    });
    if (index != -1) {
      _merchants[index]['status'] = 'Rejected';
      notifyListeners();
    }
  }

  void addMerchant(Map<String, dynamic> merchant) {
    _merchants.insert(0, merchant);
    notifyListeners();
  }
}
