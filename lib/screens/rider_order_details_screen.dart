import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderOrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> orderItem;

  const RiderOrderDetailsScreen({
    super.key,
    required this.orderItem,
  });

  @override
  Widget build(BuildContext context) {
    const Color brandColor = Color(0xFFFF5622);

    final String orderId = orderItem['id'] ?? '#GOC65112';
    final String customerName = orderItem['customer'] ?? 'Liza Soberano';
    final String restaurantName = orderItem['resto'] ?? 'Burger King - Balagtas';
    final String payoutStr = orderItem['payout'] ?? '₱90.00';
    final String tipStr = orderItem['tip'] ?? '₱20.00';
    final String timeStr = orderItem['time'] ?? '12:30 PM Today';

    double payoutNum = double.tryParse(payoutStr.replaceAll('₱', '')) ?? 90.0;
    double tipNum = double.tryParse(tipStr.replaceAll('₱', '')) ?? 20.0;
    double totalEarned = payoutNum + tipNum;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Delivery E-Receipt',
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F172A),
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFEEEEEE)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE8F5E9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_circle_rounded, color: Color(0xFF2E7D32), size: 42),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'DELIVERY COMPLETED',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E7D32),
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    '$orderId • Completed at $timeStr',
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF5F2),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFFFE0B2), width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rider Trip Earnings',
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Base Delivery Fee', style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700])),
                      Text(payoutStr, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Customer Tip', style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700])),
                      Text('+$tipStr', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: brandColor)),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(height: 1, color: Color(0xFFFFE0B2)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Earned', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
                      Text('₱${totalEarned.toStringAsFixed(2)}', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w900, color: const Color(0xFF2E7D32))),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Route & Locations',
                    style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 14),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.grey[100], shape: BoxShape.circle),
                        child: const Icon(Icons.store_rounded, color: Colors.black87, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(restaurantName, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold)),
                            Text('McArthur Highway, Balagtas, Bulacan', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500])),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 17.0, top: 4, bottom: 4),
                    child: Container(width: 2, height: 18, color: Colors.grey[300]),
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: brandColor.withOpacity(0.12), shape: BoxShape.circle),
                        child: Icon(Icons.location_on_rounded, color: brandColor, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Customer: $customerName', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold)),
                            Text('Brgy. Wawa, Balagtas, Bulacan • 0917 123 4567', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500])),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      const Icon(Icons.near_me_rounded, size: 14, color: brandColor),
                      const SizedBox(width: 4),
                      Text('3.2 km distance', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
                      const SizedBox(width: 16),
                      const Icon(Icons.access_time_rounded, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text('15 mins trip time', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dishes Delivered', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FC),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.fastfood_outlined, size: 18, color: Colors.grey),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '2x Whopper Burger Combo, 1x Onion Rings, 2x Coca-Cola Zero',
                            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(20),
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
                      Text('Customer Review', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text('5.0 Rating', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.amber[900])),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '"Super fast delivery! Food arrived hot and fresh. Thank you kuya rider!"',
                    style: GoogleFonts.poppins(fontSize: 13, fontStyle: FontStyle.italic, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('E-Receipt for $orderId shared successfully!', style: GoogleFonts.poppins()),
                      backgroundColor: brandColor,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.share_rounded, size: 18, color: Colors.white),
                label: Text('Share E-Receipt', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
