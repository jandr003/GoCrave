import 'dart:math';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'rider_fleet_manager.dart';

class AutoDispatchManager extends ChangeNotifier {
  static final AutoDispatchManager _instance = AutoDispatchManager._internal();
  factory AutoDispatchManager() {
    return _instance;
  }
  AutoDispatchManager._internal() {
    RiderFleetManager().addListener(_onFleetChanged);
  }

  bool _isAutoDispatchEnabled = true;
  final List<Map<String, dynamic>> _unassignedQueue = [];

  bool get isAutoDispatchEnabled {
    return _isAutoDispatchEnabled;
  }

  List<Map<String, dynamic>> get unassignedQueue {
    return List.unmodifiable(_unassignedQueue);
  }

  void toggleAutoDispatch(bool enabled) {
    _isAutoDispatchEnabled = enabled;
    notifyListeners();
  }

  void _onFleetChanged() {
    if (_isAutoDispatchEnabled && _unassignedQueue.isNotEmpty) {
      processQueue();
    }
  }

  void processQueue() {
    if (_unassignedQueue.isEmpty) {
      return;
    }

    final queueCopy = List<Map<String, dynamic>>.from(_unassignedQueue);
    for (var orderData in queueCopy) {
      final LatLng? storeLatLng = orderData['storeLatLng'] as LatLng?;
      if (storeLatLng != null) {
        final nearest = findNearestAvailableRider(storeLatLng);
        if (nearest != null) {
          RiderFleetManager().updateRiderStatus(nearest['id'], 'On Delivery');
          _unassignedQueue.remove(orderData);
          notifyListeners();
          break;
        }
      }
    }
  }

  Map<String, dynamic>? findNearestAvailableRider(LatLng storeLocation) {
    final riders = RiderFleetManager().riders;
    final availableRiders = riders.where((r) {
      return r['status'] == 'Available';
    }).toList();

    if (availableRiders.isEmpty) {
      return null;
    }

    Map<String, dynamic>? nearestRider;
    double shortestDistance = double.infinity;

    for (var rider in availableRiders) {
      final LatLng riderLatLng = rider['latLng'] ?? const LatLng(14.8560, 120.8190);
      final double distance = _calculateHaversineDistance(
        storeLocation.latitude,
        storeLocation.longitude,
        riderLatLng.latitude,
        riderLatLng.longitude,
      );

      if (distance < shortestDistance) {
        shortestDistance = distance;
        nearestRider = rider;
      }
    }

    return nearestRider;
  }

  double _calculateHaversineDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadiusKm = 6371.0;
    final double dLat = _degreesToRadians(lat2 - lat1);
    final double dLon = _degreesToRadians(lon2 - lon1);

    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) * cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) * sin(dLon / 2);

    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusKm * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }

  Map<String, dynamic>? dispatchOrder(LatLng storeLocation, {String? orderId}) {
    if (!_isAutoDispatchEnabled) {
      return null;
    }

    final nearest = findNearestAvailableRider(storeLocation);
    if (nearest != null) {
      RiderFleetManager().updateRiderStatus(nearest['id'], 'On Delivery');
      notifyListeners();
      return nearest;
    } else {
      if (orderId != null) {
        _unassignedQueue.add({
          'orderId': orderId,
          'storeLatLng': storeLocation,
          'timestamp': DateTime.now(),
        });
        notifyListeners();
      }
    }
    return null;
  }
}
