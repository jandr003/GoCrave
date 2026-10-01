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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF12141D), Color(0xFF1D202F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rider Wallet Balance', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[400])),
              const SizedBox(height: 4),
              Text('₱${todayEarnings.toStringAsFixed(2)}', style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.greenAccent)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Withdrawal request of ₱${todayEarnings.toStringAsFixed(2)} sent to GCash!'),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.account_balance_wallet, size: 16, color: Colors.black),
                      label: Text('Withdraw to GCash', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
