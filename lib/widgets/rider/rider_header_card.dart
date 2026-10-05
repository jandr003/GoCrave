import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderHeaderCard extends StatelessWidget {
  final String riderName;
  final String vehiclePlate;
  final String avatarUrl;
  final bool isOnline;
  final double todayEarnings;
  final int completedTripsCount;
  final Color brandColor;
  final ValueChanged<bool> onOnlineChanged;
  final VoidCallback onTapEditProfile;

  const RiderHeaderCard({
    super.key,
    required this.riderName,
    required this.vehiclePlate,
    required this.avatarUrl,
    required this.isOnline,
    required this.todayEarnings,
    required this.completedTripsCount,
    required this.brandColor,
    required this.onOnlineChanged,
    required this.onTapEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: onTapEditProfile,
                borderRadius: BorderRadius.circular(30),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: brandColor,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good morning,',
                      style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
                    ),
                    Text(
                      riderName,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 14),
                        const SizedBox(width: 2),
                        Text(
                          '4.9',
                          style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.amber[900]),
                        ),
                        Flexible(
                          child: Text(
                            '  |  🛵 $vehiclePlate',
                            style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600]),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () => onOnlineChanged(!isOnline),
                borderRadius: BorderRadius.circular(20),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isOnline ? const Color(0xFFE8F5E9) : Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isOnline ? Colors.green.withOpacity(0.3) : Colors.grey[300]!),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isOnline ? const Color(0xFF2E7D32) : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        isOnline ? 'Online' : 'Offline',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isOnline ? const Color(0xFF2E7D32) : Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 16,
                        color: isOnline ? const Color(0xFF2E7D32) : Colors.grey[600],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          Row(
            children: [
              _buildStatTile(
                icon: Icons.account_balance_wallet_rounded,
                iconColor: const Color(0xFF1565C0),
                iconBg: const Color(0xFFE3F2FD),
                value: '₱${todayEarnings.toInt()}',
                label: 'Today\'s Earnings',
              ),
              const SizedBox(width: 10),
              _buildStatTile(
                icon: Icons.inventory_2_rounded,
                iconColor: brandColor,
                iconBg: const Color(0xFFFFF3E0),
                value: '$completedTripsCount',
                label: 'Completed Trips',
              ),
              const SizedBox(width: 10),
              _buildStatTile(
                icon: Icons.account_balance_wallet_outlined,
                iconColor: const Color(0xFF2E7D32),
                iconBg: const Color(0xFFE8F5E9),
                value: '₱620',
                label: 'Wallet Balance',
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FC),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: Colors.grey[500],
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
