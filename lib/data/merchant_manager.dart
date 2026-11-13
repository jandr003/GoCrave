import 'package:flutter/material.dart';

class MerchantManager extends ChangeNotifier {
  static final MerchantManager _instance = MerchantManager._internal();
  factory MerchantManager() {
    return _instance;
  }
  MerchantManager._internal();

  final List<Map<String, dynamic>> _merchants = [
    {
      'id': 'M001',
      'storeName': 'Malolos Litson Manok',
      'ownerName': 'Roberto Santos',
      'cuisine': 'Filipino / Roasted',
      'permitId': 'PERMIT-2026-8842',
      'phone': '09171234567',
      'email': 'litsonmalolos@gocrave.ph',
      'status': 'Pending',
      'commission': 15.0,
      'appliedDate': 'Nov 5, 2026',
      'logo': 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?q=80&w=200&auto=format&fit=crop',
    },
    {
      'id': 'M002',
      'storeName': 'Kapitolyo Sisig House',
      'ownerName': 'Arnel Pineda',
      'cuisine': 'Sisig & Grills',
      'permitId': 'PERMIT-2026-9912',
      'phone': '09189876543',
      'email': 'kapitolyosisig@gocrave.ph',
      'status': 'Pending',
      'commission': 15.0,
      'appliedDate': 'Nov 6, 2026',
      'logo': 'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?q=80&w=200&auto=format&fit=crop',
    },
    {
      'id': 'M003',
      'storeName': 'Bulacan Goto King',
      'ownerName': 'Maria Clara',
      'cuisine': 'Lugaw & Goto',
      'permitId': 'PERMIT-2026-1104',
      'phone': '09191112233',
      'email': 'gotoking@gocrave.ph',
      'status': 'Approved',
      'commission': 12.5,
      'appliedDate': 'Nov 1, 2026',
      'logo': 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?q=80&w=200&auto=format&fit=crop',
    },
  ];

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
