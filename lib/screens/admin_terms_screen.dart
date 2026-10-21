import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminTermsScreen extends StatelessWidget {
  const AdminTermsScreen({super.key});

  final Color brandColor = const Color(0xFFFF5622);

  final List<Map<String, String>> _termsSections = const [
    {
      'number': '1',
      'title': 'Acceptance of Terms',
      'body': 'By accessing or using GoCrave Admin, you agree to follow the applicable platform rules, policies, and responsibilities associated with your assigned role.'
    },
    {
      'number': '2',
      'title': 'Authorized Access',
      'body': 'Access is limited to approved administrators and staff. Users must not share their login credentials or access functions outside their assigned permissions.'
    },
    {
      'number': '3',
      'title': 'Account Security',
      'body': 'Users are responsible for protecting their accounts and promptly reporting suspected unauthorized access.'
    },
    {
      'number': '4',
      'title': 'Proper Use of the Platform',
      'body': 'The application must be used for legitimate GoCrave operations. Unauthorized changes, misuse of privileges, and intentional manipulation of records are prohibited.'
    },
    {
      'number': '5',
      'title': 'Orders and Deliveries',
      'body': 'Administrators must follow the platform\'s procedures when managing orders, assigning riders, handling delivery issues, and updating operational records.'
    },
    {
      'number': '6',
      'title': 'Payments and Financial Records',
      'body': 'Payment statuses, transaction details, commissions, and other financial records must be handled only within the user\'s authorized responsibilities. Records must not be altered improperly.'
    },
    {
      'number': '7',
      'title': 'Privacy and Confidentiality',
      'body': 'Customer, restaurant, and rider information must be accessed only for legitimate operational purposes and handled according to GoCrave\'s applicable privacy policies.'
    },
    {
      'number': '8',
      'title': 'Account Restrictions',
      'body': 'Access may be restricted or suspended in accordance with applicable company policies if an account is misused or security requirements are violated.'
    },
    {
      'number': '9',
      'title': 'Changes to These Terms',
      'body': 'GoCrave may update these terms as the application and its operating policies evolve. The latest version should display its applicable effective date.'
    },
    {
      'number': '10',
      'title': 'Contact Information',
      'body': 'For questions about these terms, contact the designated GoCrave administrator or official support channel.'
    },
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
          'Terms & Conditions',
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
                              'GoCrave Admin',
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              'Terms of Use for Authorized Administrators',
                              style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Version 1.0 • Effective Date: October 2026',
                      style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: brandColor),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Welcome to GoCrave Admin. These Terms & Conditions govern your access to and use of the GoCrave administrative application.',
                    style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF475569), height: 1.5),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

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
                children: List.generate(_termsSections.length, (idx) {
                  final section = _termsSections[idx];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: brandColor.withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                section['number']!,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: brandColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    section['title']!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF0F172A),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    section['body']!,
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
                      if (idx < _termsSections.length - 1)
                        const Divider(height: 1, color: Color(0xFFF1F5F9)),
                    ],
                  );
                }),
              ),
            ),

            const SizedBox(height: 24),

            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'End of Terms & Conditions',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
