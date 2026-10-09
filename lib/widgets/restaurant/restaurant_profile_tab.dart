import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantProfileTab extends StatelessWidget {
  final String storeName;
  final String storePhone;
  final String branchAddress;
  final String operatingHours;
  final String avatarUrl;
  final double todaySales;
  final int preparedOrdersCount;
  final Color brandColor;
  final VoidCallback onTapEditProfile;
  final VoidCallback onTapSettings;
  final VoidCallback onTapNotifications;
  final VoidCallback onLogOut;

  const RestaurantProfileTab({
    super.key,
    required this.storeName,
    required this.storePhone,
    required this.branchAddress,
    required this.operatingHours,
    required this.avatarUrl,
    required this.todaySales,
    required this.preparedOrdersCount,
    required this.brandColor,
    required this.onTapEditProfile,
    required this.onTapSettings,
    required this.onTapNotifications,
    required this.onLogOut,
  });

  @override
  Widget build(BuildContext context) {
    String formattedSales = todaySales.toInt().toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );

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
                          child: const Icon(Icons.store_rounded, color: Colors.white, size: 16),
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
                            Expanded(
                              child: Text(
                                storeName,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF0F172A),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.amber[50],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '4.8 ⭐',
                                style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.amber[900]),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          storePhone,
                          style: GoogleFonts.poppins(fontSize: 13, color: brandColor, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Merchant ID: #MERCHANT-501',
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
                    _buildMiniMetric('Today Sales', '₱$formattedSales', const Color(0xFF2E7D32)),
                    Container(height: 24, width: 1, color: Colors.grey[300]),
                    _buildMiniMetric('Prepared', '$preparedOrdersCount Orders', brandColor),
                    Container(height: 24, width: 1, color: Colors.grey[300]),
                    _buildMiniMetric('Store Rating', '4.8 ⭐', Colors.amber[900]!),
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
                    'Edit Store Profile & Operating Hours',
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

        Text(
          'Store Verifications & Settings',
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
              _buildSettingRow(
                icon: Icons.verified_rounded,
                title: 'DTI Business Permit Status',
                value: 'DTI Registered #BP-2026-99210 (Verified)',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(height: 1, color: Color(0xFFEEEEEE)),
              ),
              _buildSettingRow(
                icon: Icons.location_on_rounded,
                title: 'Branch Address',
                value: branchAddress,
                onTap: onTapEditProfile,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(height: 1, color: Color(0xFFEEEEEE)),
              ),
              _buildSettingRow(
                icon: Icons.access_time_rounded,
                title: 'Store Operating Hours',
                value: operatingHours,
                onTap: onTapEditProfile,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(height: 1, color: Color(0xFFEEEEEE)),
              ),
              _buildSettingRow(
                icon: Icons.settings_rounded,
                title: 'Merchant Kitchen Settings',
                value: 'Order ringtone, prep timers, auto-dispatch',
                onTap: onTapSettings,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(height: 1, color: Color(0xFFEEEEEE)),
              ),
              _buildSettingRow(
                icon: Icons.notifications_active_rounded,
                title: 'Merchant Notifications',
                value: 'View order alerts, rider arrivals & reviews',
                onTap: onTapNotifications,
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
              'Log Out of Merchant Portal',
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

  Widget _buildSettingRow({
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
