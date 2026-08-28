import 'dart:math';

class AppNotification {
  final String title;
  final String body;
  final DateTime timestamp;

  AppNotification({
    required this.title,
    required this.body,
    required this.timestamp,
  });
}

class NotificationManager {
  static final NotificationManager _instance = NotificationManager._internal();

  factory NotificationManager() {
    return _instance;
  }

  NotificationManager._internal();

  final List<AppNotification> _notifications = [];

  List<AppNotification> get notifications => List.unmodifiable(_notifications);

  String generateAndAddOtp() {
    final otp = (Random().nextInt(90000) + 10000).toString();
    _notifications.insert(
      0,
      AppNotification(
        title: 'Messages',
        body: 'GoCrave: Your OTP code is $otp',
        timestamp: DateTime.now(),
      ),
    );
    return otp;
  }

  void clearHistory() {
    _notifications.clear();
  }
}
