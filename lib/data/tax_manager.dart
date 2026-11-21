import 'package:flutter/material.dart';

class TaxManager extends ChangeNotifier {
  static final TaxManager _instance = TaxManager._internal();
  factory TaxManager() {
    return _instance;
  }
  TaxManager._internal();

  final List<Map<String, dynamic>> _statements = [];

  List<Map<String, dynamic>> get statements {
    return List.unmodifiable(_statements);
  }

  void fileTaxStatement(String id) {
    final index = _statements.indexWhere((s) {
      return s['id'] == id;
    });
    if (index != -1) {
      _statements[index]['status'] = 'Generated & Filed';
      notifyListeners();
    }
  }

  void addStatement(Map<String, dynamic> statement) {
    _statements.insert(0, statement);
    notifyListeners();
  }
}
