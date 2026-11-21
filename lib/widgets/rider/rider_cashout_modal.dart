import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/rider_wallet_manager.dart';

class CashoutRequestModal extends StatefulWidget {
  final Color brandColor;

  const CashoutRequestModal({
    super.key,
    required this.brandColor,
  });

  @override
  State<CashoutRequestModal> createState() {
    return _CashoutRequestModalState();
  }
}

class _CashoutRequestModalState extends State<CashoutRequestModal> {
  final TextEditingController _amountCtrl = TextEditingController();
  final TextEditingController _accountCtrl = TextEditingController();
  String _selectedMethod = 'GCash';

  final List<String> _methods = ['GCash', 'Maya', 'BPI Bank', 'UnionBank'];

  @override
  void dispose() {
    _amountCtrl.dispose();
    _accountCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wallet = RiderWalletManager();

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
          Text(
            'Request Rider Cashout',
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
          ),
          Text(
            'Available Balance: ₱${wallet.availableBalance.toStringAsFixed(2)}',
            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: widget.brandColor),
          ),
          const SizedBox(height: 20),

          Text(
            'Select Payout Method',
            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155)),
          ),
          const SizedBox(height: 8),
          Row(
            children: _methods.map((method) {
              final isSel = _selectedMethod == method;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedMethod = method;
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSel ? widget.brandColor : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isSel ? widget.brandColor : const Color(0xFFE2E8F0)),
                      ),
                      child: Center(
                        child: Text(
                          method,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isSel ? Colors.white : const Color(0xFF334155),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 16),
          Text(
            'Withdrawal Amount (₱)',
            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155)),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              controller: _amountCtrl,
              keyboardType: TextInputType.number,
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: 'Enter amount (e.g. 1000)',
                hintStyle: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF94A3B8)),
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(height: 16),
          Text(
            'Account Number / Mobile',
            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155)),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              controller: _accountCtrl,
              keyboardType: TextInputType.number,
              style: GoogleFonts.poppins(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'e.g. 09171234567',
                hintStyle: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF94A3B8)),
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                final double amount = double.tryParse(_amountCtrl.text.trim()) ?? 0.0;
                final String account = _accountCtrl.text.trim();

                if (amount <= 0 || account.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter a valid amount and account number.', style: GoogleFonts.poppins()),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  return;
                }

                final success = wallet.requestCashout(amount, _selectedMethod, account);
                if (success) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Cashout request of ₱${amount.toStringAsFixed(2)} via $_selectedMethod submitted successfully!', style: GoogleFonts.poppins()),
                      backgroundColor: widget.brandColor,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Insufficient balance for this cashout amount.', style: GoogleFonts.poppins()),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.brandColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              child: Text(
                'Confirm & Withdraw',
                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
