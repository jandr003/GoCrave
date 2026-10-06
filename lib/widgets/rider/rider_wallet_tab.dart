import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderWalletTab extends StatelessWidget {
  final double todayEarnings;

  const RiderWalletTab({
    super.key,
    required this.todayEarnings,
  });

  @override
  Widget build(BuildContext context) {
    const Color brandColor = Color(0xFFFF5622);
    const Color gcashBlue = Color(0xFF005CEE);

    final List<Map<String, String>> recentWithdrawals = [
      {
        'amount': '₱1,450.00',
        'account': 'GCash (0917 *** 9900)',
        'date': 'Today • 1:00 PM',
        'status': 'Completed',
      },
      {
        'amount': '₱1,200.00',
        'account': 'GCash (0917 *** 9900)',
        'date': 'Oct 1, 2026 • 5:30 PM',
        'status': 'Completed',
      },
      {
        'amount': '₱950.00',
        'account': 'GCash (0917 *** 9900)',
        'date': 'Sep 24, 2026 • 6:15 PM',
        'status': 'Completed',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF5F2),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: const Color(0xFFFFE0B2), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: brandColor.withOpacity(0.08),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rider Wallet Balance',
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey[600]),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: gcashBlue.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'GCash Linked',
                      style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: gcashBlue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                '₱${todayEarnings.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Withdrawal request of ₱${todayEarnings.toStringAsFixed(2)} sent to GCash!', style: GoogleFonts.poppins()),
                        backgroundColor: const Color(0xFF2E7D32),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  },
                  icon: const Icon(Icons.account_balance_wallet_rounded, size: 18, color: Colors.white),
                  label: Text(
                    'Withdraw Instantly to GCash',
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gcashBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        Text(
          'Recent Cash-Out Activity',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
        ),
        const SizedBox(height: 12),

        ...recentWithdrawals.map((w) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: gcashBlue.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.account_balance_wallet_rounded, color: gcashBlue, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        w['amount']!,
                        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Text(
                        '${w['account']} • ${w['date']}',
                        style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    w['status']!,
                    style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF2E7D32)),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
