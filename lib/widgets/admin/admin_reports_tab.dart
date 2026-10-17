import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminReportsTab extends StatefulWidget {
  final Color brandColor;

  const AdminReportsTab({
    super.key,
    required this.brandColor,
  });

  @override
  State<AdminReportsTab> createState() => _AdminReportsTabState();
}

class _AdminReportsTabState extends State<AdminReportsTab> {
  int _selectedPeriodIndex = 0;
  final List<String> _periods = ['Daily', 'Weekly', 'Monthly'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Platform Financial Reports', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F3F5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: List.generate(_periods.length, (idx) {
              final isSelected = _selectedPeriodIndex == idx;
              return Expanded(
                child: InkWell(
                  onTap: () => setState(() => _selectedPeriodIndex = idx),
                  borderRadius: BorderRadius.circular(14),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? widget.brandColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        _periods[idx],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? Colors.white : Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),

        const SizedBox(height: 16),

        _buildReportCard('Total Orders', '128', '↑ 12% vs. yesterday', Icons.inventory_2_rounded, const Color(0xFF1565C0), const Color(0xFFE3F2FD)),
        const SizedBox(height: 10),
        _buildReportCard('Total Revenue', '₱28,450', '↑ 15% vs. yesterday', Icons.payments_rounded, const Color(0xFF2E7D32), const Color(0xFFE8F5E9)),
        const SizedBox(height: 10),
        _buildReportCard('Avg. Delivery Time', '28 min', '↓ 8% vs. yesterday', Icons.access_time_filled_rounded, widget.brandColor, const Color(0xFFFFF3E0)),
        const SizedBox(height: 10),
        _buildReportCard('Customer Rating', '4.8 / 5', '↑ 2% vs. yesterday', Icons.star_rounded, Colors.amber[900]!, Colors.amber[50]!),
      ],
    );
  }

  Widget _buildReportCard(String title, String value, String change, IconData icon, Color color, Color bg) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500])),
                  Text(value, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w900, color: const Color(0xFF0F172A))),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
            child: Text(change, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: color)),
          ),
        ],
      ),
    );
  }
}
