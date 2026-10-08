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
              Text('No Food Currently Preparing', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
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
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(order['id'], style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: brandColor)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: Colors.amber[50], borderRadius: BorderRadius.circular(8)),
                      child: Text('Cooking in Kitchen', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.amber[900])),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Customer: ${order['customer']}', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
                Text(order['items'], style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700])),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () => onMarkReady(order),
                    icon: const Icon(Icons.check_circle_rounded, size: 18, color: Colors.white),
                    label: Text('Mark Ready for Pickup', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
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
