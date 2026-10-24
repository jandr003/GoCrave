import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';
import 'admin_help_about_screen.dart';
import 'admin_general_preferences_screen.dart';
import 'admin_staff_permissions_screen.dart';
import 'admin_notification_settings_screen.dart';
import 'admin_order_policies_screen.dart';

class AdminSettingsScreen extends StatefulWidget {
  final String adminEmail;
  const AdminSettingsScreen({
    super.key,
    this.adminEmail = 'Admin01',
  });

  @override
  State<AdminSettingsScreen> createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends State<AdminSettingsScreen> {
  final Color brandColor = const Color(0xFFFF5622);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0F172A), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Admin Settings',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F172A),
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.admin_panel_settings_rounded, color: brandColor, size: 28),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'System Administrator',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          'Super Admin Account • ${widget.adminEmail}',
                          style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.verified_rounded, size: 18, color: Color(0xFF10B981)),
                ],
              ),
            ),

            const SizedBox(height: 16),
            const Divider(height: 1, color: Color(0xFFE2E8F0)),
            const SizedBox(height: 18),

            Text(
              'System Configuration',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 12),

            Column(
              children: [
                _buildSettingTile(
                  icon: Icons.shield_outlined,
                  title: 'Account & Security',
                  subtitle: 'Password reset, 2FA & email credentials',
                  onTap: () => _showSettingDetailModal(context, 'Account & Security', 'Manage system authentication credentials, reset admin master passwords, and configure two-factor security alerts.'),
                ),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                _buildSettingTile(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Payment & Fees',
                  subtitle: 'GCash, Maya, commission rate & base delivery fee',
                  onTap: () => _showSettingDetailModal(context, 'Payment & Fees', 'Configure payment gateway settlements, merchant commission percentages, base delivery charges, and cash-on-delivery limits.'),
                ),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                _buildSettingTile(
                  icon: Icons.two_wheeler_outlined,
                  title: 'Delivery Settings',
                  subtitle: 'Max delivery radius limit & auto-dispatch rules',
                  onTap: () => _showSettingDetailModal(context, 'Delivery Settings', 'Adjust maximum delivery distance radius (15 km), driver base fare rates, and automated rider dispatch algorithms.'),
                ),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                _buildSettingTile(
                  icon: Icons.assignment_turned_in_outlined,
                  title: 'Order Policies',
                  subtitle: 'Cancellation windows, refund & auto-accept rules',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminOrderPoliciesScreen(),
                      ),
                    );
                  },
                ),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                _buildSettingTile(
                  icon: Icons.notifications_active_outlined,
                  title: 'Notification Settings',
                  subtitle: 'Push alerts, email digests & SMS dispatch notices',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminNotificationSettingsScreen(),
                      ),
                    );
                  },
                ),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                _buildSettingTile(
                  icon: Icons.badge_outlined,
                  title: 'Staff & Permissions',
                  subtitle: 'Admin role access levels & rider approval rights',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminStaffPermissionsScreen(),
                      ),
                    );
                  },
                ),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                _buildSettingTile(
                  icon: Icons.tune_outlined,
                  title: 'General Preferences',
                  subtitle: 'Platform currency, language & theme preferences',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminGeneralPreferencesScreen(),
                      ),
                    );
                  },
                ),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                _buildSettingTile(
                  icon: Icons.help_outline_rounded,
                  title: 'Help & About',
                  subtitle: '24/7 Admin support desk & app version v1.0.4',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminHelpAboutScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout_rounded, size: 18, color: Color(0xFFEF4444)),
                label: Text(
                  'Log Out of Admin Control Panel',
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFFEF4444)),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFEF4444), width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 22, color: brandColor),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Color(0xFF94A3B8)),
          ],
        ),
      ),
    );
  }

  void _showSettingDetailModal(BuildContext context, String title, String description) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(24, 20, 24, MediaQuery.of(context).viewInsets.bottom + 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 16),
              Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
              const SizedBox(height: 10),
              Text(
                description,
                style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF475569), height: 1.5),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brandColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: Text('Close Configuration', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
