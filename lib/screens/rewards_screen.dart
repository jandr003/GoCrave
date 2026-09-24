import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/coin_manager.dart';
import '../widgets/daily_reward_modal.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    CoinManager().addListener(_updateState);
  }

  @override
  void dispose() {
    CoinManager().removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    if (mounted) setState(() {});
  }

  final List<String> _categories = [
    'All',
    'Transport',
    'Shopping',
    'Food',
    'E-Wallet',
    'Digital',
  ];

  final List<Map<String, dynamic>> _partners = [
    {'name': 'Angkas', 'color': Color(0xFF000000), 'category': 'Transport', 'points': '800 pts', 'amount': '₱25', 'desc': 'Get ₱25 off on your next Angkas ride.'},
    {'name': 'JoyRide', 'color': Color(0xFF003399), 'category': 'Transport', 'points': '750 pts', 'amount': '₱20', 'desc': 'Safe and affordable JoyRide discount.'},
    {'name': 'Move It', 'color': Color(0xFFFF6D00), 'category': 'Transport', 'points': '900 pts', 'amount': '₱30', 'desc': 'Quick rides with Move It credits.'},
    {'name': 'Grab', 'color': Color(0xFF00B14F), 'category': 'Transport', 'points': '1,500 pts', 'amount': '₱50', 'desc': 'Premium Grab transport discount.'},
    {'name': 'Beep', 'color': Color(0xFF0F146D), 'category': 'Transport', 'points': '500 pts', 'amount': '₱15', 'desc': 'Reload your Beep card with ease.'},
    {'name': 'Lalamove', 'color': Color(0xFFE31B23), 'category': 'Transport', 'points': '1,200 pts', 'amount': '₱40', 'desc': 'Deliver anything with Lalamove.'},
    {'name': 'Shopee', 'color': Color(0xFFEE4D2D), 'category': 'Shopping', 'points': '1,000 pts', 'amount': '₱50', 'desc': 'Shop more with Shopee vouchers.'},
    {'name': 'Lazada', 'color': Color(0xFF0F146D), 'category': 'Shopping', 'points': '1,000 pts', 'amount': '₱50', 'desc': 'Big savings on Lazada checkouts.'},
    {'name': 'GCash', 'color': Color(0xFF0056FF), 'category': 'E-Wallet', 'points': '1,000 pts', 'amount': '₱50', 'desc': 'Top up your GCash wallet instantly.'},
    {'name': 'Maya', 'color': Color(0xFF00D1FF), 'category': 'E-Wallet', 'points': '1,000 pts', 'amount': '₱50', 'desc': 'Everything and more with Maya.'},
    {'name': 'Canva', 'color': Color(0xFF00C4CC), 'category': 'Digital', 'points': '2,000 pts', 'amount': 'Pro', 'desc': '1 Month of Canva Pro access.'},
    {'name': 'Spotify', 'color': Color(0xFF1DB954), 'category': 'Digital', 'points': '2,500 pts', 'amount': 'Prem', 'desc': '1 Month Spotify Premium family.'},
    {'name': 'Google Play', 'color': Color(0xFF4285F4), 'category': 'Digital', 'points': '1,500 pts', 'amount': '₱50', 'desc': 'Google Play Store credits.'},
    {'name': 'GrabFood', 'color': Color(0xFF00B14F), 'category': 'Food', 'points': '1,200 pts', 'amount': '₱40', 'desc': 'Hungry? Grab some food credits.'},
    {'name': 'Foodpanda', 'color': Color(0xFFD70F64), 'category': 'Food', 'points': '1,200 pts', 'amount': '₱40', 'desc': 'Enjoy meals from Foodpanda.'},
  ];

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFFF9F7F4);
    const primaryColor = Color(0xFFFF5622);
    final coinManager = CoinManager();

    final filteredPartners = _selectedCategory == 'All'
        ? _partners
        : _partners.where((p) => p['category'] == _selectedCategory).toList();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Rewards Marketplace',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Help',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF23232C),
                        Color(0xFF14141A),
                        Color(0xFF0A0A0E),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: const Color(0xFFFFD700).withOpacity(0.35),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFD700).withOpacity(0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Stack(
                      children: [
                        Positioned(
                          right: -25,
                          bottom: -20,
                          child: Text(
                            'VIP',
                            style: GoogleFonts.poppins(
                              fontSize: 110,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFFFFD700).withOpacity(0.04),
                              letterSpacing: 4,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(22.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [Color(0xFFFFD700), Color(0xFFFFA000)],
                                          ),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: const Icon(
                                          Icons.contactless_rounded,
                                          size: 16,
                                          color: Color(0xFF1A1A1A),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'CRAVE COINS VIP',
                                        style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFFFFD700),
                                          letterSpacing: 1.8,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFD700).withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: const Color(0xFFFFD700).withOpacity(0.4),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.workspace_premium,
                                          color: Color(0xFFFFD700),
                                          size: 12,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Gold Craver',
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFFFFD700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFD700).withOpacity(0.15),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFFFFD700).withOpacity(0.3),
                                              blurRadius: 12,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.monetization_on_rounded,
                                          color: Color(0xFFFFD700),
                                          size: 28,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            coinManager.totalCoins.toString(),
                                            style: GoogleFonts.poppins(
                                              fontSize: 32,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                              height: 1.1,
                                            ),
                                          ),
                                          Text(
                                            'Available Balance',
                                            style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              color: Colors.grey[400],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        isScrollControlled: true,
                                        builder: (context) => const DailyRewardModal(),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [Color(0xFFFFD700), Color(0xFFFF9800)],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFFFFD700).withOpacity(0.3),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.stars_rounded,
                                            color: Color(0xFF1F1F1F),
                                            size: 16,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            'Check-in Now',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                              color: const Color(0xFF1F1F1F),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              Container(
                                height: 1,
                                color: const Color(0xFFFFD700).withOpacity(0.15),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.confirmation_number_outlined,
                                        size: 16,
                                        color: Colors.grey[400],
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Exchange coins for vouchers',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.grey[400],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "1,000 Coins required to exchange for ₱25 Voucher.",
                                            style: GoogleFonts.poppins(),
                                          ),
                                          backgroundColor: primaryColor,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFFF5622),
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    ),
                                    child: Text(
                                      'Exchange',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),

                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final cat = _categories[index];
                      final isSelected = _selectedCategory == cat;
                      return Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: ChoiceChip(
                          label: Text(cat),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) setState(() => _selectedCategory = cat);
                          },
                          selectedColor: primaryColor,
                          labelStyle: GoogleFonts.poppins(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          backgroundColor: Colors.white,
                          elevation: 0,
                          pressElevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: isSelected ? primaryColor : Colors.grey[200]!),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: filteredPartners.length,
              itemBuilder: (context, index) {
                final partner = filteredPartners[index];
                return _buildPremiumRewardCard(partner);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumRewardCard(Map<String, dynamic> partner) {
    final Color brandColor = partner['color'] as Color;

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  color: Colors.white,
                  child: CustomPaint(
                    painter: _CardWavyPainter(color: brandColor.withOpacity(0.1)),
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: brandColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.stars, color: brandColor, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  partner['points'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: brandColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            partner['amount'],
                            style: GoogleFonts.poppins(
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              color: brandColor,
                            ),
                          ),
                          Text(
                            '${partner['name']} Credits',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            partner['desc'],
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[500],
                              height: 1.4,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 140,
                        alignment: Alignment.center,
                        child: Text(
                          partner['name'].toString().toUpperCase(),
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: brandColor.withOpacity(0.4),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[100]!)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'View Details',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.blueAccent, size: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardWavyPainter extends CustomPainter {
  final Color color;
  _CardWavyPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width * 0.7, 0);
    path.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.4,
      size.width,
      size.height * 0.3,
    );
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);

    final path2 = Path();
    path2.moveTo(size.width, size.height * 0.6);
    path2.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.8,
      size.width * 0.9,
      size.height,
    );
    path2.lineTo(size.width, size.height);
    path2.close();
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
