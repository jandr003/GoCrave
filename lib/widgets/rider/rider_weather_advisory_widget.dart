import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderWeatherAdvisoryWidget extends StatelessWidget {
  final Color brandColor;

  const RiderWeatherAdvisoryWidget({
    super.key,
    required this.brandColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFBBDEFB),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFF1976D2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.cloud_queue_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Weather & Traffic Advisory',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0D47A1),
                  ),
                ),
                Text(
                  'Moderate rain alert in Malolos zone. Drive carefully and wear rain gear.',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF1565C0),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
