import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminRecoveryInfoScreen extends StatefulWidget {
  final String? initialEmail;
  final String? initialPhone;
  final Function(String email, String phone)? onRecoveryUpdated;

  const AdminRecoveryInfoScreen({
    super.key,
    this.initialEmail,
    this.initialPhone,
    this.onRecoveryUpdated,
  });

  @override
  State<AdminRecoveryInfoScreen> createState() => _AdminRecoveryInfoScreenState();
}

class _AdminRecoveryInfoScreenState extends State<AdminRecoveryInfoScreen> {
  final Color brandColor = const Color(0xFFFF5622);

  late String _email;
  late String _phone;

  @override
  void initState() {
    super.initState();
    _email = widget.initialEmail ?? 'admin@gocrave.app';
    _phone = widget.initialPhone ?? '+63 917 123 4567';
  }

  String get _maskedEmail {
    if (_email.isEmpty || !_email.contains('@')) return 'ad••••@gocrave.app';
    final parts = _email.split('@');
    final name = parts[0];
    final domain = parts[1];
    final prefix = name.length >= 2 ? name.substring(0, 2) : name;
    return '$prefix••••@$domain';
  }

  String get _maskedPhone {
    if (_phone.length < 10) return '+63 9•• ••• ••21';
    final clean = _phone.replaceAll(' ', '');
    final last2 = clean.substring(clean.length - 2);
    final first4 = clean.substring(0, clean.length >= 5 ? 5 : clean.length);
    return '$first4•• ••• ••$last2';
  }

  void _showUpdateEmailModal() {
    final emailCtrl = TextEditingController(text: _email);
    bool isSaving = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
                  Text('Update Recovery Email', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                  Text('Enter your new verified email address for account recovery.', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                  const SizedBox(height: 16),

                  Text('New Recovery Email', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: TextField(
                      controller: emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                      decoration: InputDecoration(
                        hintText: 'e.g. admin.recovery@gocrave.app',
                        hintStyle: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF94A3B8)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: isSaving
                          ? null
                          : () async {
                              if (emailCtrl.text.trim().isEmpty || !emailCtrl.text.contains('@')) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Please enter a valid email address.', style: GoogleFonts.poppins()), backgroundColor: Colors.redAccent),
                                );
                                return;
                              }

                              setModalState(() => isSaving = true);
                              await Future.delayed(const Duration(seconds: 1));
                              if (!mounted) return;

                              setState(() {
                                _email = emailCtrl.text.trim();
                              });

                              widget.onRecoveryUpdated?.call(_email, _phone);

                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Recovery email updated successfully!', style: GoogleFonts.poppins()),
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
                      child: isSaving
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                          : Text('Save Email', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
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

  void _showUpdatePhoneModal() {
    final phoneCtrl = TextEditingController(text: _phone);
    bool isSaving = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
                  Text('Update Recovery Phone', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                  Text('Enter your new mobile phone number for account recovery alerts.', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                  const SizedBox(height: 16),

                  Text('New Recovery Phone', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: TextField(
                      controller: phoneCtrl,
                      keyboardType: TextInputType.phone,
                      style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                      decoration: InputDecoration(
                        hintText: 'e.g. +63 917 888 4627',
                        hintStyle: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF94A3B8)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: isSaving
                          ? null
                          : () async {
                              if (phoneCtrl.text.trim().isEmpty || phoneCtrl.text.trim().length < 8) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Please enter a valid phone number.', style: GoogleFonts.poppins()), backgroundColor: Colors.redAccent),
                                );
                                return;
                              }

                              setModalState(() => isSaving = true);
                              await Future.delayed(const Duration(seconds: 1));
                              if (!mounted) return;

                              setState(() {
                                _phone = phoneCtrl.text.trim();
                              });

                              widget.onRecoveryUpdated?.call(_email, _phone);

                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Recovery phone number updated successfully!', style: GoogleFonts.poppins()),
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
                      child: isSaving
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                          : Text('Save Phone', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
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
          'Recovery Information',
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
              'Manage the contact details used to recover your admin account.',
              style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF64748B)),
            ),
            const SizedBox(height: 20),

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
                              'Account Recovery',
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              'GoCrave Master Credentials Protection',
                              style: GoogleFonts.poppins(fontSize: 11, color: brandColor, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Keep your recovery information up to date so you can regain access to your account when needed.',
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
              '1. Recovery Email',
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Registered Email', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                          const SizedBox(height: 2),
                          Text(_maskedEmail, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: const Color(0xFFECFDF5), borderRadius: BorderRadius.circular(8)),
                        child: Text('Verified', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF10B981))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: OutlinedButton(
                      onPressed: _showUpdateEmailModal,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: brandColor),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('Update Recovery Email', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: brandColor)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            Text(
              '2. Recovery Phone Number',
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Registered Phone', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                          const SizedBox(height: 2),
                          Text(_maskedPhone, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: const Color(0xFFECFDF5), borderRadius: BorderRadius.circular(8)),
                        child: Text('Verified', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF10B981))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: OutlinedButton(
                      onPressed: _showUpdatePhoneModal,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: brandColor),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('Update Recovery Phone', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: brandColor)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFFE0B2), width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.shield_outlined, color: brandColor, size: 20),
                      const SizedBox(width: 8),
                      Text('Security Reminder', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Never share your verification codes with anyone. Changes to recovery information must be verified before they take effect.',
                    style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF475569), height: 1.5),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
