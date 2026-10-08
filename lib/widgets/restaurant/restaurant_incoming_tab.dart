import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantIncomingTab extends StatelessWidget {
  final bool isAcceptingOrders;
  final List<Map<String, dynamic>> incomingOrders;
  final Color brandColor;
  final ValueChanged<Map<String, dynamic>> onAcceptOrder;
  final ValueChanged<Map<String, dynamic>> onDeclineOrder;

  const RestaurantIncomingTab({
    super.key,
    required this.isAcceptingOrders,
    required this.incomingOrders,
    required this.brandColor,
    required this.onAcceptOrder,
    required this.onDeclineOrder,
  });

  @override
  Widget build(BuildContext context) {
    if (!isAcceptingOrders) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              Icon(Icons.pause_circle_filled_rounded, size: 60, color: Colors.grey[400]),
              const SizedBox(height: 12),
              Text('Kitchen is PAUSED', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('Turn on the Accepting switch at the top to receive new orders.', textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500])),
            ],
          ),
        ),
      );
    }

    if (incomingOrders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              Icon(Icons.check_circle_outline_rounded, size: 60, color: Colors.green[300]),
              const SizedBox(height: 12),
              Text('No Pending Incoming Orders', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('New customer orders will ring here automatically.', textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500])),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Incoming Customer Orders', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
        const SizedBox(height: 14),
        ...incomingOrders.map((order) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
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
                    Text(
                      order['total'],
                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w900, color: const Color(0xFF0F172A)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text('Customer: ${order['customer']}', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
                Text(order['address'], style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500])),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFFF9F9FB), borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ordered Dishes:', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                      const SizedBox(height: 4),
                      Text(order['items'], style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                      if (order['note'].toString().isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text('Note: ${order['note']}', style: GoogleFonts.poppins(fontSize: 12, color: brandColor, fontWeight: FontWeight.w500)),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => onDeclineOrder(order),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.redAccent),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: Text('Decline', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton.icon(
                        onPressed: () => onAcceptOrder(order),
                        icon: const Icon(Icons.soup_kitchen_rounded, size: 18, color: Colors.white),
                        label: Text('Accept & Start Prep', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: brandColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 0,
                        ),
                      ),
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
