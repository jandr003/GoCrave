import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminAccountSettingsGuideScreen extends StatelessWidget {
  const AdminAccountSettingsGuideScreen({super.key});

  final Color brandColor = const Color(0xFFFF5622);

  final List<Map<String, String>> _steps = const [
    {
      'number': '1',
      'title': 'Managing Your Admin Profile',
      'body': 'Open the Settings screen and select Admin Profile to view or update your account information, such as your profile picture, full name, email address, and phone number, depending on the available fields.'
    },
    {
      'number': '2',
      'title': 'Managing Account Security',
      'body': 'Use the available security options to change your password and protect your account. Never share your login credentials or verification codes with other people.'
    },
    {
      'number': '3',
      'title': 'Configuring Payment & Fees',
      'body': 'Review supported payment methods and available fee configurations. Changes to platform commissions, service fees, or other financial settings should only be made by administrators with the appropriate permissions.'
    },
    {
      'number': '4',
      'title': 'Configuring Delivery Settings',
      'body': 'Review the available delivery configurations, such as delivery fees, service areas, minimum order requirements, and delivery rules, if these options are supported by the application.'
    },
    {
      'number': '5',
      'title': 'Managing Notifications',
      'body': 'Review your notification preferences and enable or disable available alerts for order updates, payment events, rider activity, and other important administrative notifications.'
    },
    {
      'number': '6',
      'title': 'Managing Staff & Permissions',
      'body': 'If staff management is available, review staff accounts, assigned roles, and access permissions. Ensure users can access only the features required for their responsibilities.'
    },
    {
      'number': '7',
      'title': 'Updating General Preferences',
      'body': 'Adjust available application preferences, such as theme, currency display, or date format. Save your changes when required and check that the updated preferences are reflected correctly.'
    },
    {
      'number': '8',
      'title': 'Accessing Help & About',
      'body': 'Open Help & About to access the Help Center, Contact Support, Terms & Conditions, Privacy Policy, and available application information.'
    },
    {
      'number': '9',
      'title': 'Logging Out Securely',
      'body': 'When you finish using the admin app, log out if you are using a shared or public device. Make sure sensitive account information is not left accessible to unauthorized users.'
    },
  ];

  final List<String> _reminders = const [
    'Keep your account information accurate and up to date.',
    'Use strong passwords and protect your login credentials.',
    'Review settings carefully before saving changes that affect payments, fees, or deliveries.',
    'Make administrative changes only within your assigned permissions.',
    'Protect customer, restaurant, rider, and business information at all times.',
  ];

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
          'Account & Settings Guide',
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
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/gocrave_app_logo.png',
                          width: 44,
                          height: 44,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Managing Your Account and Settings',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              'Help Center / Account & Settings',
                              style: GoogleFonts.poppins(fontSize: 11, color: brandColor, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'The GoCrave Admin Control Panel allows authorized administrators to manage their account information, review security options, configure available platform settings, and adjust preferences according to their assigned permissions.',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF475569),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            Text(
              'Account & Settings Steps',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: List.generate(_steps.length, (idx) {
                  final step = _steps[idx];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: brandColor.withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  step['number']!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: brandColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    step['title']!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF0F172A),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    step['body']!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: const Color(0xFF475569),
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (idx < _steps.length - 1)
                        const Divider(height: 1, color: Color(0xFFF1F5F9)),
                    ],
                  );
                }),
              ),
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFFFE0B2), width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.settings_suggest_rounded, color: brandColor, size: 22),
                      const SizedBox(width: 10),
                      Text(
                        'Important Reminders',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: _reminders.map((reminder) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• ',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: brandColor,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                reminder,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF334155),
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
