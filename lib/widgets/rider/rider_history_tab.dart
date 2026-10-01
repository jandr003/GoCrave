import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderHistoryTab extends StatelessWidget {
  final List<Map<String, dynamic>> completedHistory;
  final Color brandColor;

  const RiderHistoryTab({
    super.key,
    required this.completedHistory,
    required this.brandColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Completed Delivery History',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        ...completedHistory.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8F5E9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Color(0xFF2E7D32), size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item['id']} • ${item['customer']}',
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${item['resto']} • ${item['time']}',
                        style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      item['payout'],
                      style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.green[800]),
                    ),
                    Text(
                      '+${item['tip']} Tip',
                      style: GoogleFonts.poppins(fontSize: 11, color: brandColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
