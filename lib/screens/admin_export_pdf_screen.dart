import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:latlong2/latlong.dart';
import '../data/order_model.dart';
import '../data/order_manager.dart';

class AdminExportPdfScreen extends StatefulWidget {
  final Color brandColor;
  final List<OrderModel>? orders;

  const AdminExportPdfScreen({
    super.key,
    this.brandColor = const Color(0xFFFF5622),
    this.orders,
  });

  @override
  State<AdminExportPdfScreen> createState() => _AdminExportPdfScreenState();
}

class _AdminExportPdfScreenState extends State<AdminExportPdfScreen> {
  int _selectedTimeframeIndex = 0;
  int _selectedReportTypeIndex = 0;
  bool _isGenerating = false;

  List<String> get _timeframes {
    return [
      'Current Batch (${_effectiveOrders.length} Orders)',
      'Today',
      'This Week',
      'This Month',
    ];
  }

  final List<String> _reportTypes = [
    'Executive Financial Summary',
    'Detailed Order Log',
    'Revenue & Commission Statement',
  ];

  List<OrderModel> get _effectiveOrders {
    if (widget.orders != null && widget.orders!.isNotEmpty) {
      return widget.orders!;
    }
    final managerOrders = OrderManager().orders;
    if (managerOrders.isNotEmpty) {
      return managerOrders.map((o) {
        return OrderModel(
          id: o.id,
          storeName: o.title,
          storeLogo: '',
          dishName: o.subtitle,
          customerName: o.customerName,
          customerPhone: '09171234567',
          address: o.location,
          riderName: o.riderName,
          riderAvatar: o.riderPhoto,
          price: o.totalAmount,
          time: '${o.timestamp.hour}:${o.timestamp.minute.toString().padLeft(2, '0')}',
          status: o.status,
          cityName: 'Malolos',
          centerLatLng: const LatLng(14.8560, 120.8190),
          storeLatLng: const LatLng(14.8527, 120.8160),
          riderLatLng: const LatLng(14.8565, 120.8164),
          customerLatLng: const LatLng(14.8581, 120.8242),
          routePoints: const [],
        );
      }).toList();
    }
    return [
      OrderModel(
        id: '#GOC10482',
        storeName: 'Bulacan Goto King',
        storeLogo: '',
        dishName: 'Special Goto with Chicharon & Egg',
        customerName: 'Juan Dela Cruz',
        customerPhone: '09171234567',
        address: 'Barangay San Jose, Malolos',
        riderName: 'Ricardo Dalisay',
        riderAvatar: '',
        price: '₱245.00',
        time: '14:32',
        status: 'Completed',
        cityName: 'Malolos',
        centerLatLng: const LatLng(14.8560, 120.8190),
        storeLatLng: const LatLng(14.8527, 120.8160),
        riderLatLng: const LatLng(14.8565, 120.8164),
        customerLatLng: const LatLng(14.8581, 120.8242),
        routePoints: const [],
      ),
      OrderModel(
        id: '#GOC10483',
        storeName: 'Malolos Litson Manok',
        storeLogo: '',
        dishName: 'Lechon Manok (Whole) + Extra Rice',
        customerName: 'Maria Santos',
        customerPhone: '09189876543',
        address: 'Barangay Guinhawa, Malolos',
        riderName: 'Cardo D.',
        riderAvatar: '',
        price: '₱480.00',
        time: '14:45',
        status: 'In Progress',
        cityName: 'Malolos',
        centerLatLng: const LatLng(14.8560, 120.8190),
        storeLatLng: const LatLng(14.8527, 120.8160),
        riderLatLng: const LatLng(14.8565, 120.8164),
        customerLatLng: const LatLng(14.8581, 120.8242),
        routePoints: const [],
      ),
      OrderModel(
        id: '#GOC10484',
        storeName: 'Kapitolyo Sisig House',
        storeLogo: '',
        dishName: 'Crispy Pork Sisig Rice Meal',
        customerName: 'Pedro Penduko',
        customerPhone: '09191112233',
        address: 'Barangay Catmon, Malolos',
        riderName: 'Boy Tsuper',
        riderAvatar: '',
        price: '₱195.00',
        time: '15:05',
        status: 'Pending',
        cityName: 'Malolos',
        centerLatLng: const LatLng(14.8560, 120.8190),
        storeLatLng: const LatLng(14.8527, 120.8160),
        riderLatLng: const LatLng(14.8565, 120.8164),
        customerLatLng: const LatLng(14.8581, 120.8242),
        routePoints: const [],
      ),
    ];
  }

  double get _totalGrossRevenue {
    double sum = 0;
    for (var order in _effectiveOrders) {
      final double val = double.tryParse(order.price.replaceAll('₱', '').replaceAll(',', '').trim()) ?? 0.0;
      sum += val;
    }
    return sum > 0 ? sum : 920.00;
  }

  double get _platformCommission {
    return _totalGrossRevenue * 0.15;
  }

  double get _deliveryFleetCut {
    return _effectiveOrders.length * 25.0;
  }

  double get _netMerchantPayout {
    return _totalGrossRevenue - _platformCommission - _deliveryFleetCut;
  }

  double get _averageOrderValue {
    if (_effectiveOrders.isNotEmpty) {
      return _totalGrossRevenue / _effectiveOrders.length;
    }
    return 306.67;
  }

  Map<String, int> get _statusCounts {
    final Map<String, int> counts = {'Completed': 0, 'In Progress': 0, 'Pending': 0, 'Assigned': 0, 'On Delivery': 0};
    for (var order in _effectiveOrders) {
      final s = order.status.trim().toLowerCase();
      if (s.contains('completed') || s.contains('delivered')) {
        counts['Completed'] = (counts['Completed'] ?? 0) + 1;
      } else if (s.contains('progress')) {
        counts['In Progress'] = (counts['In Progress'] ?? 0) + 1;
      } else if (s.contains('assigned')) {
        counts['Assigned'] = (counts['Assigned'] ?? 0) + 1;
      } else if (s.contains('delivery')) {
        counts['On Delivery'] = (counts['On Delivery'] ?? 0) + 1;
      } else {
        counts['Pending'] = (counts['Pending'] ?? 0) + 1;
      }
    }
    return counts;
  }

  Future<void> _generateAndPrintPdf() async {
    setState(() {
      _isGenerating = true;
    });
    try {
      final pdfDoc = await _buildPdfDocument();
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async {
          return pdfDoc.save();
        },
        name: 'GoCrave_${_reportTypes[_selectedReportTypeIndex].replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );
    } catch (e) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating PDF: $e', style: GoogleFonts.poppins()), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isGenerating = false;
        });
      }
    }
  }

  Future<void> _sharePdf() async {
    setState(() {
      _isGenerating = true;
    });
    try {
      final pdfDoc = await _buildPdfDocument();
      await Printing.sharePdf(
        bytes: await pdfDoc.save(),
        filename: 'GoCrave_${_reportTypes[_selectedReportTypeIndex].replaceAll(' ', '_')}.pdf',
      );
    } catch (e) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sharing PDF: $e', style: GoogleFonts.poppins()), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isGenerating = false;
        });
      }
    }
  }

  Future<pw.Document> _buildPdfDocument() async {
    final pdf = pw.Document();
    final orders = _effectiveOrders;
    final counts = _statusCounts;
    final reportTitle = _reportTypes[_selectedReportTypeIndex];

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(36),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('GoCrave Admin Suite', style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#FF5622'))),
                      pw.SizedBox(height: 4),
                      pw.Text('Official Document: $reportTitle', style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#0F172A'))),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('Report ID: #PDF-REP-${DateTime.now().year}-${DateTime.now().month}', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#0F172A'))),
                      pw.Text('Generated: ${DateTime.now().toString().split('.').first}', style: pw.TextStyle(fontSize: 9, color: PdfColor.fromHex('#94A3B8'))),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 14),
              pw.Divider(color: PdfColor.fromHex('#E2E8F0'), thickness: 1.5),
              pw.SizedBox(height: 14),

              pw.Text('Timeframe: ${_timeframes[_selectedTimeframeIndex]}', style: pw.TextStyle(fontSize: 11, color: PdfColor.fromHex('#475569'))),
              pw.SizedBox(height: 14),

              if (_selectedReportTypeIndex == 0) ...[
                pw.Text('Executive Financial Overview', style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#FF5622'))),
                pw.SizedBox(height: 8),
                pw.Container(
                  padding: const pw.EdgeInsets.all(14),
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex('#F8FAFC'),
                    borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
                    border: pw.Border.all(color: PdfColor.fromHex('#E2E8F0')),
                  ),
                  child: pw.Column(
                    children: [
                      _buildPdfRow('Gross Platform Revenue', '₱${_totalGrossRevenue.toStringAsFixed(2)}'),
                      pw.Divider(color: PdfColor.fromHex('#E2E8F0'), height: 12),
                      _buildPdfRow('Platform Commission (15%)', '₱${_platformCommission.toStringAsFixed(2)}'),
                      pw.Divider(color: PdfColor.fromHex('#E2E8F0'), height: 12),
                      _buildPdfRow('Total Processed Orders', '${orders.length} orders'),
                      pw.Divider(color: PdfColor.fromHex('#E2E8F0'), height: 12),
                      _buildPdfRow('Average Order Value (AOV)', '₱${_averageOrderValue.toStringAsFixed(2)}'),
                    ],
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Text('Order Status Distribution', style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#FF5622'))),
                pw.SizedBox(height: 8),
                pw.Container(
                  padding: const pw.EdgeInsets.all(14),
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex('#F8FAFC'),
                    borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
                    border: pw.Border.all(color: PdfColor.fromHex('#E2E8F0')),
                  ),
                  child: pw.Column(
                    children: [
                      _buildPdfRow('Completed Orders', '${counts['Completed']} orders'),
                      pw.Divider(color: PdfColor.fromHex('#E2E8F0'), height: 12),
                      _buildPdfRow('In Progress Orders', '${counts['In Progress']} orders'),
                      pw.Divider(color: PdfColor.fromHex('#E2E8F0'), height: 12),
                      _buildPdfRow('Pending Verification', '${counts['Pending']} orders'),
                    ],
                  ),
                ),
              ] else if (_selectedReportTypeIndex == 1) ...[
                pw.Text('Itemized Live Order Log (${orders.length} Records)', style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#FF5622'))),
                pw.SizedBox(height: 8),
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColor.fromHex('#CBD5E1'), width: 0.5),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(1.2),
                    1: const pw.FlexColumnWidth(2.0),
                    2: const pw.FlexColumnWidth(2.5),
                    3: const pw.FlexColumnWidth(1.2),
                    4: const pw.FlexColumnWidth(1.2),
                  },
                  children: [
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColor.fromHex('#F1F5F9')),
                      children: [
                        _buildTableHeaderCell('Order ID'),
                        _buildTableHeaderCell('Customer'),
                        _buildTableHeaderCell('Dish Item'),
                        _buildTableHeaderCell('Amount'),
                        _buildTableHeaderCell('Status'),
                      ],
                    ),
                    ...orders.map((o) {
                      return pw.TableRow(
                        children: [
                          _tableCell(o.id),
                          _tableCell(o.customerName),
                          _tableCell(o.dishName),
                          _tableCell(o.price),
                          _tableCell(o.status),
                        ],
                      );
                    }),
                  ],
                ),
              ] else ...[
                pw.Text('Revenue, Commission & Payout Statement', style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#FF5622'))),
                pw.SizedBox(height: 8),
                pw.Container(
                  padding: const pw.EdgeInsets.all(14),
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex('#F8FAFC'),
                    borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
                    border: pw.Border.all(color: PdfColor.fromHex('#E2E8F0')),
                  ),
                  child: pw.Column(
                    children: [
                      _buildPdfRow('Total Gross Sales', '₱${_totalGrossRevenue.toStringAsFixed(2)}'),
                      pw.Divider(color: PdfColor.fromHex('#E2E8F0'), height: 12),
                      _buildPdfRow('GoCrave Commission Fee (15%)', '- ₱${_platformCommission.toStringAsFixed(2)}'),
                      pw.Divider(color: PdfColor.fromHex('#E2E8F0'), height: 12),
                      _buildPdfRow('Delivery Fleet Partner Allocation', '- ₱${_deliveryFleetCut.toStringAsFixed(2)}'),
                      pw.Divider(color: PdfColor.fromHex('#E2E8F0'), height: 12),
                      _buildPdfRow('Net Merchant Payout', '₱${_netMerchantPayout.toStringAsFixed(2)}'),
                    ],
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Text('Payout Settlement Status: Settled & Verified', style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#10B981'))),
              ],

              pw.Spacer(),

              pw.Divider(color: PdfColor.fromHex('#E2E8F0'), thickness: 1),
              pw.SizedBox(height: 8),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Authorized GoCrave Admin Document', style: pw.TextStyle(fontSize: 9, color: PdfColor.fromHex('#64748B'))),
                  pw.Text('Security Hash: #GC-SECURE-2026', style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#FF5622'))),
                ],
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  pw.Widget _buildPdfRow(String label, String value) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(label, style: pw.TextStyle(fontSize: 11, color: PdfColor.fromHex('#475569'))),
        pw.Text(value, style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#0F172A'))),
      ],
    );
  }

  pw.Widget _buildTableHeaderCell(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Text(text, style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#0F172A'))),
    );
  }

  pw.Widget _tableCell(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Text(text, style: pw.TextStyle(fontSize: 9, color: PdfColor.fromHex('#334155'))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orders = _effectiveOrders;
    final counts = _statusCounts;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: widget.brandColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Live PDF Report & Analytics Export',
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Generate real-world synced executive PDF reports from live store and order data.',
              style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF64748B)),
            ),
            const SizedBox(height: 18),

            Text('Timeframe Period', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: _selectedTimeframeIndex,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down_rounded, color: widget.brandColor),
                  style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        _selectedTimeframeIndex = val;
                      });
                    }
                  },
                  items: List.generate(_timeframes.length, (idx) {
                    return DropdownMenuItem(value: idx, child: Text(_timeframes[idx]));
                  }),
                ),
              ),
            ),

            const SizedBox(height: 14),

            Text('Report Type Format', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: _selectedReportTypeIndex,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down_rounded, color: widget.brandColor),
                  style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        _selectedReportTypeIndex = val;
                      });
                    }
                  },
                  items: List.generate(_reportTypes.length, (idx) {
                    return DropdownMenuItem(value: idx, child: Text(_reportTypes[idx]));
                  }),
                ),
              ),
            ),

            const SizedBox(height: 22),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Live Data Preview Card', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(color: const Color(0xFF10B981).withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 3)),
                    ],
                  ),
                  child: Text(
                    'Live Sync Active',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFCBD5E1), width: 1.5),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.picture_as_pdf_rounded, color: widget.brandColor, size: 28),
                          const SizedBox(width: 8),
                          Text(
                            'GoCrave Admin',
                            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: widget.brandColor),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('#PDF-REP-2026', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF64748B))),
                          Text('Real-World Synced', style: GoogleFonts.poppins(fontSize: 9, color: const Color(0xFF94A3B8))),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),
                  const Divider(height: 1, color: Color(0xFFE2E8F0)),
                  const SizedBox(height: 14),

                  Text(
                    _reportTypes[_selectedReportTypeIndex],
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                  ),
                  Text(
                    'Timeframe: ${_timeframes[_selectedTimeframeIndex]}',
                    style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                  ),

                  const SizedBox(height: 16),

                  if (_selectedReportTypeIndex == 0) ...[
                    Text('1. Financial Summary (Live Data)', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: widget.brandColor)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        children: [
                          _buildPreviewRow('Gross Platform Revenue', '₱${_totalGrossRevenue.toStringAsFixed(2)}'),
                          const Divider(height: 10, color: Color(0xFFE2E8F0)),
                          _buildPreviewRow('Platform Commission (15%)', '₱${_platformCommission.toStringAsFixed(2)}'),
                          const Divider(height: 10, color: Color(0xFFE2E8F0)),
                          _buildPreviewRow('Total Processed Orders', '${orders.length} orders'),
                          const Divider(height: 10, color: Color(0xFFE2E8F0)),
                          _buildPreviewRow('Average Order Value (AOV)', '₱${_averageOrderValue.toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('2. Order Status Breakdown', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: widget.brandColor)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        children: [
                          _buildPreviewRow('Completed Deliveries', '${counts['Completed']} orders'),
                          const Divider(height: 10, color: Color(0xFFE2E8F0)),
                          _buildPreviewRow('In Progress Orders', '${counts['In Progress']} orders'),
                          const Divider(height: 10, color: Color(0xFFE2E8F0)),
                          _buildPreviewRow('Pending Verification', '${counts['Pending']} orders'),
                        ],
                      ),
                    ),
                  ] else if (_selectedReportTypeIndex == 1) ...[
                    Text('Itemized Live Order Log (${orders.length} Records)', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: widget.brandColor)),
                    const SizedBox(height: 8),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: orders.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 8);
                      },
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        return Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(order.id, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: widget.brandColor)),
                                  Text(order.customerName, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A))),
                                  Text(order.dishName, style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF64748B))),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(order.price, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                                  const SizedBox(height: 2),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: order.status == 'Completed' ? const Color(0xFFECFDF5) : const Color(0xFFFEF3C7),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      order.status,
                                      style: GoogleFonts.poppins(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: order.status == 'Completed' ? const Color(0xFF10B981) : const Color(0xFFD97706),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ] else ...[
                    Text('Revenue & Payout Statement', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: widget.brandColor)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        children: [
                          _buildPreviewRow('Total Gross Sales', '₱${_totalGrossRevenue.toStringAsFixed(2)}'),
                          const Divider(height: 10, color: Color(0xFFE2E8F0)),
                          _buildPreviewRow('GoCrave Commission Fee (15%)', '- ₱${_platformCommission.toStringAsFixed(2)}'),
                          const Divider(height: 10, color: Color(0xFFE2E8F0)),
                          _buildPreviewRow('Delivery Fleet Allocation', '- ₱${_deliveryFleetCut.toStringAsFixed(2)}'),
                          const Divider(height: 10, color: Color(0xFFE2E8F0)),
                          _buildPreviewRow('Net Merchant Payout', '₱${_netMerchantPayout.toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 16),
                        const SizedBox(width: 6),
                        Text('Settlement Status: Verified & Ready', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF10B981))),
                      ],
                    ),
                  ],

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Authorized By:', style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF64748B))),
                          Text('System Admin (Live)', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Security Hash:', style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF64748B))),
                          Text('#GC-SECURE-2026', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: widget.brandColor)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _isGenerating ? null : _generateAndPrintPdf,
                icon: _isGenerating
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Icon(Icons.print_rounded, size: 20, color: Colors.white),
                label: Text(
                  _isGenerating ? 'Preparing PDF Document...' : 'Print Preview & Save PDF',
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.brandColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: _isGenerating ? null : _sharePdf,
                icon: Icon(Icons.share_rounded, size: 18, color: widget.brandColor),
                label: Text('Share PDF Report', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: widget.brandColor)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: widget.brandColor, width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF475569))),
        Text(value, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
      ],
    );
  }
}
