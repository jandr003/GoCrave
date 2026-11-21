import 'package:flutter/material.dart';

class PromoManager extends ChangeNotifier {
  static final PromoManager _instance = PromoManager._internal();
  factory PromoManager() {
    return _instance;
  }
  PromoManager._internal();

  final List<Map<String, dynamic>> _vouchers = [];

  List<Map<String, dynamic>> get vouchers {
    return List.unmodifiable(_vouchers);
  }

  List<Map<String, dynamic>> get activeVouchers {
    return _vouchers.where((v) {
      return v['isActive'] == true;
    }).toList();
  }

  void addPromo(Map<String, dynamic> promo) {
    _vouchers.insert(0, promo);
    notifyListeners();
  }

  void togglePromoStatus(String code) {
    final index = _vouchers.indexWhere((v) {
      return v['code'] == code;
    });
    if (index != -1) {
      _vouchers[index]['isActive'] = !_vouchers[index]['isActive'];
      notifyListeners();
    }
  }

  void removePromo(String code) {
    _vouchers.removeWhere((v) {
      return v['code'] == code;
    });
    notifyListeners();
  }
}
