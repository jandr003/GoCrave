import 'package:flutter/material.dart';

class RiderLeaderboardEntry {
  final String rank;
  final String name;
  final String avatarUrl;
  final int totalDeliveries;
  final double rating;
  final double totalTipsEarned;

  RiderLeaderboardEntry({
    required this.rank,
    required this.name,
    required this.avatarUrl,
    required this.totalDeliveries,
    required this.rating,
    required this.totalTipsEarned,
  });
}

class RiderLeaderboardManager extends ChangeNotifier {
  static final RiderLeaderboardManager _instance = RiderLeaderboardManager._internal();
  factory RiderLeaderboardManager() {
    return _instance;
  }
  RiderLeaderboardManager._internal();

  final List<RiderLeaderboardEntry> _entries = [];

  List<RiderLeaderboardEntry> get entries {
    return List.unmodifiable(_entries);
  }

  void addEntry(RiderLeaderboardEntry entry) {
    _entries.add(entry);
    notifyListeners();
  }
}
