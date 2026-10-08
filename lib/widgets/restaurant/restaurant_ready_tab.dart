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
              Text('No Orders Waiting for Rider', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
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
                      decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(8)),
                      child: Text('READY FOR PICKUP', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green[800])),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Customer: ${order['customer']}', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
                Text('Assigned Rider: ${order['rider']}', style: GoogleFonts.poppins(fontSize: 12, color: brandColor, fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () => onHandOverToRider(order),
                    icon: const Icon(Icons.two_wheeler_rounded, size: 18, color: Colors.white),
                    label: Text('Hand Over to Rider (Start Delivery)', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
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
