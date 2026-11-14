import 'package:flutter/material.dart';

class SupportManager extends ChangeNotifier {
  static final SupportManager _instance = SupportManager._internal();
  factory SupportManager() {
    return _instance;
  }
  SupportManager._internal();

  final List<Map<String, dynamic>> _threads = [
    {
      'id': 'THR-001',
      'userName': 'Juan Dela Cruz',
      'role': 'Customer',
      'avatar': 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=200&auto=format&fit=crop',
      'lastMessage': 'Where is my order #GOC10482?',
      'time': '2 mins ago',
      'status': 'Active',
      'messages': [
        {'sender': 'Customer', 'text': 'Hello admin, where is my order #GOC10482?', 'time': '10:30 AM'},
        {'sender': 'Admin', 'text': 'Hi Juan, your rider is currently on the way to your delivery address.', 'time': '10:32 AM'},
        {'sender': 'Customer', 'text': 'Where is my order #GOC10482?', 'time': '10:35 AM'},
      ],
    },
    {
      'id': 'THR-002',
      'userName': 'Ricardo Dalisay',
      'role': 'Rider',
      'avatar': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&auto=format&fit=crop',
      'lastMessage': 'Customer address is unreachable.',
      'time': '8 mins ago',
      'status': 'Active',
      'messages': [
        {'sender': 'Rider', 'text': 'Admin, customer address is unreachable and phone is turned off.', 'time': '10:20 AM'},
      ],
    },
    {
      'id': 'THR-003',
      'userName': 'Bulacan Goto King',
      'role': 'Merchant',
      'avatar': 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?q=80&w=200&auto=format&fit=crop',
      'lastMessage': 'Kitchen stock updated for today.',
      'time': '25 mins ago',
      'status': 'Resolved',
      'messages': [
        {'sender': 'Merchant', 'text': 'Kitchen stock updated successfully for today.', 'time': '09:55 AM'},
        {'sender': 'Admin', 'text': 'Thank you for the update!', 'time': '09:58 AM'},
      ],
    },
  ];

  List<Map<String, dynamic>> get threads {
    return List.unmodifiable(_threads);
  }

  void sendMessage(String threadId, String text, String sender) {
    final threadIndex = _threads.indexWhere((t) {
      return t['id'] == threadId;
    });
    if (threadIndex != -1) {
      final messages = List<Map<String, dynamic>>.from(_threads[threadIndex]['messages']);
      messages.add({
        'sender': sender,
        'text': text,
        'time': 'Just now',
      });
      _threads[threadIndex]['messages'] = messages;
      _threads[threadIndex]['lastMessage'] = text;
      _threads[threadIndex]['time'] = 'Just now';
      notifyListeners();
    }
  }

  void resolveThread(String threadId) {
    final threadIndex = _threads.indexWhere((t) {
      return t['id'] == threadId;
    });
    if (threadIndex != -1) {
      _threads[threadIndex]['status'] = 'Resolved';
      notifyListeners();
    }
  }
}
