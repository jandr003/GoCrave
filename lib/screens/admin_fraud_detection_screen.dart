import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/fraud_manager.dart';

class AdminFraudDetectionScreen extends StatefulWidget {
  final Color brandColor;

  const AdminFraudDetectionScreen({
    super.key,
    this.brandColor = const Color(0xFFFF5622),
  });

  @override
  State<AdminFraudDetectionScreen> createState() => _AdminFraudDetectionScreenState();
}

class _AdminFraudDetectionScreenState extends State<AdminFraudDetectionScreen> {
  final FraudManager _fraudManager = FraudManager();

  @override
  void initState() {
    super.initState();
    _fraudManager.addListener(_onFraudChanged);
  }

  @override
  void dispose() {
    _fraudManager.removeListener(_onFraudChanged);
    super.dispose();
  }

  void _onFraudChanged() {
    if (mounted) {
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final flags = _fraudManager.flags;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: widget.brandColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'AI Fraud Detection & Risk Dashboard',
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
        itemCount: flags.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 14);
        },
        itemBuilder: (context, index) {
          final flag = flags[index];
          final status = flag['status'];

          Color statusColor = const Color(0xFFEF4444);
          if (status == 'Cleared & Resolved') {
            statusColor = const Color(0xFF10B981);
          }
          if (status == 'Blocked & Banned') {
            statusColor = Colors.black87;
          }

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
                      flag['id'],
                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: widget.brandColor),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        status,
                        style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: statusColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  flag['user'],
                  style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                ),
                const SizedBox(height: 2),
                Text(
                  'Risk: ${flag['riskLevel']} • Reason: ${flag['reason']}',
                  style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Detected: ${flag['timestamp']}', style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF94A3B8))),
                    if (status != 'Cleared & Resolved' && status != 'Blocked & Banned')
                      Row(
                        children: [
                          SizedBox(
                            height: 36,
                            child: OutlinedButton(
                              onPressed: () {
                                _fraudManager.resolveFlag(flag['id']);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Flag ${flag['id']} cleared and resolved.', style: GoogleFonts.poppins()),
                                    backgroundColor: const Color(0xFF10B981),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFF10B981), width: 1.5),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              child: Text('Clear Risk', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF10B981))),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            height: 36,
                            child: ElevatedButton(
                              onPressed: () {
                                _fraudManager.blockAccount(flag['id']);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Account for ${flag['user']} blocked and banned.', style: GoogleFonts.poppins()),
                                    backgroundColor: const Color(0xFFEF4444),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFEF4444),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                elevation: 0,
                              ),
                              child: Text('Ban Account', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
