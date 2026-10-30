import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'login_screen.dart';
import 'admin_help_about_screen.dart';
import 'admin_general_preferences_screen.dart';
import 'admin_staff_permissions_screen.dart';
import 'admin_notification_settings_screen.dart';
import 'admin_order_policies_screen.dart';
import 'admin_delivery_settings_screen.dart';
import 'admin_payment_fees_screen.dart';
import 'admin_account_security_screen.dart';

class AdminSettingsScreen extends StatefulWidget {
  final String adminEmail;
  final String? currentAvatarUrl;
  final Function(String newAvatarUrl)? onAvatarUpdated;

  const AdminSettingsScreen({
    super.key,
    this.adminEmail = 'Admin01',
    this.currentAvatarUrl,
    this.onAvatarUpdated,
  });

  @override
  State<AdminSettingsScreen> createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends State<AdminSettingsScreen> {
  final Color brandColor = const Color(0xFFFF5622);
  final ImagePicker _picker = ImagePicker();

  late String _currentAvatarUrl;
  File? _customAvatarFile;

  final List<String> _cartoonAvatarPresets = [
    'https://api.dicebear.com/7.x/avataaars/png?seed=AdminGoCrave&backgroundColor=ff5622',
    'https://api.dicebear.com/7.x/avataaars/png?seed=SuperAdmin01&backgroundColor=2563eb',
    'https://api.dicebear.com/7.x/avataaars/png?seed=TechAdmin02&backgroundColor=10b981',
    'https://api.dicebear.com/7.x/avataaars/png?seed=MasterAdmin03&backgroundColor=d97706',
    'https://api.dicebear.com/7.x/avataaars/png?seed=ExecutiveAdmin04&backgroundColor=a855f7',
    'https://api.dicebear.com/7.x/avataaars/png?seed=LeaderAdmin05&backgroundColor=0284c7',
  ];

  @override
  void initState() {
    super.initState();
    _currentAvatarUrl = widget.currentAvatarUrl ?? 'https://api.dicebear.com/7.x/avataaars/png?seed=AdminGoCrave&backgroundColor=ff5622';
  }

  Future<void> _pickImageFromGallery(StateSetter setModalState) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setModalState(() {
        _customAvatarFile = File(image.path);
      });
      setState(() {
        _customAvatarFile = File(image.path);
      });
    }
  }

  void _showChangeAvatarModal() {
    String selectedUrl = _currentAvatarUrl;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
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
                  Text('Change Admin Avatar', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                  Text('Select a 3D cartoon avatar preset or upload a custom profile image.', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                  const SizedBox(height: 20),

                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: brandColor.withOpacity(0.12),
                          backgroundImage: _customAvatarFile != null
                              ? FileImage(_customAvatarFile!) as ImageProvider
                              : NetworkImage(selectedUrl),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(color: brandColor, shape: BoxShape.circle),
                            child: const Icon(Icons.edit_rounded, color: Colors.white, size: 14),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  Text('3D Cartoon Presets', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 10),

                  SizedBox(
                    height: 64,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _cartoonAvatarPresets.length,
                      itemBuilder: (context, idx) {
                        final preset = _cartoonAvatarPresets[idx];
                        final isSelected = _customAvatarFile == null && selectedUrl == preset;

                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: InkWell(
                            onTap: () {
                              setModalState(() {
                                _customAvatarFile = null;
                                selectedUrl = preset;
                              });
                            },
                            borderRadius: BorderRadius.circular(32),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? brandColor : Colors.transparent,
                                  width: 2.5,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 26,
                                backgroundColor: const Color(0xFFF1F5F9),
                                backgroundImage: NetworkImage(preset),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton.icon(
                      onPressed: () => _pickImageFromGallery(setModalState),
                      icon: Icon(Icons.photo_library_rounded, size: 18, color: brandColor),
                      label: Text('Pick Image from Gallery', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: brandColor)),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: brandColor, width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onAvatarUpdated?.call(selectedUrl);
                        setState(() {
                          _currentAvatarUrl = selectedUrl;
                        });
                        Navigator.pop(context, selectedUrl);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Admin profile avatar updated successfully!', style: GoogleFonts.poppins()),
                            backgroundColor: brandColor,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: brandColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                      child: Text('Update Profile Avatar', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: brandColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Admin Settings',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
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
            InkWell(
              onTap: _showChangeAvatarModal,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: brandColor.withOpacity(0.12),
                          backgroundImage: _customAvatarFile != null
                              ? FileImage(_customAvatarFile!) as ImageProvider
                              : NetworkImage(_currentAvatarUrl),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(color: brandColor, shape: BoxShape.circle),
                            child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 11),
                          ),
                        ),
                      ],
                    ),
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminAccountSecurityScreen(),
                      ),
                    );
                  },
                ),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                _buildSettingTile(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Payment & Fees',
                  subtitle: 'GCash, Maya, commission rate & base delivery fee',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminPaymentFeesScreen(),
                      ),
                    );
                  },
                ),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                _buildSettingTile(
                  icon: Icons.two_wheeler_outlined,
                  title: 'Delivery Settings',
                  subtitle: 'Max delivery radius limit & auto-dispatch rules',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminDeliverySettingsScreen(),
                      ),
                    );
                  },
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
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout_rounded, size: 18, color: Colors.white),
                label: Text(
                  'Log Out of Admin Control Panel',
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEF4444),
                  elevation: 0,
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
}
