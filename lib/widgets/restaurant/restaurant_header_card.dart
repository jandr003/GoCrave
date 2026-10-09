import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantHeaderCard extends StatelessWidget {
  final bool isAcceptingOrders;
  final double todaySales;
  final int preparedOrdersCount;
  final Color brandColor;
  final ValueChanged<bool> onAcceptingChanged;

  const RestaurantHeaderCard({
    super.key,
    required this.isAcceptingOrders,
    required this.todaySales,
    required this.preparedOrdersCount,
    required this.brandColor,
    required this.onAcceptingChanged,
  });

  @override
  Widget build(BuildContext context) {
    String formattedSales = todaySales.toInt().toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: brandColor,
                child: const Icon(Icons.restaurant_rounded, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good day, Kitchen Staff',
                      style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
                    ),
                    Text(
                      'GoCrave Central Kitchen',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Merchant ID: #MERCHANT-501 • Open',
                      style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () => onAcceptingChanged(!isAcceptingOrders),
                borderRadius: BorderRadius.circular(20),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: isAcceptingOrders ? const Color(0xFFE8F5E9) : Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isAcceptingOrders ? Colors.green.withOpacity(0.3) : Colors.grey[300]!),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isAcceptingOrders ? const Color(0xFF2E7D32) : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        isAcceptingOrders ? 'Accepting' : 'Paused',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: isAcceptingOrders ? const Color(0xFF2E7D32) : Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 2),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 15,
                        color: isAcceptingOrders ? const Color(0xFF2E7D32) : Colors.grey[600],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              _buildStatTile(
                icon: Icons.payments_rounded,
                iconColor: const Color(0xFF2E7D32),
                iconBg: const Color(0xFFE8F5E9),
                value: '₱$formattedSales',
                label: 'Today Sales',
              ),
              const SizedBox(width: 8),
              _buildStatTile(
                icon: Icons.soup_kitchen_rounded,
                iconColor: brandColor,
                iconBg: const Color(0xFFFFF3E0),
                value: '$preparedOrdersCount Orders',
                label: 'Prepared',
              ),
              const SizedBox(width: 8),
              _buildStatTile(
                icon: Icons.access_time_filled_rounded,
                iconColor: const Color(0xFF1565C0),
                iconBg: const Color(0xFFE3F2FD),
                value: '14 Mins',
                label: 'Avg Prep',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatTile({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FC),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 16),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      value,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ),
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 9.5,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
