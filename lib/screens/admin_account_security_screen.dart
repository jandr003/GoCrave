import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'admin_change_password_screen.dart';
import 'admin_active_sessions_screen.dart';
import 'admin_recovery_info_screen.dart';

class AdminAccountSecurityScreen extends StatefulWidget {
  final Map<String, dynamic>? initialSecurityData;
  final Function(Map<String, dynamic> updatedData)? onSave;

  const AdminAccountSecurityScreen({
    super.key,
    this.initialSecurityData,
    this.onSave,
  });

  @override
  State<AdminAccountSecurityScreen> createState() => _AdminAccountSecurityScreenState();
}

class _AdminAccountSecurityScreenState extends State<AdminAccountSecurityScreen> {
  final Color brandColor = const Color(0xFFFF5622);

  late bool _twoFactorEnabled;
  late bool _securityAlertsEnabled;
  late String _recoveryEmail;
  late String _recoveryPhone;

  @override
  void initState() {
    super.initState();
    final data = widget.initialSecurityData ?? {};
    _twoFactorEnabled = data['twoFactorEnabled'] ?? true;
    _securityAlertsEnabled = data['securityAlertsEnabled'] ?? true;
    _recoveryEmail = data['recoveryEmail'] ?? 'admin@gocrave.app';
    _recoveryPhone = data['recoveryPhone'] ?? '+63 917 123 4567';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0F172A), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Account & Security',
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
            Text(
              'Manage your password, sign-in security, and account access.',
              style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF64748B)),
            ),
            const SizedBox(height: 20),

            Text(
              '1. Password & Authentication',
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                children: [
                  _buildOptionTile(
                    title: 'Change Password',
                    subtitle: 'Update your current account password.',
                    icon: Icons.lock_outline_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminChangePasswordScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  _buildSwitchTile(
                    title: 'Two-Factor Authentication',
                    subtitle: 'Require an additional verification step during sign-in.',
                    value: _twoFactorEnabled,
                    onChanged: (val) {
                      setState(() => _twoFactorEnabled = val);
                      widget.onSave?.call({'twoFactorEnabled': val});
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              '2. Login Activity',
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                children: [
                  _buildOptionTile(
                    title: 'Active Sessions',
                    subtitle: 'Review signed-in devices and sign out sessions you don\'t recognize.',
                    icon: Icons.devices_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminActiveSessionsScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  _buildSwitchTile(
                    title: 'Security Alerts',
                    subtitle: 'Receive alerts for suspicious logins and important security changes.',
                    value: _securityAlertsEnabled,
                    onChanged: (val) {
                      setState(() => _securityAlertsEnabled = val);
                      widget.onSave?.call({'securityAlertsEnabled': val});
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              '3. Account Recovery',
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: _buildOptionTile(
                title: 'Recovery Information',
                subtitle: 'Review your verified recovery email or phone number.',
                icon: Icons.mark_email_read_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminRecoveryInfoScreen(
                        initialEmail: _recoveryEmail,
                        initialPhone: _recoveryPhone,
                        onRecoveryUpdated: (email, phone) {
                          setState(() {
                            _recoveryEmail = email;
                            _recoveryPhone = phone;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 22, color: brandColor),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                  const SizedBox(height: 2),
                  Text(subtitle, style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Color(0xFF94A3B8)),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                const SizedBox(height: 2),
                Text(subtitle, style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
              ],
            ),
          ),
          Switch(
            value: value,
            activeColor: brandColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
