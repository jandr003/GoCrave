import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderAvailableOrdersTab extends StatelessWidget {
  final bool isOnline;
  final List<Map<String, dynamic>> availableRequests;
  final Color brandColor;
  final ValueChanged<Map<String, dynamic>> onAcceptDelivery;

  const RiderAvailableOrdersTab({
    super.key,
    required this.isOnline,
    required this.availableRequests,
    required this.brandColor,
    required this.onAcceptDelivery,
  });

  @override
  Widget build(BuildContext context) {
    if (!isOnline) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              Icon(Icons.portable_wifi_off_rounded, size: 60, color: Colors.grey[400]),
              const SizedBox(height: 12),
              Text(
                'You are currently OFFLINE',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Toggle the Online switch at the top to receive new delivery orders.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      );
    }

    if (availableRequests.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              Icon(Icons.check_circle_outline_rounded, size: 60, color: Colors.green[300]),
              const SizedBox(height: 12),
              Text(
                'No pending requests nearby',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'New orders from restaurants will appear here automatically.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nearby Orders',
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
            ),
            Text(
              'See All >',
              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: brandColor),
            ),
          ],
        ),
        const SizedBox(height: 14),

        ...availableRequests.map((req) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFEEEEEE)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
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
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        req['id'],
                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: brandColor),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        req['payout'],
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF2E7D32),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.store_rounded, color: Colors.black87, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                req['restaurant'],
                                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                              Text(
                                req['distance'],
                                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: brandColor),
                              ),
                            ],
                          ),
                          Text(
                            req['restoAddress'],
                            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: brandColor.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.location_on_rounded, color: brandColor, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Customer: ${req['customer']}',
                            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          Text(
                            req['customerAddress'],
                            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FC),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFEEEEEE)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.fastfood_outlined, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          req['items'],
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[800], fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () => onAcceptDelivery(req),
                    icon: const Icon(Icons.check_circle_rounded, size: 18, color: Colors.white),
                    label: Text(
                      'Accept Delivery',
                      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
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
