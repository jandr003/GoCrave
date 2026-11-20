import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/rating_manager.dart';

class RatingReviewModal extends StatefulWidget {
  final String orderId;
  final String riderName;
  final Color brandColor;

  const RatingReviewModal({
    super.key,
    required this.orderId,
    required this.riderName,
    required this.brandColor,
  });

  @override
  State<RatingReviewModal> createState() {
    return _RatingReviewModalState();
  }
}

class _RatingReviewModalState extends State<RatingReviewModal> {
  int _selectedStars = 5;
  double _selectedTip = 20.0;
  final TextEditingController _commentCtrl = TextEditingController();

  final List<double> _tipOptions = [
    0.0,
    20.0,
    50.0,
    100.0,
  ];

  @override
  void dispose() {
    _commentCtrl.dispose();
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const SizedBox(height: 16),
          Text(
            'Rate Your Delivery Experience',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F172A),
            ),
          ),
          Text(
            'How was your delivery with ${widget.riderName} for order ${widget.orderId}?',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 20),

          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final starIndex = index + 1;
                final isSelected = starIndex <= _selectedStars;
                return IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedStars = starIndex;
                    });
                  },
                  icon: Icon(
                    isSelected
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    color: isSelected
                        ? Colors.amber
                        : Colors.grey[300],
                    size: 40,
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 16),
          Text(
            'Tip the Rider (Optional)',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: _tipOptions.map((tip) {
              final isSel = _selectedTip == tip;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedTip = tip;
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSel
                            ? widget.brandColor
                            : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSel
                              ? widget.brandColor
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          tip == 0
                              ? 'No Tip'
                              : '₱${tip.toInt()}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isSel
                                ? Colors.white
                                : const Color(0xFF334155),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 16),
          Text(
            'Leave a Review',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
              ),
            ),
            child: TextField(
              controller: _commentCtrl,
              maxLines: 3,
              style: GoogleFonts.poppins(fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Write compliments or feedback for the rider...',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF94A3B8),
                ),
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                RatingManager().submitRating(
                  orderId: widget.orderId,
                  stars: _selectedStars,
                  comment: _commentCtrl.text.trim(),
                  tipAmount: _selectedTip,
                );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Rating and tip successfully submitted. Thank you!',
                      style: GoogleFonts.poppins(),
                    ),
                    backgroundColor: widget.brandColor,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.brandColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: Text(
                'Submit Review & Tip',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
