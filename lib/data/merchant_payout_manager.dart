import 'package:flutter/material.dart';

class MerchantPayoutItem {
  final String payoutId;
  final String storeName;
  final double grossSales;
  final double platformCommission;
  final double netPayout;
  final String bankAccount;
  String status;

  MerchantPayoutItem({
    required this.payoutId,
    required this.storeName,
    required this.grossSales,
    required this.platformCommission,
    required this.netPayout,
    required this.bankAccount,
    this.status = 'Pending Release',
  });
}

class MerchantPayoutManager extends ChangeNotifier {
  static final MerchantPayoutManager _instance = MerchantPayoutManager._internal();
  factory MerchantPayoutManager() {
    return _instance;
  }
  MerchantPayoutManager._internal();

  final List<MerchantPayoutItem> _payouts = [];

  List<MerchantPayoutItem> get payouts {
    return List.unmodifiable(_payouts);
  }

  void releasePayout(String payoutId) {
    final index = _payouts.indexWhere((p) {
      return p.payoutId == payoutId;
    });
    if (index != -1) {
      _payouts[index].status = 'Released & Transferred';
      notifyListeners();
    }
  }

  void addPayout(MerchantPayoutItem item) {
    _payouts.insert(0, item);
    notifyListeners();
  }
}
