import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/surge_manager.dart';

class AdminSurgePricingScreen extends StatefulWidget {
  final Color brandColor;

  const AdminSurgePricingScreen({
    super.key,
    this.brandColor = const Color(0xFFFF5622),
  });

  @override
  State<AdminSurgePricingScreen> createState() => _AdminSurgePricingScreenState();
}

class _AdminSurgePricingScreenState extends State<AdminSurgePricingScreen> {
  final SurgeManager _surgeManager = SurgeManager();

  @override
  void initState() {
    super.initState();
    _surgeManager.addListener(_onSurgeChanged);
  }

  @override
  void dispose() {
    _surgeManager.removeListener(_onSurgeChanged);
    super.dispose();
  }

  void _onSurgeChanged() {
    if (mounted) {
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double baseFee = _surgeManager.baseDeliveryFee;
    final double multiplier = _surgeManager.surgeMultiplier;
    final bool isSurgeActive = _surgeManager.isSurgeActive;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: widget.brandColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Surge Pricing & Delivery Zone Fees',
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
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
                      Text('Base Delivery Fee', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                      Text('₱${baseFee.toStringAsFixed(2)}', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w900, color: widget.brandColor)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Standard flat fee for delivery within base delivery radius in Malolos.', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                  const SizedBox(height: 14),
                  Slider.adaptive(
                    value: baseFee,
                    min: 15.0,
                    max: 60.0,
                    divisions: 45,
                    activeColor: widget.brandColor,
                    onChanged: (val) {
                      _surgeManager.updateBaseFee(val);
                    },
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
                      Text('Peak Hour / Rain Surge Pricing', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                      Switch.adaptive(
                        value: isSurgeActive,
                        activeColor: widget.brandColor,
                        onChanged: (val) {
                          _surgeManager.updateSurge(val, multiplier);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text('Enable dynamic multipliers during peak lunch/dinner hours or heavy weather conditions.', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                  const SizedBox(height: 16),
                  if (isSurgeActive) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Surge Multiplier', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                        Text('${multiplier.toStringAsFixed(1)}x', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: widget.brandColor)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Slider.adaptive(
                      value: multiplier,
                      min: 1.0,
                      max: 2.5,
                      divisions: 15,
                      activeColor: widget.brandColor,
                      onChanged: (val) {
                        _surgeManager.updateSurge(isSurgeActive, val);
                      },
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
