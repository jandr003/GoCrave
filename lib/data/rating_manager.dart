import 'package:flutter/material.dart';

class OrderRating {
  final String orderId;
  final int stars;
  final String comment;
  final double tipAmount;
  final DateTime timestamp;

  OrderRating({
    required this.orderId,
    required this.stars,
    required this.comment,
    required this.tipAmount,
    required this.timestamp,
  });
}

class RatingManager extends ChangeNotifier {
  static final RatingManager _instance = RatingManager._internal();
  factory RatingManager() {
    return _instance;
  }
  RatingManager._internal();

  final List<OrderRating> _ratings = [];

  List<OrderRating> get ratings {
    return List.unmodifiable(_ratings);
  }

  void submitRating({
    required String orderId,
    required int stars,
    required String comment,
    required double tipAmount,
  }) {
    _ratings.insert(
      0,
      OrderRating(
        orderId: orderId,
        stars: stars,
        comment: comment,
        tipAmount: tipAmount,
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  bool hasRated(String orderId) {
    return _ratings.any((r) {
      return r.orderId == orderId;
    });
  }
}
