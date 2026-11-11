import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/settlement_manager.dart';

class AdminSettlementLedgerScreen extends StatefulWidget {
  final Color brandColor;

  const AdminSettlementLedgerScreen({
    super.key,
    this.brandColor = const Color(0xFFFF5622),
  });

  @override
  State<AdminSettlementLedgerScreen> createState() => _AdminSettlementLedgerScreenState();
}

class _AdminSettlementLedgerScreenState extends State<AdminSettlementLedgerScreen> {
  final SettlementManager _settlementManager = SettlementManager();

  @override
  void initState() {
    super.initState();
    _settlementManager.addListener(_onSettlementChanged);
  }

  @override
  void dispose() {
    _settlementManager.removeListener(_onSettlementChanged);
    super.dispose();
  }

  void _onSettlementChanged() {
    if (mounted) {
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final settlements = _settlementManager.settlements;

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
          'Financial Payouts & Settlement Ledger',
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
        itemCount: settlements.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 14);
        },
        itemBuilder: (context, index) {
          final settlement = settlements[index];
          final status = settlement['status'];

          Color statusColor = const Color(0xFF10B981);
          if (status == 'Pending Payout') {
            statusColor = const Color(0xFFF59E0B);
          }
          if (status == 'Processing') {
            statusColor = const Color(0xFF2563EB);
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
                      settlement['id'],
                      style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: widget.brandColor),
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
                const SizedBox(height: 10),
                Text(
                  settlement['recipient'],
                  style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                ),
                const SizedBox(height: 4),
                Text(
                  'Amount Payout: ${settlement['amount']} • Platform Commission: ${settlement['commission']}',
                  style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date: ${settlement['date']}', style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF94A3B8))),
                    if (status != 'Settled')
                      SizedBox(
                        height: 36,
                        child: ElevatedButton(
                          onPressed: () {
                            _settlementManager.markAsSettled(settlement['id']);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Settlement ${settlement['id']} marked as settled.', style: GoogleFonts.poppins()),
                                backgroundColor: const Color(0xFF10B981),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF10B981),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 0,
                          ),
                          child: Text('Mark Settled', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
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
