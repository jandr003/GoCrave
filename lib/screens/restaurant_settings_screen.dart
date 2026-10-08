import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';

class RestaurantSettingsScreen extends StatefulWidget {
  final String merchantEmail;
  const RestaurantSettingsScreen({
    super.key,
    this.merchantEmail = 'resto@gocravestaff.ph',
  });

  @override
  State<RestaurantSettingsScreen> createState() => _RestaurantSettingsScreenState();
}

class _RestaurantSettingsScreenState extends State<RestaurantSettingsScreen> {
  final Color brandColor = const Color(0xFFFF5622);

  bool _isAcceptingOrders = true;
  bool _loudChimeAlerts = true;
  double _defaultPrepMins = 15.0;
  bool _autoDispatchRider = true;
  bool _printOrderTicket = false;
  String _kitchenLanguage = 'English (Philippines)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Merchant Kitchen Settings',
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F172A),
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF5F2),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFFFE0B2), width: 1.5),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: brandColor,
                    child: const Icon(Icons.restaurant_rounded, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GoCrave Central Kitchen',
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Malolos Branch • Merchant ID: #MERCHANT-501',
                          style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600]),
                        ),
                        Text(
                          widget.merchantEmail,
                          style: GoogleFonts.poppins(fontSize: 11, color: brandColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            _buildSectionHeader('Store Operating Status'),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: _buildSwitchTile(
                title: 'Accepting Customer Orders',
                subtitle: _isAcceptingOrders ? 'Store is OPEN and ringing new orders' : 'Store is PAUSED',
                icon: Icons.store_rounded,
                value: _isAcceptingOrders,
                onChanged: (val) {
                  setState(() => _isAcceptingOrders = val);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(_isAcceptingOrders ? 'Kitchen is now OPEN for orders!' : 'Kitchen is PAUSED.'),
                      backgroundColor: _isAcceptingOrders ? Colors.green : Colors.grey[700],
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            _buildSectionHeader('Kitchen & Order Preferences'),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: Column(
                children: [
                  _buildSwitchTile(
                    title: 'Loud Incoming Order Chime',
                    subtitle: 'Play high-volume ringtone on new customer orders',
                    icon: Icons.notifications_active_rounded,
                    value: _loudChimeAlerts,
                    onChanged: (val) => setState(() => _loudChimeAlerts = val),
                  ),
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: brandColor.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.timer_rounded, size: 18, color: brandColor),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Default Kitchen Prep Timer',
                                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                              ],
                            ),
                            Text(
                              '${_defaultPrepMins.toInt()} Mins',
                              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: brandColor),
                            ),
                          ],
                        ),
                        Slider(
                          value: _defaultPrepMins,
                          min: 5.0,
                          max: 45.0,
                          divisions: 8,
                          activeColor: brandColor,
                          inactiveColor: Colors.grey[200],
                          onChanged: (val) => setState(() => _defaultPrepMins = val),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  _buildSwitchTile(
                    title: 'Auto-Dispatch Rider on Food Ready',
                    subtitle: 'Automatically alert nearby riders when food is packed',
                    icon: Icons.two_wheeler_rounded,
                    value: _autoDispatchRider,
                    onChanged: (val) => setState(() => _autoDispatchRider = val),
                  ),
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  _buildSwitchTile(
                    title: 'Auto-Print Kitchen Order Ticket',
                    subtitle: 'Print physical kitchen ticket upon accepting order',
                    icon: Icons.print_rounded,
                    value: _printOrderTicket,
                    onChanged: (val) => setState(() => _printOrderTicket = val),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Merchant kitchen preferences saved!', style: GoogleFonts.poppins()),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check_circle_rounded, size: 20, color: Colors.white),
                label: Text(
                  'Save Kitchen Preferences',
                  style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout_rounded, size: 18, color: Colors.redAccent),
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

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF0F172A),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: brandColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: brandColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
                Text(subtitle, style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[500])),
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
