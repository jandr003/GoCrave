import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminActiveSessionsScreen extends StatefulWidget {
  final List<Map<String, String>>? initialSessions;
  final Function(List<Map<String, String>> updatedSessions)? onSessionsUpdated;

  const AdminActiveSessionsScreen({
    super.key,
    this.initialSessions,
    this.onSessionsUpdated,
  });

  @override
  State<AdminActiveSessionsScreen> createState() => _AdminActiveSessionsScreenState();
}

class _AdminActiveSessionsScreenState extends State<AdminActiveSessionsScreen> {
  final Color brandColor = const Color(0xFFFF5622);

  late List<Map<String, String>> _sessions;

  @override
  void initState() {
    super.initState();
    _sessions = widget.initialSessions ?? [
      {'device': 'Android Emulator / Studio', 'location': 'Manila, PH', 'time': 'Current Session', 'isCurrent': 'true'},
      {'device': 'Chrome Browser (Mac OS)', 'location': 'Quezon City, PH', 'time': '2 hours ago', 'isCurrent': 'false'},
      {'device': 'GoCrave Admin iOS App', 'location': 'Makati City, PH', 'time': 'Yesterday at 4:15 PM', 'isCurrent': 'false'},
    ];
  }

  void _signOutSession(int index) {
    final removed = _sessions.removeAt(index);
    widget.onSessionsUpdated?.call(_sessions);
    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Signed out session from ${removed['device']}.', style: GoogleFonts.poppins()),
        backgroundColor: brandColor,
        behavior: SnackBarBehavior.floating,
      ),
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
          'Active Sessions',
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
              'Review signed-in devices and manage session access.',
              style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF64748B)),
            ),
            const SizedBox(height: 20),

            Text(
              'Signed-In Devices (${_sessions.length})',
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                children: List.generate(_sessions.length, (idx) {
                  final session = _sessions[idx];
                  final isCurrent = session['isCurrent'] == 'true';
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: brandColor.withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isCurrent ? Icons.phone_android_rounded : Icons.laptop_mac_rounded,
                                color: brandColor,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(session['device']!, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                                  const SizedBox(height: 2),
                                  Text('${session['location']} • ${session['time']}', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                                ],
                              ),
                            ),
                            if (isCurrent)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(color: const Color(0xFFECFDF5), borderRadius: BorderRadius.circular(8)),
                                child: Text('Current', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF10B981))),
                              )
                            else
                              OutlinedButton(
                                onPressed: () => _signOutSession(idx),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Color(0xFFEF4444)),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                ),
                                child: Text('Sign Out', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFFEF4444))),
                              ),
                          ],
                        ),
                      ),
                      if (idx < _sessions.length - 1) const Divider(height: 1, color: Color(0xFFF1F5F9)),
                    ],
                  );
                }),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
