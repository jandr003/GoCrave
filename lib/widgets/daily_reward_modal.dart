import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/coin_manager.dart';

class DailyRewardModal extends StatefulWidget {
  const DailyRewardModal({super.key});

  @override
  State<DailyRewardModal> createState() => _DailyRewardModalState();
}

class _DailyRewardModalState extends State<DailyRewardModal> {
  final Color brandColor = const Color(0xFFFF5622);
  bool _isClaiming = false;

  @override
  Widget build(BuildContext context) {
    final coinManager = CoinManager();
    final streak = coinManager.currentStreak;
    final canClaim = coinManager.canClaimToday;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Daily Check-in',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check in for 7 days to get a Super Bonus!',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 32),
          
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemCount: 7,
            itemBuilder: (context, index) {
              bool isPast = index < streak;
              bool isToday = index == streak && canClaim;
              bool isFuture = index > streak || (index == streak && !canClaim);
              bool isDay7 = index == 6;

              return _buildDayItem(index + 1, isPast, isToday, isFuture, isDay7);
            },
          ),
          
          const SizedBox(height: 40),
          
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: canClaim && !_isClaiming ? _handleClaim : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: brandColor,
                disabledBackgroundColor: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: _isClaiming 
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : Text(
                    canClaim ? 'Claim Today' : 'Come back tomorrow!',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: canClaim ? Colors.white : Colors.grey[400],
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayItem(int day, bool isPast, bool isToday, bool isFuture, bool isDay7) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: isPast ? brandColor.withOpacity(0.1) : (isToday ? brandColor : Colors.grey[50]),
            borderRadius: BorderRadius.circular(12),
            border: isToday ? null : Border.all(color: Colors.grey[200]!),
          ),
          child: Center(
            child: isPast 
              ? Icon(Icons.check, color: brandColor, size: 24)
              : (isDay7 
                  ? Icon(Icons.card_giftcard, color: isToday ? Colors.white : Colors.amber, size: 24)
                  : Icon(Icons.monetization_on, color: isToday ? Colors.white : Colors.amber, size: 24)),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Day $day',
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: (isToday || isPast) ? FontWeight.bold : FontWeight.w500,
            color: (isToday || isPast) ? Colors.black : Colors.grey[400],
          ),
        ),
      ],
    );
  }

  void _handleClaim() async {
    setState(() => _isClaiming = true);
    
    await Future.delayed(const Duration(milliseconds: 1000));
    
    final reward = await CoinManager().claimDailyReward();
    
    if (mounted) {
      setState(() => _isClaiming = false);
      Navigator.pop(context);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.monetization_on, color: Colors.amber),
              const SizedBox(width: 12),
              Text('Nice! You earned $reward Crave Coins!'),
            ],
          ),
          backgroundColor: Colors.black87,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }
}
