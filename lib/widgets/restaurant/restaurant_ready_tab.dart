import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantReadyTab extends StatelessWidget {
  final List<Map<String, dynamic>> readyOrders;
  final Color brandColor;
  final ValueChanged<Map<String, dynamic>> onHandOverToRider;

  const RestaurantReadyTab({
    super.key,
    required this.readyOrders,
    required this.brandColor,
    required this.onHandOverToRider,
  });

  @override
  Widget build(BuildContext context) {
    if (readyOrders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              Icon(Icons.takeout_dining_outlined, size: 60, color: Colors.grey[300]),
              const SizedBox(height: 12),
              Text('No Orders Waiting for Rider', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
              const SizedBox(height: 4),
              Text('Food marked ready in the Kitchen tab will appear here.', textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500])),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ready Food Items Waiting for Rider Pickup', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
        const SizedBox(height: 14),
        ...readyOrders.map((order) {
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
                      decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(8)),
                      child: Text('READY FOR PICKUP', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF2E7D32))),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Text('Customer: ${order['customer']}', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.two_wheeler_rounded, size: 16, color: Color(0xFFFF5622)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Assigned Courier: ${order['rider']}',
                        style: GoogleFonts.poppins(fontSize: 12, color: brandColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () => onHandOverToRider(order),
                    icon: const Icon(Icons.check_circle_rounded, size: 18, color: Colors.white),
                    label: Text('Hand Over to Rider (Start Delivery)', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
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
