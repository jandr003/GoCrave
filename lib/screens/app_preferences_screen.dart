import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppPreferencesScreen extends StatefulWidget {
  const AppPreferencesScreen({super.key});

  @override
  State<AppPreferencesScreen> createState() => _AppPreferencesScreenState();
}

class _AppPreferencesScreenState extends State<AppPreferencesScreen> {
  final Color brandColor = const Color(0xFFFF5622);
  
  bool _pushNotifications = true;
  bool _orderUpdates = true;
  bool _promoEmails = false;
  bool _darkMode = false;
  bool _preciseLocation = true;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'App Preferences',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Notifications'),
            _buildPreferenceCard([
              _buildToggleItem(
                icon: Icons.notifications_active_outlined,
                title: 'Push Notifications',
                subtitle: 'Get alerts for all activity',
                value: _pushNotifications,
                onChanged: (v) => setState(() => _pushNotifications = v),
              ),
              _buildDivider(),
              _buildToggleItem(
                icon: Icons.shopping_bag_outlined,
                title: 'Order Updates',
                subtitle: 'Important alerts about your food',
                value: _orderUpdates,
                onChanged: (v) => setState(() => _orderUpdates = v),
              ),
              _buildDivider(),
              _buildToggleItem(
                icon: Icons.email_outlined,
                title: 'Promotional Emails',
                subtitle: 'Exclusive deals and newsletters',
                value: _promoEmails,
                onChanged: (v) => setState(() => _promoEmails = v),
              ),
            ]),

            _buildSectionHeader('Display & Appearance'),
            _buildPreferenceCard([
              _buildToggleItem(
                icon: Icons.dark_mode_outlined,
                title: 'Dark Mode',
                subtitle: 'Switch to a darker theme',
                value: _darkMode,
                onChanged: (v) => setState(() => _darkMode = v),
              ),
              _buildDivider(),
              _buildNavigationItem(
                icon: Icons.language_outlined,
                title: 'App Language',
                trailingText: _selectedLanguage,
                onTap: _showLanguagePicker,
              ),
            ]),

            _buildSectionHeader('Privacy & Security'),
            _buildPreferenceCard([
              _buildToggleItem(
                icon: Icons.location_on_outlined,
                title: 'Precise Location',
                subtitle: 'Better accuracy for delivery',
                value: _preciseLocation,
                onChanged: (v) => setState(() => _preciseLocation = v),
              ),
              _buildDivider(),
              _buildNavigationItem(
                icon: Icons.shield_outlined,
                title: 'Data Permissions',
                onTap: () {},
              ),
            ]),

            _buildSectionHeader('App Management'),
            _buildPreferenceCard([
              _buildNavigationItem(
                icon: Icons.delete_outline,
                title: 'Clear Cache',
                subtitle: 'Free up space on your device',
                onTap: () => _showConfirmationDialog('Clear Cache', 'Are you sure you want to clear the app cache?'),
              ),
            ]),
            
            const SizedBox(height: 40),
            Center(
              child: Text(
                'Version 1.0.42 (Beta)',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[400],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey[500],
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildPreferenceCard(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildToggleItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.black, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
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
          Switch.adaptive(
            value: value,
            activeColor: brandColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationItem({
    required IconData icon,
    required String title,
    String? subtitle,
    String? trailingText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.black, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  if (subtitle != null)
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
            if (trailingText != null)
              Text(
                trailingText,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: brandColor,
                ),
              ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey[50],
      indent: 60,
    );
  }

  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Language',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildLanguageOption('English'),
              _buildLanguageOption('Filipino'),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String lang) {
    bool isSelected = _selectedLanguage == lang;
    return ListTile(
      onTap: () {
        setState(() => _selectedLanguage = lang);
        Navigator.pop(context);
      },
      title: Text(
        lang,
        style: GoogleFonts.poppins(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          color: isSelected ? brandColor : Colors.black,
        ),
      ),
      trailing: isSelected ? Icon(Icons.check_circle, color: brandColor) : null,
    );
  }

  void _showConfirmationDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        content: Text(message, style: GoogleFonts.poppins()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: brandColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Confirm', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
