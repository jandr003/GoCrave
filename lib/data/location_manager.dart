import 'package:flutter/material.dart';

class LocationManager extends ChangeNotifier {
  static final LocationManager _instance = LocationManager._internal();
  factory LocationManager() => _instance;
  LocationManager._internal();

  String _addressLine1 = 'Metro Manila, Philippines';
  String _addressLine2 = '1230 España Blvd, Sampaloc, Manila';

  String get addressLine1 => _addressLine1;
  String get addressLine2 => _addressLine2;

  void updateLocation(String line1, String line2) {
    _addressLine1 = line1;
    _addressLine2 = line2;
    notifyListeners();
  }
}
