import 'dart:math';

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
  final String status;

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
    this.status = 'Complete',
  });
}

class OrderManager {
  static final OrderManager _instance = OrderManager._internal();
  factory OrderManager() => _instance;
  OrderManager._internal();

  final List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders);

  void placeOrder(Map<String, String> foodItem) {
    final random = Random();
    final orderId = '#GOC${random.nextInt(90000) + 10000}';
    
    double itemPrice = double.tryParse(foodItem['price']?.replaceAll('₱', '') ?? '0') ?? 0;
    double deliveryFee = 20.0;
    double total = itemPrice + deliveryFee;

    _orders.insert(0, Order(
      id: orderId,
      title: foodItem['title'] ?? 'Unknown Item',
      subtitle: foodItem['subtitle'] ?? '',
      price: foodItem['price'] ?? '₱0.00',
      deliveryFee: '₱${deliveryFee.toStringAsFixed(2)}',
      totalAmount: '₱${total.toStringAsFixed(2)}',
      customerName: 'John Andrew',
      location: 'Brgy. San Miguel, Bulacan...',
      timestamp: DateTime.now(),
    ));
  }

  double getTotalSpent() {
    return _orders.fold(0, (sum, order) {
      double amount = double.tryParse(order.totalAmount.replaceAll('₱', '')) ?? 0;
      return sum + amount;
    });
  }
}
