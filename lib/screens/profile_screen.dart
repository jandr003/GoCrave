import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/user_profile.dart';
import '../data/coin_manager.dart';
import '../widgets/agreement_modal.dart';
import 'login_screen.dart';
import 'wallet_screen.dart';
import 'rewards_screen.dart';
import 'app_preferences_screen.dart';
import 'support_screen.dart';
import 'feedback_screen.dart';
import 'profile_setup_screen.dart';
import 'admin_dashboard_screen.dart';
import 'rider_dashboard_screen.dart';
import 'restaurant_dashboard_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    UserProfile().addListener(_updateState);
    CoinManager().addListener(_updateState);
  }

  @override
  void dispose() {
    UserProfile().removeListener(_updateState);
    CoinManager().removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    if (mounted) setState(() {});
  }

  void _showAboutGoCraveModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.78,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/gocrave_app_logo.png',
                        height: 70,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF3E0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Version 1.0.4 (Build 2026.09)',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFF5622),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Order your favorite food anytime and enjoy fast, reliable delivery across the Philippines.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Divider(height: 1, color: Color(0xFFEEEEEE)),
                      const SizedBox(height: 12),
                      _buildAboutTile(
                        icon: Icons.article_outlined,
                        title: 'Terms of Service & Privacy Policy',
                        subtitle: 'Read our platform agreement and data policy',
                        onTap: () {
                          Navigator.pop(context);
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const AgreementModal(),
                          );
                        },
                      ),
                      _buildAboutTile(
                        icon: Icons.system_update_rounded,
                        title: 'Check for Updates',
                        subtitle: 'You are on the latest version',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'GoCrave is up to date! (v1.0.4)',
                                style: GoogleFonts.poppins(),
                              ),
                              backgroundColor: const Color(0xFFFF5622),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        },
                      ),
                      _buildAboutTile(
                        icon: Icons.star_outline_rounded,
                        title: 'Rate GoCrave',
                        subtitle: 'Leave us a rating on Google Play',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Thank you for rating GoCrave!',
                                style: GoogleFonts.poppins(),
                              ),
                              backgroundColor: const Color(0xFFFF5622),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        },
                      ),
                      _buildAboutTile(
                        icon: Icons.code_rounded,
                        title: 'Open Source Licenses',
                        subtitle: 'Third-party software libraries and licenses',
                        onTap: () {
                          showLicensePage(
                            context: context,
                            applicationName: 'GoCrave',
                            applicationVersion: 'v1.0.4',
                            applicationIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset('assets/images/gocrave_app_logo.png', height: 40),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      Text(
                        '© 2026 GoCrave Inc. All rights reserved.\nMade in the Philippines.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.grey[400],
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAboutTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 20, color: const Color(0xFFFF5622)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = UserProfile();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/gocrave_official_logo.png',
                      height: 140,
                      fit: BoxFit.contain,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileSetupScreen(isEditing: true),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.grey[100],
                        backgroundImage: user.profilePic.isNotEmpty
                            ? NetworkImage(user.profilePic)
                            : null,
                        child: user.profilePic.isEmpty
                            ? const Icon(Icons.person, color: Colors.grey)
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileSetupScreen(isEditing: true),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Text(
                          user.fullName.isNotEmpty ? user.fullName : 'Personal',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.person_outline, size: 20, color: Colors.black),
                        const Spacer(),
                        const Icon(Icons.edit_outlined, size: 18, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _buildActionCard(context, 'Favorite', Icons.book_outlined, Colors.blueAccent, () {}),
                    const SizedBox(width: 16),
                    _buildActionCard(context, 'Wallet', Icons.account_balance_wallet, Colors.orangeAccent, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const WalletScreen()),
                      );
                    }),
                    const SizedBox(width: 16),
                    _buildActionCard(context, 'Coins', Icons.monetization_on, Colors.amber, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RewardsScreen()),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 32),
                _buildMenuItem(
                  icon: Icons.card_giftcard,
                  title: 'Promotions',
                  subtitle: 'Exclusive deals on your favorite cravings',
                ),
                _buildMenuItem(
                  icon: Icons.workspace_premium_outlined,
                  title: 'View Rewards',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RewardsScreen()),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.chat_bubble_outline,
                  title: 'Send Feedback',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FeedbackScreen()),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.settings_outlined,
                  title: 'App Preferences',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AppPreferencesScreen()),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.phone_outlined,
                  title: 'Support',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SupportScreen()),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.admin_panel_settings_outlined,
                  title: 'Admin Control Panel',
                  subtitle: 'Logged in as Admin01 • Manage sales, orders & menu',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminDashboardScreen(adminEmail: 'Admin01'),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.two_wheeler_rounded,
                  title: 'Rider Delivery Portal',
                  subtitle: 'Active rider orders & delivery workflow',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RiderDashboardScreen(riderEmail: 'rider@gocrave.app'),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  icon: Icons.store_rounded,
                  title: 'Restaurant Merchant Portal',
                  subtitle: 'GoCrave Central Kitchen • Kitchen order pipeline',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RestaurantDashboardScreen(merchantEmail: 'resto@gocrave.app'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _buildMenuItem(
                  icon: Icons.info_outline,
                  title: 'About GoCrave',
                  subtitle: 'Order your favorites anytime and enjoy fast, easy delivery.',
                  onTap: () => _showAboutGoCraveModal(context),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isLoggedIn', false);
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                          (route) => false,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[50],
                      foregroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Sign Out',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, String label, IconData icon, Color iconColor, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(icon, size: 32, color: iconColor),
              const SizedBox(height: 12),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          crossAxisAlignment: subtitle != null ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: Colors.black),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
