import 'package:flutter/material.dart';

class PromoManager extends ChangeNotifier {
  static final PromoManager _instance = PromoManager._internal();
  factory PromoManager() => _instance;
  PromoManager._internal();

  final List<Map<String, dynamic>> _vouchers = [
    {
      'code': 'CRAVE30DEAL',
      'discount': '30% OFF',
      'save': 'Save 30% on this order',
      'desc': 'Maximum discount up to ₱125 on orders above ₱500',
      'expiry': 'Valid till 31 Dec 2027',
      'percentage': 0.3,
      'isActive': true,
    },
    {
      'code': 'GOCRAVE50',
      'discount': '₱50 OFF',
      'save': 'Save ₱50 on food delivery',
      'desc': 'Minimum spend of ₱300 required',
      'expiry': 'Valid till 31 Dec 2026',
      'percentage': 0.15,
      'isActive': true,
    },
    {
      'code': 'FREEDELIVERY',
      'discount': 'FREE',
      'save': 'Free Delivery on any order',
      'desc': 'Valid for all restaurants in Malolos',
      'expiry': 'Valid till 30 Nov 2026',
      'percentage': 0.05,
      'isActive': false,
    },
  ];

  List<Map<String, dynamic>> get vouchers => List.unmodifiable(_vouchers);

  List<Map<String, dynamic>> get activeVouchers =>
      _vouchers.where((v) => v['isActive'] == true).toList();

  void addPromo(Map<String, dynamic> promo) {
    _vouchers.insert(0, promo);
    notifyListeners();
  }

  void togglePromoStatus(String code) {
    final index = _vouchers.indexWhere((v) => v['code'] == code);
    if (index != -1) {
      _vouchers[index]['isActive'] = !_vouchers[index]['isActive'];
      notifyListeners();
    }
  }

  void removePromo(String code) {
    _vouchers.removeWhere((v) => v['code'] == code);
    notifyListeners();
  }
}
