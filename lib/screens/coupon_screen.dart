import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/cart_manager.dart';

class CouponScreen extends StatelessWidget {
  const CouponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color brandColor = Color(0xFFFF5622);

    final List<Map<String, dynamic>> availableCoupons = [
      {
        'code': 'CRAVE30DEAL',
        'discount': '30% OFF',
        'save': 'Save 30% on this order',
        'desc': 'Maximum discount up to ₱125 on orders above ₱500',
        'expiry': 'Valid till 31 Dec 2027',
        'percentage': 0.3,
      },
      {
        'code': 'HELLO20',
        'discount': '20% OFF',
        'save': 'Save 20% on your next meal',
        'desc': 'No minimum spend required',
        'expiry': 'Valid till 31 Oct 2026',
        'percentage': 0.2,
      },
      {
        'code': 'FREESHIP',
        'discount': 'FREE',
        'save': 'Free Delivery on any order',
        'desc': 'Valid for all restaurants in Manila',
        'expiry': 'Valid till 15 Nov 2026',
        'percentage': 0.05,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Apply Coupon',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
                onPressed: () {},
              ),
              if (CartManager().items.isNotEmpty)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: brandColor,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      CartManager().items.length.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter Coupon Code',
                          hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 15),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'APPLY',
                        style: GoogleFonts.poppins(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'More Offers',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              ...availableCoupons.map((coupon) => _buildCouponCard(context, coupon, brandColor)).toList(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCouponCard(BuildContext context, Map<String, dynamic> coupon, Color brandColor) {
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
                          GestureDetector(
                            onTap: () {
                              CartManager().applyCoupon(coupon['code'], coupon['percentage']);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Coupon ${coupon['code']} applied!'),
                                  backgroundColor: brandColor,
                                ),
                              );
                            },
                            child: Text(
                              'APPLY',
                              style: GoogleFonts.poppins(
                                color: brandColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                              ),
                            ),
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
                      // Horizontal Dashed Divider
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
