import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantPreparingTab extends StatelessWidget {
  final List<Map<String, dynamic>> preparingOrders;
  final Color brandColor;
  final ValueChanged<Map<String, dynamic>> onMarkReady;

  const RestaurantPreparingTab({
    super.key,
    required this.preparingOrders,
    required this.brandColor,
    required this.onMarkReady,
  });

  @override
  Widget build(BuildContext context) {
    if (preparingOrders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              Icon(Icons.soup_kitchen_outlined, size: 60, color: Colors.grey[300]),
              const SizedBox(height: 12),
              Text('No Food Currently Preparing', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
              const SizedBox(height: 4),
              Text('Accept orders from the Incoming tab to start cooking.', textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500])),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Active Kitchen Cooking Pipeline', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
        const SizedBox(height: 14),
        ...preparingOrders.map((order) {
          final note = order['note']?.toString() ?? '';

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFEEEEEE)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 12, offset: const Offset(0, 4)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: const Color(0xFFFFF3E0), borderRadius: BorderRadius.circular(8)),
                      child: Text(order['id'], style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: brandColor)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: Colors.amber[50], borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.whatshot_rounded, color: Colors.orangeAccent, size: 14),
                          const SizedBox(width: 4),
                          Text('Cooking in Kitchen', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.amber[900])),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Text('Customer: ${order['customer']}', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
                Text(order['time'] ?? 'Started 8 mins ago', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500])),

                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFFF9F9FB), borderRadius: BorderRadius.circular(14)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ordered Dishes:', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                      const SizedBox(height: 4),
                      Text(order['items'], style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                      if (note.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text('Note: $note', style: GoogleFonts.poppins(fontSize: 12, color: brandColor, fontWeight: FontWeight.w500)),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () => onMarkReady(order),
                    icon: const Icon(Icons.check_circle_rounded, size: 18, color: Colors.white),
                    label: Text('Mark Ready for Pickup', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: brandColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
