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

  final List<RiderLeaderboardEntry> _entries = [
    RiderLeaderboardEntry(
      rank: '1st 🥇',
      name: 'Ricardo Dalisay',
      avatarUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&auto=format&fit=crop',
      totalDeliveries: 342,
      rating: 4.98,
      totalTipsEarned: 2450.00,
    ),
    RiderLeaderboardEntry(
      rank: '2nd 🥈',
      name: 'Cardo D.',
      avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop',
      totalDeliveries: 298,
      rating: 4.92,
      totalTipsEarned: 1890.00,
    ),
    RiderLeaderboardEntry(
      rank: '3rd 🥉',
      name: 'Boy Tsuper',
      avatarUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=200&auto=format&fit=crop',
      totalDeliveries: 275,
      rating: 4.88,
      totalTipsEarned: 1450.00,
    ),
  ];

  List<RiderLeaderboardEntry> get entries {
    return List.unmodifiable(_entries);
  }

  void addEntry(RiderLeaderboardEntry entry) {
    _entries.add(entry);
    notifyListeners();
  }
}
