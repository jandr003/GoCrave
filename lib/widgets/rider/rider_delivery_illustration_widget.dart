import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderDeliveryIllustrationWidget extends StatelessWidget {
  final double size;

  const RiderDeliveryIllustrationWidget({
    super.key,
    this.size = 140.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFFFD54F),
          width: 3.0,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFC107).withOpacity(0.2),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: size * 0.18,
            child: Container(
              width: size * 0.38,
              height: size * 0.38,
              decoration: BoxDecoration(
                color: const Color(0xFFFFC107),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 2.5,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.sports_motorsports_rounded,
                  color: Colors.black,
                  size: 32,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: size * 0.16,
            child: Container(
              width: size * 0.55,
              height: size * 0.32,
              decoration: BoxDecoration(
                color: const Color(0xFFFFD54F),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.black,
                  width: 2.5,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.fastfood_rounded,
                      color: Colors.black87,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'GO',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
