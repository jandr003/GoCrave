import 'package:flutter/material.dart';

class SavedAddress {
  final String id;
  final String label;
  final String addressLine1;
  final String addressLine2;
  bool isSelected;

  SavedAddress({
    required this.id,
    required this.label,
    required this.addressLine1,
    required this.addressLine2,
    this.isSelected = false,
  });
}

class AddressBookManager extends ChangeNotifier {
  static final AddressBookManager _instance = AddressBookManager._internal();
  factory AddressBookManager() {
    return _instance;
  }
  AddressBookManager._internal();

  final List<SavedAddress> _addresses = [
    SavedAddress(
      id: 'ADDR-01',
      label: 'Home',
      addressLine1: 'Metro Manila, Philippines',
      addressLine2: '1230 España Blvd, Sampaloc, Manila',
      isSelected: true,
    ),
    SavedAddress(
      id: 'ADDR-02',
      label: 'Office / Work',
      addressLine1: 'BGC, Taguig City',
      addressLine2: '28th St, Bonifacio Global City',
      isSelected: false,
    ),
    SavedAddress(
      id: 'ADDR-03',
      label: 'Bulacan Residence',
      addressLine1: 'San Miguel, Bulacan',
      addressLine2: 'National Road, Brgy. San Jose',
      isSelected: false,
    ),
  ];

  List<SavedAddress> get addresses {
    return List.unmodifiable(_addresses);
  }

  SavedAddress get selectedAddress {
    for (var addr in _addresses) {
      if (addr.isSelected) {
        return addr;
      }
    }
    return _addresses.first;
  }

  void selectAddress(String id) {
    for (var addr in _addresses) {
      addr.isSelected = (addr.id == id);
    }
    notifyListeners();
  }

  void addAddress(String label, String line1, String line2) {
    for (var addr in _addresses) {
      addr.isSelected = false;
    }
    _addresses.add(
      SavedAddress(
        id: 'ADDR-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        label: label,
        addressLine1: line1,
        addressLine2: line2,
        isSelected: true,
      ),
    );
    notifyListeners();
  }

  void removeAddress(String id) {
    _addresses.removeWhere((addr) {
      return addr.id == id;
    });
    if (_addresses.isNotEmpty && !_addresses.any((a) {
      return a.isSelected;
    })) {
      _addresses.first.isSelected = true;
    }
    notifyListeners();
  }
}
