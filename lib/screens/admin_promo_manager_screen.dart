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
      'save': 'Save 30% on this order',
      'desc': 'Maximum discount up to ₱125 on orders above ₱500',
      'expiry': 'Valid till 31 Dec 2027',
      'isActive': true,
    },
    {
      'code': 'GOCRAVE50',
      'discount': '₱50 OFF',
      'save': 'Save ₱50 on food delivery',
      'desc': 'Minimum spend of ₱300 required',
      'expiry': 'Valid till 31 Dec 2026',
      'isActive': true,
    },
    {
      'code': 'FREEDELIVERY',
      'discount': 'FREE',
      'save': 'Free Delivery on any order',
      'desc': 'Valid for all restaurants in Malolos',
      'expiry': 'Valid till 30 Nov 2026',
      'isActive': false,
    },
  ];

  void _showCreatePromoModal() {
    final codeCtrl = TextEditingController();
    final discountCtrl = TextEditingController();
    final saveCtrl = TextEditingController();
    final descCtrl = TextEditingController();
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
                decoration: const InputDecoration(labelText: 'Discount Badge (e.g. 30% OFF or ₱50 OFF)'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: saveCtrl,
                decoration: const InputDecoration(labelText: 'Subtitle (e.g. Save 30% on this order)'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descCtrl,
                decoration: const InputDecoration(labelText: 'Details (e.g. Max discount up to ₱125 above ₱500)'),
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
                          'save': saveCtrl.text.isNotEmpty ? saveCtrl.text : 'Special Promo Deal',
                          'desc': descCtrl.text.isNotEmpty ? descCtrl.text : 'Valid for all orders',
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
      backgroundColor: const Color(0xFFF8F9FA),
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._vouchers.map((coupon) => _buildCouponCard(context, coupon, widget.brandColor)).toList(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreatePromoModal,
        backgroundColor: widget.brandColor,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text('Create Voucher', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  Widget _buildCouponCard(BuildContext context, Map<String, dynamic> coupon, Color brandColor) {
    final bool isActive = coupon['isActive'];

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      height: 190,
      width: double.infinity,
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                width: 70,
                decoration: BoxDecoration(
                  color: brandColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  ),
                ),
                alignment: Alignment.center,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    coupon['discount'],
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: brandColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.all(4),
                                child: Image.asset(
                                  'assets/images/gocrave_app_logo.png',
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                coupon['code'],
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                          Switch.adaptive(
                            value: isActive,
                            activeColor: brandColor,
                            onChanged: (val) {
                              setState(() {
                                coupon['isActive'] = val;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.stars_rounded, color: Color(0xFF4CAF50), size: 18),
                          const SizedBox(width: 8),
                          Text(
                            coupon['save'],
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF4CAF50),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: List.generate(
                          20,
                          (index) => Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              height: 1,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildDetailRow(Icons.account_balance_wallet_outlined, coupon['desc']),
                      const SizedBox(height: 6),
                      _buildDetailRow(Icons.access_time, coupon['expiry']),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          Positioned(
            left: 69,
            top: 15,
            bottom: 15,
            child: Column(
              children: List.generate(
                12,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  width: 1.5,
                  height: 6,
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
            ),
          ),

          Positioned(left: -10, top: 40, child: _buildSideNotch()),
          Positioned(left: -10, top: 80, child: _buildSideNotch()),
          Positioned(left: -10, top: 120, child: _buildSideNotch()),

          Positioned(left: 58, top: -12, child: _buildPunchHole(size: 24)),
          Positioned(left: 58, bottom: -12, child: _buildPunchHole(size: 24)),

          Positioned(right: -10, top: 40, child: _buildSideNotch()),
          Positioned(right: -10, top: 80, child: _buildSideNotch()),
          Positioned(right: -10, top: 120, child: _buildSideNotch()),
        ],
      ),
    );
  }

  Widget _buildPunchHole({double size = 20}) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Color(0xFFF8F9FA),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildSideNotch() {
    return Container(
      width: 20,
      height: 20,
      decoration: const BoxDecoration(
        color: Color(0xFFF8F9FA),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[500]),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
