import 'package:flutter/material.dart';

class TaxManager extends ChangeNotifier {
  static final TaxManager _instance = TaxManager._internal();
  factory TaxManager() {
    return _instance;
  }
  TaxManager._internal();

  final List<Map<String, dynamic>> _statements = [
    {
      'id': 'TAX-2026-Q3',
      'partnerName': 'Bulacan Goto King',
      'grossEarnings': '₱412,500.00',
      'withholdingTax': '₱20,625.00',
      'status': 'Generated & Filed',
      'period': 'Q3 2026 (BIR Form 2307)',
    },
    {
      'id': 'TAX-2026-Q3-R',
      'partnerName': 'Ricardo Dalisay (Rider)',
      'grossEarnings': '₱88,400.00',
      'withholdingTax': '₱4,420.00',
      'status': 'Pending Filing',
      'period': 'Q3 2026 (BIR Form 2307)',
    },
    {
      'id': 'TAX-2026-Q3-M2',
      'partnerName': 'Malolos Litson Manok',
      'grossEarnings': '₱650,200.00',
      'withholdingTax': '₱32,510.00',
      'status': 'Generated & Filed',
      'period': 'Q3 2026 (BIR Form 2307)',
    },
  ];

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
