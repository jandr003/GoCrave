import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderWithdrawalDetailsScreen extends StatelessWidget {
  final Map<String, String> withdrawalItem;

  const RiderWithdrawalDetailsScreen({
    super.key,
    required this.withdrawalItem,
  });

  @override
  Widget build(BuildContext context) {
    const Color brandColor = Color(0xFFFF5622);

    final String amountStr = withdrawalItem['amount'] ?? '₱1,450.00';
    final String accountStr = withdrawalItem['account'] ?? 'GCash (0917 *** 9900)';
    final String dateStr = withdrawalItem['date'] ?? 'Today • 1:00 PM';
    final String statusStr = withdrawalItem['status'] ?? 'Completed';

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'GCash Cash-Out Receipt',
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F172A),
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFEEEEEE)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE8F5E9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.account_balance_wallet_rounded, color: Color(0xFF2E7D32), size: 48),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'GCASH WITHDRAWAL SUCCESSFUL',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E7D32),
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    amountStr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    dateStr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transaction Summary',
                    style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 14),
                  _buildDetailRow('Transfer Method', 'GCash E-Wallet Instant Payout'),
                  const Divider(height: 20, color: Color(0xFFEEEEEE)),
                  _buildDetailRow('Destination Account', accountStr),
                  const Divider(height: 20, color: Color(0xFFEEEEEE)),
                  _buildDetailRow('GCash Reference No.', '#GCASH-REF-99201-88A'),
                  const Divider(height: 20, color: Color(0xFFEEEEEE)),
                  _buildDetailRow('Transfer Status', statusStr, isStatus: true),
                ],
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('GCash cash-out receipt shared successfully!', style: GoogleFonts.poppins()),
                      backgroundColor: brandColor,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.share_rounded, size: 18, color: Colors.white),
                label: Text('Share Transaction Receipt', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, {bool isStatus = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isStatus ? const Color(0xFF2E7D32) : Colors.black87,
          ),
        ),
      ],
    );
  }
}
