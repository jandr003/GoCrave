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
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF12141D), Color(0xFF1D202F)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 26),
      child: Column(
        children: [
          InkWell(
            onTap: onTapEditProfile,
            borderRadius: BorderRadius.circular(16),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: brandColor,
                      backgroundImage: NetworkImage(avatarUrl),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: isOnline ? Colors.greenAccent : Colors.grey,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF12141D), width: 2.5),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            riderName,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.amber.withOpacity(0.4)),
                            ),
                            child: Text(
                              '4.9 ⭐',
                              style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.amber),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        vehiclePlate,
                        style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Switch(
                      value: isOnline,
                      activeColor: Colors.greenAccent,
                      onChanged: onOnlineChanged,
                    ),
                    Text(
                      isOnline ? 'ONLINE' : 'OFFLINE',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isOnline ? Colors.greenAccent : Colors.grey,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Glassmorphism KPI Metrics Row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildHeaderStat('Today Earnings', '₱${todayEarnings.toInt()}', Colors.greenAccent),
                Container(height: 28, width: 1, color: Colors.white12),
                _buildHeaderStat('Completed', '$completedTripsCount Trips', Colors.orangeAccent),
                Container(height: 28, width: 1, color: Colors.white12),
                _buildHeaderStat('Cash Wallet', '₱620', Colors.lightBlueAccent),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String label, String val, Color color) {
    return Column(
      children: [
        Text(
          val,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w900, color: color),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[400]),
        ),
      ],
    );
  }
}
