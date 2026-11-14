import 'package:flutter/material.dart';

class UserProfile extends ChangeNotifier {
  static final UserProfile _instance = UserProfile._internal();
  factory UserProfile() {
    return _instance;
  }
  UserProfile._internal();

  String _fullName = '';
  String _phoneNumber = '';
  String _dateOfBirth = '';
  String _gender = '';
  String _profilePic = '';

  String get fullName {
    return _fullName;
  }

  String get phoneNumber {
    return _phoneNumber;
  }

  String get dateOfBirth {
    return _dateOfBirth;
  }

  String get gender {
    return _gender;
  }

  String get profilePic {
    return _profilePic;
  }

  void updateProfile({
    String? fullName,
    String? phoneNumber,
    String? dateOfBirth,
    String? gender,
    String? profilePic,
  }) {
    if (fullName != null) {
      _fullName = fullName;
    }
    if (phoneNumber != null) {
      _phoneNumber = phoneNumber;
    }
    if (dateOfBirth != null) {
      _dateOfBirth = dateOfBirth;
    }
    if (gender != null) {
      _gender = gender;
    }
    if (profilePic != null) {
      _profilePic = profilePic;
    }
    notifyListeners();
  }
}
