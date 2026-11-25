import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/food_data.dart';
import '../screens/category_detail_screen.dart';

class VoiceSearchModal extends StatefulWidget {
  final Color brandColor;

  const VoiceSearchModal({
    super.key,
    required this.brandColor,
  });

  @override
  State<VoiceSearchModal> createState() {
    return _VoiceSearchModalState();
  }
}

class _VoiceSearchModalState extends State<VoiceSearchModal> with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  bool _isListening = true;
  String _recognizedText = 'Listening for your cravings...';

  final List<String> _sampleVoiceCravings = [
    'Juicy Beef Burger',
    'Pepperoni Pizza',
    'Chicken Adobo',
    'Special Goto',
    'Mango Shake',
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _pulseController.repeat(reverse: true);

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isListening = false;
          _recognizedText = '“Juicy Beef Burger”';
        });
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        20,
        24,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'GoCrave Cravings Assistant',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _recognizedText,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: _isListening ? widget.brandColor : Colors.black87,
            ),
          ),
          const SizedBox(height: 32),

          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                width: 90 + (_pulseController.value * 16),
                height: 90 + (_pulseController.value * 16),
                decoration: BoxDecoration(
                  color: widget.brandColor.withOpacity(0.15 + (_pulseController.value * 0.15)),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: widget.brandColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: widget.brandColor.withOpacity(0.4),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.mic_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 36),
          Text(
            'Or tap a suggested craving:',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: _sampleVoiceCravings.map((craving) {
              return InkWell(
                onTap: () {
                  final filtered = allFoodItems.where((item) {
                    return item['title']!.toLowerCase().contains(craving.toLowerCase());
                  }).toList();

                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CategoryDetailScreen(
                          categoryName: craving,
                          foodItems: filtered.isNotEmpty ? filtered : allFoodItems,
                        );
                      },
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Text(
                    craving,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF334155),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
