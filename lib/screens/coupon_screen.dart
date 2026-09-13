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
      height: 180,
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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/gocrave_app_logo.png',
                                height: 24,
                                color: brandColor,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                coupon['code'],
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
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
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.stars, color: Color(0xFF4CAF50), size: 16),
                          const SizedBox(width: 8),
                          Text(
                            coupon['save'],
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF4CAF50),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          '--------------------------------------',
                          maxLines: 1,
                          style: TextStyle(color: Colors.grey, letterSpacing: 2),
                        ),
                      ),
                      _buildDetailRow(Icons.calendar_today_outlined, coupon['desc']),
                      const SizedBox(height: 4),
                      _buildDetailRow(Icons.access_time, coupon['expiry']),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Punched holes simulation
          Positioned(
            left: 58,
            top: 40,
            child: _buildPunchHole(),
          ),
          Positioned(
            left: 58,
            top: 80,
            child: _buildPunchHole(),
          ),
          Positioned(
            left: 58,
            top: 120,
            child: _buildPunchHole(),
          ),
        ],
      ),
    );
  }

  Widget _buildPunchHole() {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        color: Color(0xFFF8F9FA),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[400]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
