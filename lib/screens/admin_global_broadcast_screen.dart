import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/broadcast_manager.dart';

enum BroadcastAudience {
  allUsers,
  ridersOnly,
  merchantsOnly,
  allPlatformUsers,
}

class AdminGlobalBroadcastScreen extends StatefulWidget {
  final Color brandColor;

  const AdminGlobalBroadcastScreen({
    super.key,
    this.brandColor = const Color(0xFFFF5622),
  });

  @override
  State<AdminGlobalBroadcastScreen> createState() {
    return _AdminGlobalBroadcastScreenState();
  }
}

class _AdminGlobalBroadcastScreenState extends State<AdminGlobalBroadcastScreen> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _messageCtrl = TextEditingController();
  BroadcastAudience _selectedAudience = BroadcastAudience.allUsers;

  String _getAudienceLabel(BroadcastAudience audience) {
    switch (audience) {
      case BroadcastAudience.ridersOnly:
        return 'Active Delivery Riders Only';
      case BroadcastAudience.merchantsOnly:
        return 'Restaurant Merchants Only';
      case BroadcastAudience.allPlatformUsers:
        return 'All Platform Users';
      case BroadcastAudience.allUsers:
      default:
        return 'All Users (Customers & Riders)';
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<BroadcastAudience> audienceOptions = [
      BroadcastAudience.allUsers,
      BroadcastAudience.ridersOnly,
      BroadcastAudience.merchantsOnly,
      BroadcastAudience.allPlatformUsers,
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF0F172A),
            size: 18,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Global System Broadcast',
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: const Color(0xFFE2E8F0),
                ),
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
                  Text(
                    'Send App-Wide Push Announcement',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    'Broadcast high-priority alerts to targeted users instantly.',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    'Target Audience',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF334155),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...audienceOptions.map((audience) {
                    final isSel = _selectedAudience == audience;
                    final label = _getAudienceLabel(audience);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedAudience = audience;
                          });
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: isSel
                                ? widget.brandColor.withOpacity(0.1)
                                : const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSel
                                  ? widget.brandColor
                                  : const Color(0xFFE2E8F0),
                            ),
                          ),
                          child: Text(
                            label,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: isSel
                                  ? widget.brandColor
                                  : const Color(0xFF334155),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),

                  const SizedBox(height: 16),
                  Text(
                    'Announcement Title',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF334155),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: TextField(
                      controller: _titleCtrl,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: 'e.g. Weekend Free Delivery Promo!',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xFF94A3B8),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  Text(
                    'Message Body',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF334155),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: TextField(
                      controller: _messageCtrl,
                      maxLines: 4,
                      style: GoogleFonts.poppins(fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'Type your broadcast announcement message here...',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xFF94A3B8),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        final title = _titleCtrl.text.trim();
                        final msg = _messageCtrl.text.trim();
                        final targetLabel = _getAudienceLabel(_selectedAudience);

                        if (title.isEmpty || msg.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Please enter both a title and message.',
                                style: GoogleFonts.poppins(),
                              ),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          return;
                        }

                        BroadcastManager().sendBroadcast(targetLabel, title, msg);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Global broadcast sent successfully to $targetLabel!',
                              style: GoogleFonts.poppins(),
                            ),
                            backgroundColor: widget.brandColor,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.brandColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Send Global Broadcast',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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
