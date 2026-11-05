import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPromoManagerScreen extends StatefulWidget {
  final Color brandColor;

  const AdminPromoManagerScreen({
    super.key,
    this.brandColor = const Color(0xFFFF5622),
  });

  @override
  State<AdminPromoManagerScreen> createState() => _AdminPromoManagerScreenState();
}

class _AdminPromoManagerScreenState extends State<AdminPromoManagerScreen> {
  final List<Map<String, dynamic>> _vouchers = [
    {
      'code': 'GOCRAVE50',
      'discount': '₱50 OFF',
      'minSpend': '₱300 min. spend',
      'expiry': 'Dec 31, 2026',
      'usage': '342 redemptions',
      'isActive': true,
    },
    {
      'code': 'FREEDELIVERY',
      'discount': 'Free Delivery',
      'minSpend': '₱250 min. spend',
      'expiry': 'Nov 30, 2026',
      'usage': '1,280 redemptions',
      'isActive': true,
    },
    {
      'code': 'BULACANPROMO',
      'discount': '20% OFF',
      'minSpend': '₱500 min. spend',
      'expiry': 'Nov 15, 2026',
      'usage': '89 redemptions',
      'isActive': false,
    },
  ];

  void _showCreatePromoModal() {
    final codeCtrl = TextEditingController();
    final discountCtrl = TextEditingController();
    final minSpendCtrl = TextEditingController();
    final expiryCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Create New Promo Voucher', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
              const SizedBox(height: 16),
              TextField(
                controller: codeCtrl,
                decoration: const InputDecoration(labelText: 'Voucher Code (e.g. SAVE100)'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: discountCtrl,
                decoration: const InputDecoration(labelText: 'Discount Value (e.g. ₱100 OFF or 15% OFF)'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: minSpendCtrl,
                decoration: const InputDecoration(labelText: 'Minimum Spend (e.g. ₱400 min. spend)'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: expiryCtrl,
                decoration: const InputDecoration(labelText: 'Expiry Date (e.g. Dec 31, 2026)'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (codeCtrl.text.isNotEmpty && discountCtrl.text.isNotEmpty) {
                      setState(() {
                        _vouchers.insert(0, {
                          'code': codeCtrl.text.toUpperCase(),
                          'discount': discountCtrl.text,
                          'minSpend': minSpendCtrl.text.isNotEmpty ? minSpendCtrl.text : 'No min. spend',
                          'expiry': expiryCtrl.text.isNotEmpty ? expiryCtrl.text : 'No expiry',
                          'usage': '0 redemptions',
                          'isActive': true,
                        });
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Voucher ${codeCtrl.text.toUpperCase()} created successfully!'),
                          backgroundColor: widget.brandColor,
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
                  child: Text('Publish Voucher', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: widget.brandColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Promo & Voucher Campaign Manager',
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
        itemCount: _vouchers.length,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final voucher = _vouchers[index];
          final bool isActive = voucher['isActive'];

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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: widget.brandColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        voucher['code'],
                        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: widget.brandColor),
                      ),
                    ),
                    Switch.adaptive(
                      value: isActive,
                      activeColor: widget.brandColor,
                      onChanged: (val) {
                        setState(() {
                          voucher['isActive'] = val;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  voucher['discount'],
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w900, color: const Color(0xFF0F172A)),
                ),
                const SizedBox(height: 4),
                Text(
                  '${voucher['minSpend']} • Valid until ${voucher['expiry']}',
                  style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.local_activity_rounded, size: 14, color: Color(0xFF10B981)),
                        const SizedBox(width: 6),
                        Text(voucher['usage'], style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF334155))),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: isActive ? const Color(0xFFECFDF5) : Colors.grey[100],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        isActive ? 'Active' : 'Inactive',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isActive ? const Color(0xFF10B981) : Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreatePromoModal,
        backgroundColor: widget.brandColor,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text('Create Voucher', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}
