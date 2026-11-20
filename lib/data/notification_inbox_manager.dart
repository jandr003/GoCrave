import 'package:flutter/material.dart';

class InboxNotificationItem {
  final String id;
  final String title;
  final String body;
  final String category;
  final String timestamp;
  bool isUnread;

  InboxNotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.category,
    required this.timestamp,
    this.isUnread = true,
  });
}

class NotificationInboxManager extends ChangeNotifier {
  static final NotificationInboxManager _instance = NotificationInboxManager._internal();
  factory NotificationInboxManager() {
    return _instance;
  }
  NotificationInboxManager._internal();

  final List<InboxNotificationItem> _notifications = [
    InboxNotificationItem(
      id: 'INB-001',
      title: 'Order #GOC10482 on the Way',
      body: 'Your rider Ramon Castillo is currently navigating towards your delivery address.',
      category: 'Orders',
      timestamp: '5 mins ago',
      isUnread: true,
    ),
    InboxNotificationItem(
      id: 'INB-002',
      title: '30% Off Promo Applied!',
      body: 'Your voucher CRAVE30DEAL has been successfully applied to your active bag.',
      category: 'Promos',
      timestamp: '1 hour ago',
      isUnread: true,
    ),
    InboxNotificationItem(
      id: 'INB-003',
      title: 'Welcome to GoCrave Rewards!',
      body: 'You earned 50 bonus loyalty coins on your first food order.',
      category: 'System',
      timestamp: 'Yesterday',
      isUnread: false,
    ),
  ];

  List<InboxNotificationItem> get notifications {
    return List.unmodifiable(_notifications);
  }

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) {
      return n.id == id;
    });
    if (index != -1) {
      _notifications[index].isUnread = false;
      notifyListeners();
    }
  }

  void markAllAsRead() {
    for (var n in _notifications) {
      n.isUnread = false;
    }
    notifyListeners();
  }

  void addNotification(String title, String body, String category) {
    _notifications.insert(
      0,
      InboxNotificationItem(
        id: 'INB-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        title: title,
        body: body,
        category: category,
        timestamp: 'Just now',
        isUnread: true,
      ),
    );
    notifyListeners();
  }

  void clearAll() {
    _notifications.clear();
    notifyListeners();
  }
}
