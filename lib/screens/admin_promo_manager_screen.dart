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
      'code': 'CRAVE30DEAL',
      'discount': '30% OFF',
      'title': 'Save 30% on this order',
      'minSpend': 'Maximum discount up to ₱125 on orders above ₱500',
      'expiry': 'Valid till 31 Dec 2027',
      'isActive': true,
    },
    {
      'code': 'GOCRAVE50',
      'discount': '₱50 OFF',
      'title': 'Save ₱50 on food delivery',
      'minSpend': 'Minimum spend of ₱300 required',
      'expiry': 'Valid till 31 Dec 2026',
      'isActive': true,
    },
    {
      'code': 'FREEDELIVERY',
      'discount': 'FREE DEL',
      'title': 'Free delivery voucher',
      'minSpend': 'Minimum spend of ₱250 required',
      'expiry': 'Valid till 30 Nov 2026',
      'isActive': false,
    },
  ];

  void _showCreatePromoModal() {
    final codeCtrl = TextEditingController();
    final discountCtrl = TextEditingController();
    final titleCtrl = TextEditingController();
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
                decoration: const InputDecoration(labelText: 'Voucher Code (e.g. CRAVE30DEAL)'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: discountCtrl,
                decoration: const InputDecoration(labelText: 'Discount Badge Text (e.g. 30% OFF or ₱50 OFF)'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: titleCtrl,
                decoration: const InputDecoration(labelText: 'Subtitle Title (e.g. Save 30% on this order)'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: minSpendCtrl,
                decoration: const InputDecoration(labelText: 'Rules Details (e.g. Max discount up to ₱125 above ₱500)'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: expiryCtrl,
                decoration: const InputDecoration(labelText: 'Expiry Date (e.g. Valid till 31 Dec 2027)'),
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
                          'title': titleCtrl.text.isNotEmpty ? titleCtrl.text : 'Special Promo Deal',
                          'minSpend': minSpendCtrl.text.isNotEmpty ? minSpendCtrl.text : 'Valid for all orders',
                          'expiry': expiryCtrl.text.isNotEmpty ? expiryCtrl.text : 'Valid till end of month',
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
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final voucher = _vouchers[index];
          final bool isActive = voucher['isActive'];

          return Container(
            height: 140,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFCBD5E1), width: 1.2),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: widget.brandColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(19),
                      bottomLeft: Radius.circular(19),
                    ),
                  ),
                  child: Center(
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        voucher['discount'],
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(19),
                        bottomRight: Radius.circular(19),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: widget.brandColor.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(Icons.local_offer_rounded, color: widget.brandColor, size: 16),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  voucher['code'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                              ],
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
                        const SizedBox(height: 6),
                        Text(
                          voucher['title'],
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF10B981),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          voucher['minSpend'],
                          style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF64748B)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          voucher['expiry'],
                          style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF94A3B8), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
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
