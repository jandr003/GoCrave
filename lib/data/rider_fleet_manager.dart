import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class RiderFleetManager extends ChangeNotifier {
  static final RiderFleetManager _instance = RiderFleetManager._internal();
  factory RiderFleetManager() {
    return _instance;
  }
  RiderFleetManager._internal();

  final List<Map<String, dynamic>> _riders = [];

  List<Map<String, dynamic>> get riders {
    return List.unmodifiable(_riders);
  }

  void updateRiderStatus(String id, String newStatus) {
    final index = _riders.indexWhere((r) {
      return r['id'] == id;
    });
    if (index != -1) {
      _riders[index]['status'] = newStatus;
      notifyListeners();
    }
  }

  void updateRiderLocation(String id, LatLng newLatLng) {
    final index = _riders.indexWhere((r) {
      return r['id'] == id;
    });
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
