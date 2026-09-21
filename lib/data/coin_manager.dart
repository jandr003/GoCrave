import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoinManager extends ChangeNotifier {
  static final CoinManager _instance = CoinManager._internal();
  factory CoinManager() => _instance;
  CoinManager._internal();

  int _totalCoins = 0;
  int _currentStreak = 0;
  DateTime? _lastCheckIn;

  int get totalCoins => _totalCoins;
  int get currentStreak => _currentStreak;
  DateTime? get lastCheckIn => _lastCheckIn;

  bool get canClaimToday {
    if (_lastCheckIn == null) return true;
    final now = DateTime.now();
    return now.day != _lastCheckIn!.day || now.month != _lastCheckIn!.month || now.year != _lastCheckIn!.year;
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _totalCoins = prefs.getInt('totalCoins') ?? 0;
    _currentStreak = prefs.getInt('currentStreak') ?? 0;
    final lastCheckInStr = prefs.getString('lastCheckIn');
    if (lastCheckInStr != null) {
      _lastCheckIn = DateTime.parse(lastCheckInStr);
    }
    
    if (_lastCheckIn != null) {
      final now = DateTime.now();
      final difference = now.difference(_lastCheckIn!).inHours;
      if (difference >= 48) {
        _currentStreak = 0;
        await prefs.setInt('currentStreak', 0);
      }
    }
    notifyListeners();
  }

  Future<int> claimDailyReward() async {
    if (!canClaimToday) return 0;

    final prefs = await SharedPreferences.getInstance();
    
    int reward = (_currentStreak == 6) ? 500 : 50;
    
    _totalCoins += reward;
    _currentStreak = (_currentStreak + 1) % 7;
    _lastCheckIn = DateTime.now();

    await prefs.setInt('totalCoins', _totalCoins);
    await prefs.setInt('currentStreak', _currentStreak);
    await prefs.setString('lastCheckIn', _lastCheckIn!.toIso8601String());

    notifyListeners();
    return reward;
  }
}
