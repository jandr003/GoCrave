import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderProfileTab extends StatelessWidget {
  final String riderName;
  final String riderPhone;
  final String vehiclePlate;
  final String avatarUrl;
  final int completedTripsCount;
  final Color brandColor;
  final VoidCallback onTapEditProfile;
  final VoidCallback? onTapGovernmentId;
  final VoidCallback onLogOut;

  const RiderProfileTab({
    super.key,
    required this.riderName,
    required this.riderPhone,
    required this.vehiclePlate,
    required this.avatarUrl,
    required this.completedTripsCount,
    required this.brandColor,
    required this.onTapEditProfile,
    this.onTapGovernmentId,
    required this.onLogOut,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: const Color(0xFFEEEEEE)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 38,
                        backgroundColor: brandColor,
                        backgroundImage: NetworkImage(avatarUrl),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.verified_rounded, color: Colors.white, size: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              riderName,
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.amber[50],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '4.9 ⭐',
                                style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.amber[900]),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          riderPhone,
                          style: GoogleFonts.poppins(fontSize: 13, color: brandColor, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          vehiclePlate,
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FC),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFEEEEEE)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildMiniMetric('Rating', '4.9 ⭐', Colors.amber[900]!),
                    Container(height: 24, width: 1, color: Colors.grey[300]),
                    _buildMiniMetric('On-Time', '99.2%', const Color(0xFF2E7D32)),
                    Container(height: 24, width: 1, color: Colors.grey[300]),
                    _buildMiniMetric('Total Trips', '210 Orders', Colors.blueAccent),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: onTapEditProfile,
                  icon: const Icon(Icons.edit_rounded, size: 18, color: Colors.white),
                  label: Text(
                    'Edit Profile & Vehicle Details',
                    style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
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
        ),

        const SizedBox(height: 20),

        // Section Title
        Text(
          'Courier Settings & Verifications',
          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
        ),
        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
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
              _buildProfileSettingRow(
                icon: Icons.badge_rounded,
                title: 'Government ID Status (Tap to Upload)',
                value: 'PhilSys National ID #PH-NID-88123-90 (Verified)',
                onTap: onTapGovernmentId,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(height: 1, color: Color(0xFFEEEEEE)),
              ),
              _buildProfileSettingRow(
                icon: Icons.two_wheeler_rounded,
                title: 'Registered Vehicle Details',
                value: vehiclePlate,
                onTap: onTapEditProfile,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(height: 1, color: Color(0xFFEEEEEE)),
              ),
              _buildProfileSettingRow(
                icon: Icons.military_tech_rounded,
                title: 'Service Record & Tenure',
                value: '2 Years & 4 Months delivering with GoCrave',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(height: 1, color: Color(0xFFEEEEEE)),
              ),
              _buildProfileSettingRow(
                icon: Icons.task_alt_rounded,
                title: 'Total Completed Orders Today',
                value: '$completedTripsCount Orders Completed Today',
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton.icon(
            onPressed: onLogOut,
            icon: const Icon(Icons.logout_rounded, size: 20, color: Colors.redAccent),
            label: Text(
              'Log Out of Rider Portal',
              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.redAccent),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.redAccent, width: 1.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMiniMetric(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: color),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildProfileSettingRow({
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: brandColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 20, color: brandColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[500])),
                  Text(value, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                ],
              ),
            ),
            if (onTap != null)
              const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
