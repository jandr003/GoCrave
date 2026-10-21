import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPrivacyPolicyScreen extends StatelessWidget {
  const AdminPrivacyPolicyScreen({super.key});

  final Color brandColor = const Color(0xFFFF5622);

  final List<Map<String, String>> _privacySections = const [
    {
      'number': '1',
      'title': 'Information We Collect',
      'body': 'Depending on the features used, this may include admin account details, contact information, login and activity records, and customer, restaurant, rider, order, and transaction information processed through the platform.'
    },
    {
      'number': '2',
      'title': 'How We Use Information',
      'body': 'Information may be used to manage accounts, process orders, coordinate deliveries, verify transactions, maintain records, provide support, and protect platform security.'
    },
    {
      'number': '3',
      'title': 'Information Sharing',
      'body': 'Information may be accessed by authorized personnel and disclosed to relevant service providers or other parties only where appropriate and permitted under applicable policies and law.'
    },
    {
      'number': '4',
      'title': 'Data Storage and Security',
      'body': 'GoCrave uses administrative, technical, and physical safeguards to protect information against unauthorized access, disclosure, alteration, or loss.'
    },
    {
      'number': '5',
      'title': 'Data Retention',
      'body': 'Information is retained for the period necessary for its stated purposes, applicable business requirements, and legal obligations.'
    },
    {
      'number': '6',
      'title': 'Your Privacy Rights',
      'body': 'Depending on the circumstances and applicable law, individuals may have rights to be informed, access or correct personal information, and exercise other applicable data privacy rights.'
    },
    {
      'number': '7',
      'title': 'Third-Party Services',
      'body': 'Explains relevant providers that process information for GoCrave, such as payment gateways, cloud hosting, map tile rendering, or notification dispatch services.'
    },
    {
      'number': '8',
      'title': 'Policy Updates',
      'body': 'Changes to this policy should be reflected in the displayed version and effective date.'
    },
    {
      'number': '9',
      'title': 'Contact & Privacy Concerns',
      'body': 'For privacy inquiries or requests, contact the designated GoCrave privacy contact at privacy@gocrave.app.'
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
          'Privacy Policy',
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
                              'Your Privacy Matters',
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              'GoCrave Admin · Privacy Policy',
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
                      'Last Updated: October 2026 · Version 1.0',
                      style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: brandColor),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'This Privacy Policy explains how GoCrave handles personal information when authorized administrators and staff use the admin application and manage platform operations.',
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
                children: List.generate(_privacySections.length, (idx) {
                  final section = _privacySections[idx];
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
                      if (idx < _privacySections.length - 1)
                        const Divider(height: 1, color: Color(0xFFF1F5F9)),
                    ],
                  );
                }),
              ),
            ),

            const SizedBox(height: 20),

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
                      Icon(Icons.privacy_tip_rounded, color: brandColor, size: 22),
                      const SizedBox(width: 10),
                      Text(
                        'Privacy Contact',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'For privacy inquiries, data subject requests, or security concerns, contact our designated privacy team at:',
                    style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 10),
                  SelectableText(
                    'privacy@gocrave.app',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: brandColor,
                    ),
                  ),
                ],
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
                  'End of Privacy Policy',
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
