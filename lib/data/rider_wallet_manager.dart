import 'package:flutter/material.dart';

class RiderCashoutTx {
  final String id;
  final double amount;
  final String method;
  final String accountNumber;
  final String status;
  final String timestamp;

  RiderCashoutTx({
    required this.id,
    required this.amount,
    required this.method,
    required this.accountNumber,
    required this.status,
    required this.timestamp,
  });
}

class RiderWalletManager extends ChangeNotifier {
  static final RiderWalletManager _instance = RiderWalletManager._internal();
  factory RiderWalletManager() {
    return _instance;
  }
  RiderWalletManager._internal();

  double _availableBalance = 3450.00;
  double _todayEarnings = 1250.00;
  double _codCollection = 1420.00;

  final List<RiderCashoutTx> _transactions = [
    RiderCashoutTx(
      id: 'CSH-901',
      amount: 2500.00,
      method: 'GCash',
      accountNumber: '0917 ••• •456',
      status: 'Successful',
      timestamp: 'Yesterday, 06:30 PM',
    ),
    RiderCashoutTx(
      id: 'CSH-902',
      amount: 1800.00,
      method: 'BPI Bank',
      accountNumber: '•••• •••• 8842',
      status: 'Successful',
      timestamp: 'Nov 18, 2026',
    ),
  ];

  double get availableBalance {
    return _availableBalance;
  }

  double get todayEarnings {
    return _todayEarnings;
  }

  double get codCollection {
    return _codCollection;
  }

  List<RiderCashoutTx> get transactions {
    return List.unmodifiable(_transactions);
  }

  bool requestCashout(double amount, String method, String accountNumber) {
    if (amount <= 0 || amount > _availableBalance) {
      return false;
    }

    _availableBalance -= amount;
    _transactions.insert(
      0,
      RiderCashoutTx(
        id: 'CSH-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        amount: amount,
        method: method,
        accountNumber: accountNumber,
        status: 'Processing (Instant)',
        timestamp: 'Just now',
      ),
    );
    notifyListeners();
    return true;
  }

  void addEarnings(double amount) {
    _availableBalance += amount;
    _todayEarnings += amount;
    notifyListeners();
  }
}
