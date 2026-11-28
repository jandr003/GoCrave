import 'package:flutter/material.dart';

class TableReservationItem {
  final String id;
  final String customerName;
  final int guests;
  final String timeSlot;
  String status;

  TableReservationItem({
    required this.id,
    required this.customerName,
    required this.guests,
    required this.timeSlot,
    this.status = 'Pending Confirmation',
  });
}

class TableReservationManager extends ChangeNotifier {
  static final TableReservationManager _instance = TableReservationManager._internal();
  factory TableReservationManager() {
    return _instance;
  }
  TableReservationManager._internal();

  final List<TableReservationItem> _reservations = [];

  List<TableReservationItem> get reservations {
    return List.unmodifiable(_reservations);
  }

  void acceptReservation(String id) {
    final index = _reservations.indexWhere((r) {
      return r.id == id;
    });
    if (index != -1) {
      _reservations[index].status = 'Confirmed & Reserved';
      notifyListeners();
    }
  }

  void declineReservation(String id) {
    final index = _reservations.indexWhere((r) {
      return r.id == id;
    });
    if (index != -1) {
      _reservations[index].status = 'Declined';
      notifyListeners();
    }
  }

  void addReservation(TableReservationItem item) {
    _reservations.insert(0, item);
    notifyListeners();
  }
}
