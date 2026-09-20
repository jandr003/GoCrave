import 'dart:math';
import 'package:flutter/material.dart';

class Order {
  final String id;
  final String title;
  final String subtitle;
  final String price;
  final String deliveryFee;
  final String totalAmount;
  final String customerName;
  final String location;
  final DateTime timestamp;
  String status;
  
  final String riderName;
  final String riderPhoto;
  final String plateNumber;
  final double rating;
  final double progress;

  Order({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.deliveryFee,
    required this.totalAmount,
    required this.customerName,
    required this.location,
    required this.timestamp,
    this.status = 'Processing',
    this.riderName = 'Ricardo Dalisay',
    this.riderPhoto = 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&auto=format&fit=crop',
    this.plateNumber = 'MVC 1234',
    this.rating = 4.9,
    this.progress = 0.45,
  });
}

class OrderManager extends ChangeNotifier {
  static final OrderManager _instance = OrderManager._internal();
  factory OrderManager() => _instance;
  OrderManager._internal();

  final List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders);

  Order placeOrder(Map<String, String> foodItem) {
    final random = Random();
    final orderId = '#GOC${random.nextInt(90000) + 10000}';
    
    double itemPrice = double.tryParse(foodItem['price']?.replaceAll('₱', '') ?? '0') ?? 0;
    double deliveryFee = 20.0;
    double total = itemPrice + deliveryFee;

    final newOrder = Order(
      id: orderId,
      title: foodItem['title'] ?? 'Unknown Item',
      subtitle: foodItem['subtitle'] ?? '',
      price: foodItem['price'] ?? '₱0.00',
      deliveryFee: '₱${deliveryFee.toStringAsFixed(2)}',
      totalAmount: '₱${total.toStringAsFixed(2)}',
      customerName: 'John Andrew',
      location: 'Brgy. San Miguel, Bulacan...',
      timestamp: DateTime.now(),
    );

    _orders.insert(0, newOrder);
    notifyListeners();
    return newOrder;
  }

  double getTotalSpent() {
    return _orders.fold(0, (sum, order) {
      double amount = double.tryParse(order.totalAmount.replaceAll('₱', '')) ?? 0;
      return sum + amount;
    });
  }
}
