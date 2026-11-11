import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/audit_manager.dart';

class AdminAuditLogsScreen extends StatefulWidget {
  final Color brandColor;

  const AdminAuditLogsScreen({
    super.key,
    this.brandColor = const Color(0xFFFF5622),
  });

  @override
  State<AdminAuditLogsScreen> createState() {
    return _AdminAuditLogsScreenState();
  }
}

class _AdminAuditLogsScreenState extends State<AdminAuditLogsScreen> {
  final AuditManager _auditManager = AuditManager();

  @override
  void initState() {
    super.initState();
    _auditManager.addListener(_onAuditChanged);
  }

  @override
  void dispose() {
    _auditManager.removeListener(_onAuditChanged);
    super.dispose();
  }

  void _onAuditChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final logs = _auditManager.logs;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: widget.brandColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
          onPressed: () {
            return Navigator.pop(context);
          },
        ),
        title: Text(
          'Security Audit Logs & Activity Tracker',
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        itemCount: logs.length,
        separatorBuilder: (_, __) {
          return const SizedBox(height: 14);
        },
        itemBuilder: (context, index) {
          final log = logs[index];

          return Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
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
                    Text(
                      log['id'],
                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: widget.brandColor),
                    ),
                    Text(
                      'IP: ${log['ip']}',
                      style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  log['action'],
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                ),
                const SizedBox(height: 4),
                Text(
                  'Admin: ${log['admin']} • ${log['timestamp']}',
                  style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
