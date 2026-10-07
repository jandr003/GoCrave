import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../screens/rider_order_details_screen.dart';

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
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RiderOrderDetailsScreen(orderItem: item),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(18),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFEEEEEE)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE8F5E9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check_circle_rounded, color: Color(0xFF2E7D32), size: 22),
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
                          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w800, color: const Color(0xFF2E7D32)),
                        ),
                        Text(
                          '+${item['tip']} Tip',
                          style: GoogleFonts.poppins(fontSize: 11, color: brandColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.chevron_right_rounded, size: 18, color: Colors.grey),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
