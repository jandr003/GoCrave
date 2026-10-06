import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';
import '../widgets/rider/rider_edit_profile_modal.dart';
import '../widgets/rider/rider_government_id_modal.dart';

class RiderSettingsScreen extends StatefulWidget {
  final String riderName;
  final String riderPhone;
  final String vehiclePlate;
  final String avatarUrl;
  final Function(String name, String phone, String vehicle, String avatar)? onUpdateProfile;

  const RiderSettingsScreen({
    super.key,
    required this.riderName,
    required this.riderPhone,
    required this.vehiclePlate,
    required this.avatarUrl,
    this.onUpdateProfile,
  });

  @override
  State<RiderSettingsScreen> createState() => _RiderSettingsScreenState();
}

class _RiderSettingsScreenState extends State<RiderSettingsScreen> {
  final Color brandColor = const Color(0xFFFF5622);

  bool _autoAcceptOrders = false;
  double _deliveryRadiusKm = 5.0;
  double _maxCodLimit = 2000.0;
  String _preferredNavApp = 'Google Maps';
  bool _loudChimeAlerts = true;
  bool _voiceGuidance = true;
  bool _vibrationAlerts = true;
  String _appLanguage = 'English (Philippines)';

  late String _currentName;
  late String _currentPhone;
  late String _currentVehicle;
  late String _currentAvatar;

  final List<String> _riderAvatars = [
    'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=200&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?q=80&w=200&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop',
  ];

  @override
  void initState() {
    super.initState();
    _currentName = widget.riderName;
    _currentPhone = widget.riderPhone;
    _currentVehicle = widget.vehiclePlate;
    _currentAvatar = widget.avatarUrl;
  }

  void _showEditProfileModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return RiderEditProfileModal(
          currentName: _currentName,
          currentPhone: _currentPhone,
          currentVehicle: _currentVehicle,
          currentAvatar: _currentAvatar,
          avatars: _riderAvatars,
          brandColor: brandColor,
          onSave: (name, phone, vehicle, avatar) {
            setState(() {
              _currentName = name;
              _currentPhone = phone;
              _currentVehicle = vehicle;
              _currentAvatar = avatar;
            });
            if (widget.onUpdateProfile != null) {
              widget.onUpdateProfile!(name, phone, vehicle, avatar);
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Rider profile updated!', style: GoogleFonts.poppins()),
                backgroundColor: brandColor,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        );
      },
    );
  }

  void _showGovernmentIdModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return RiderGovernmentIdModal(
          brandColor: brandColor,
          onSave: (idType, idNumber, frontPhoto, backPhoto) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Government ID ($idType) updated for verification!', style: GoogleFonts.poppins()),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
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
          'Rider Settings',
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
                    radius: 30,
                    backgroundImage: NetworkImage(_currentAvatar),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _currentName,
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          _currentPhone,
                          style: GoogleFonts.poppins(fontSize: 12, color: brandColor, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _currentVehicle,
                          style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit_outlined, color: brandColor),
                    onPressed: _showEditProfileModal,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            _buildSectionHeader('Delivery & Duty Preferences'),
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
                    title: 'Auto-Accept Nearby Orders',
                    subtitle: 'Automatically accept delivery requests within 2 km',
                    icon: Icons.flash_on_rounded,
                    value: _autoAcceptOrders,
                    onChanged: (val) => setState(() => _autoAcceptOrders = val),
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
                                  child: Icon(Icons.radar_rounded, size: 18, color: brandColor),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Delivery Radius Limit',
                                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                              ],
                            ),
                            Text(
                              '${_deliveryRadiusKm.toStringAsFixed(1)} km',
                              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: brandColor),
                            ),
                          ],
                        ),
                        Slider(
                          value: _deliveryRadiusKm,
                          min: 1.0,
                          max: 15.0,
                          divisions: 14,
                          activeColor: brandColor,
                          inactiveColor: Colors.grey[200],
                          onChanged: (val) => setState(() => _deliveryRadiusKm = val),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  _buildOptionTile(
                    title: 'Max COD Cash Limit',
                    subtitle: '₱${_maxCodLimit.toInt()} maximum per cash order',
                    icon: Icons.payments_outlined,
                    onTap: () {
                      _showCodLimitDialog();
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            _buildSectionHeader('Navigation & Audio Alerts'),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: Column(
                children: [
                  _buildOptionTile(
                    title: 'Preferred Navigation App',
                    subtitle: _preferredNavApp,
                    icon: Icons.navigation_rounded,
                    onTap: _showNavAppPicker,
                  ),
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  _buildSwitchTile(
                    title: 'High-Volume Ringtone Alerts',
                    subtitle: 'Play loud chime on incoming order requests',
                    icon: Icons.notifications_active_rounded,
                    value: _loudChimeAlerts,
                    onChanged: (val) => setState(() => _loudChimeAlerts = val),
                  ),
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  _buildSwitchTile(
                    title: 'Voice Navigation Guidance',
                    subtitle: 'Turn-by-turn voice directions while driving',
                    icon: Icons.record_voice_over_rounded,
                    value: _voiceGuidance,
                    onChanged: (val) => setState(() => _voiceGuidance = val),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            _buildSectionHeader('Security & Verified Documents'),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: Column(
                children: [
                  _buildOptionTile(
                    title: 'Government ID & Driver License',
                    subtitle: 'PhilSys National ID #PH-NID-88123-90 (Verified)',
                    icon: Icons.badge_rounded,
                    onTap: _showGovernmentIdModal,
                  ),
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  _buildOptionTile(
                    title: 'App Language',
                    subtitle: _appLanguage,
                    icon: Icons.language_rounded,
                    onTap: _showLanguagePicker,
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
                      content: Text('Rider preferences saved successfully!', style: GoogleFonts.poppins()),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check_circle_rounded, size: 20, color: Colors.white),
                label: Text(
                  'Save Settings Preferences',
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
                  'Log Out of Rider Portal',
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

  Widget _buildOptionTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _showNavAppPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select Navigation App', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.map_rounded, color: Colors.blue),
                title: Text('Google Maps', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                trailing: _preferredNavApp == 'Google Maps' ? Icon(Icons.check, color: brandColor) : null,
                onTap: () {
                  setState(() => _preferredNavApp = 'Google Maps');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.navigation_rounded, color: Colors.cyan),
                title: Text('Waze Navigation', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                trailing: _preferredNavApp == 'Waze Navigation' ? Icon(Icons.check, color: brandColor) : null,
                onTap: () {
                  setState(() => _preferredNavApp = 'Waze Navigation');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select Language', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              ListTile(
                title: Text('English (Philippines)', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                trailing: _appLanguage == 'English (Philippines)' ? Icon(Icons.check, color: brandColor) : null,
                onTap: () {
                  setState(() => _appLanguage = 'English (Philippines)');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Filipino / Tagalog', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                trailing: _appLanguage == 'Filipino / Tagalog' ? Icon(Icons.check, color: brandColor) : null,
                onTap: () {
                  setState(() => _appLanguage = 'Filipino / Tagalog');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCodLimitDialog() {
    final ctrl = TextEditingController(text: _maxCodLimit.toInt().toString());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Set Maximum COD Limit', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: TextField(
            controller: ctrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter amount e.g. 2000',
              prefixText: '₱ ',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: GoogleFonts.poppins(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                final double? val = double.tryParse(ctrl.text);
                if (val != null) {
                  setState(() => _maxCodLimit = val);
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: brandColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('Save Limit', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}
