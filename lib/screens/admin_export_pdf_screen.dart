import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminExportPdfScreen extends StatefulWidget {
  final Color brandColor;

  const AdminExportPdfScreen({
    super.key,
    this.brandColor = const Color(0xFFFF5622),
  });

  @override
  State<AdminExportPdfScreen> createState() => _AdminExportPdfScreenState();
}

class _AdminExportPdfScreenState extends State<AdminExportPdfScreen> {
  int _selectedMonthIndex = 0;
  int _selectedReportTypeIndex = 0;
  bool _isGenerating = false;

  final List<String> _months = ['April 2025 (Monthly)', 'March 2025', 'February 2025', 'Q1 2025 Summary'];
  final List<String> _reportTypes = ['Executive Monthly Summary', 'Detailed Order Log', 'Revenue & Commission Statement'];

  void _downloadAndSavePdf() async {
    setState(() => _isGenerating = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    setState(() => _isGenerating = false);

    final String selectedMonthStr = _months[_selectedMonthIndex].split(' ')[0];
    final String fileName = 'GoCrave_Monthly_Analytics_${selectedMonthStr}_2025.pdf';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('PDF Report saved to /Download/$fileName', style: GoogleFonts.poppins()),
        backgroundColor: widget.brandColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'OPEN',
          textColor: Colors.white,
          onPressed: () {
            _showPdfViewerDialog(fileName);
          },
        ),
      ),
    );
  }

  void _showPdfViewerDialog(String fileName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        title: Row(
          children: [
            Icon(Icons.picture_as_pdf_rounded, color: widget.brandColor, size: 24),
            const SizedBox(width: 10),
            Text('PDF File Ready', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
          ],
        ),
        content: Text(
          'Document $fileName has been saved to your device download directory.',
          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF475569)),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.brandColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('OK', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: widget.brandColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Monthly Analytics PDF Report',
          style: GoogleFonts.poppins(
            fontSize: 18,
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
              'Select report timeframe and format to generate official PDF documentation.',
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
                  value: _selectedMonthIndex,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down_rounded, color: widget.brandColor),
                  style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedMonthIndex = val);
                  },
                  items: List.generate(_months.length, (idx) {
                    return DropdownMenuItem(value: idx, child: Text(_months[idx]));
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
                    if (val != null) setState(() => _selectedReportTypeIndex = val);
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
                Text('A4 Document Preview', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECFDF5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('PDF Ready', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF10B981))),
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
                          Image.asset(
                            'assets/images/gocrave_app_logo.png',
                            height: 32,
                            fit: BoxFit.contain,
                            gaplessPlayback: true,
                          ),
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
                          Text('#PDF-REP-2025-04', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF64748B))),
                          Text('Apr 26, 2025', style: GoogleFonts.poppins(fontSize: 9, color: const Color(0xFF94A3B8))),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),
                  const Divider(height: 1, color: Color(0xFFE2E8F0)),
                  const SizedBox(height: 14),

                  Text(
                    'Monthly Analytics & Financial Statement',
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                  ),
                  Text(
                    'Period: ${_months[_selectedMonthIndex]}',
                    style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                  ),

                  const SizedBox(height: 16),

                  Text('1. Financial Executive Summary', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: widget.brandColor)),
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
                        _buildPdfTableRow('Gross Platform Revenue', '₱810,825.00'),
                        const Divider(height: 10, color: Color(0xFFE2E8F0)),
                        _buildPdfTableRow('Platform Commission (15%)', '₱121,623.75'),
                        const Divider(height: 10, color: Color(0xFFE2E8F0)),
                        _buildPdfTableRow('Total Completed Orders', '3,648 orders'),
                        const Divider(height: 10, color: Color(0xFFE2E8F0)),
                        _buildPdfTableRow('Average Order Value (AOV)', '₱222.26'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text('2. Order Status Distribution', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: widget.brandColor)),
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
                        _buildPdfTableRow('Completed Deliveries', '2,042 orders (56%)'),
                        const Divider(height: 10, color: Color(0xFFE2E8F0)),
                        _buildPdfTableRow('In Progress Orders', '1,094 orders (30%)'),
                        const Divider(height: 10, color: Color(0xFFE2E8F0)),
                        _buildPdfTableRow('Pending Verification', '512 orders (14%)'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text('3. Delivery Fleet Operations', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: widget.brandColor)),
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
                        _buildPdfTableRow('Active Delivery Fleet', '24 Fleet Riders'),
                        const Divider(height: 10, color: Color(0xFFE2E8F0)),
                        _buildPdfTableRow('On-Time Delivery Rate', '96.4%'),
                        const Divider(height: 10, color: Color(0xFFE2E8F0)),
                        _buildPdfTableRow('Avg. Delivery Duration', '25.2 Minutes'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Authorized By:', style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF64748B))),
                          Text('System Admin01', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Security Signature:', style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF64748B))),
                          Text('#GC-PDF-SECURE-2025', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: widget.brandColor)),
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
                onPressed: _isGenerating ? null : _downloadAndSavePdf,
                icon: _isGenerating
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Icon(Icons.file_download_rounded, size: 20, color: Colors.white),
                label: Text(
                  _isGenerating ? 'Generating PDF Document...' : 'Download & Save PDF',
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
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Print preview sent to default printer.', style: GoogleFonts.poppins()),
                      backgroundColor: widget.brandColor,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: Icon(Icons.print_rounded, size: 18, color: widget.brandColor),
                label: Text('Print Document', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: widget.brandColor)),
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

  Widget _buildPdfTableRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF475569))),
        Text(value, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
      ],
    );
  }
}
