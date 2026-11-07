import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class RiderFleetManager extends ChangeNotifier {
  static final RiderFleetManager _instance = RiderFleetManager._internal();
  factory RiderFleetManager() => _instance;
  RiderFleetManager._internal();

  final List<Map<String, dynamic>> _riders = [
    {
      'id': 'R001',
      'name': 'Ricardo Dalisay',
      'status': 'On Delivery',
      'plate': 'MVC 1234',
      'rating': '4.9',
      'deliveries': '1,420',
      'phone': '09171234567',
      'latLng': const LatLng(14.8565, 120.8164),
      'avatar': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&auto=format&fit=crop',
    },
    {
      'id': 'R002',
      'name': 'Cardo D.',
      'status': 'Available',
      'plate': 'XYZ 5678',
      'rating': '4.8',
      'deliveries': '980',
      'phone': '09189876543',
      'latLng': const LatLng(14.8520, 120.8210),
      'avatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop',
    },
    {
      'id': 'R003',
      'name': 'Boy Tsuper',
      'status': 'On Delivery',
      'plate': 'ABC 9988',
      'rating': '4.95',
      'deliveries': '2,150',
      'phone': '09191112233',
      'latLng': const LatLng(14.8600, 120.8150),
      'avatar': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=200&auto=format&fit=crop',
    },
    {
      'id': 'R004',
      'name': 'Juan Makisig',
      'status': 'Offline',
      'plate': 'DEF 4321',
      'rating': '4.7',
      'deliveries': '540',
      'phone': '09205556677',
      'latLng': const LatLng(14.8505, 120.8120),
      'avatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop',
    },
  ];

  List<Map<String, dynamic>> get riders => List.unmodifiable(_riders);

  void updateRiderStatus(String id, String newStatus) {
    final index = _riders.indexWhere((r) => r['id'] == id);
    if (index != -1) {
      _riders[index]['status'] = newStatus;
      notifyListeners();
    }
  }

  void updateRiderLocation(String id, LatLng newLatLng) {
    final index = _riders.indexWhere((r) => r['id'] == id);
    if (index != -1) {
      _riders[index]['latLng'] = newLatLng;
      notifyListeners();
    }
  }

  void addRider(Map<String, dynamic> rider) {
    _riders.add(rider);
    notifyListeners();
  }
}
