import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodPhotoProofModal extends StatefulWidget {
  final Map<String, dynamic> order;
  final Color brandColor;
  final VoidCallback onConfirmSendPhoto;

  const FoodPhotoProofModal({
    super.key,
    required this.order,
    required this.brandColor,
    required this.onConfirmSendPhoto,
  });

  @override
  State<FoodPhotoProofModal> createState() => _FoodPhotoProofModalState();
}

class _FoodPhotoProofModalState extends State<FoodPhotoProofModal> {
  String _foodPhoto = 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=600&auto=format&fit=crop';
  bool _isUploadingPhoto = false;
  bool _isQualityConfirmed = true;

  void _simulateCapturePhoto() {
    setState(() => _isUploadingPhoto = true);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isUploadingPhoto = false;
          _foodPhoto = 'https://images.unsplash.com/photo-1547592166-23ac45744acd?q=80&w=600&auto=format&fit=crop';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Prepared food photo captured!', style: GoogleFonts.poppins()),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String orderId = widget.order['id'] ?? '#GOC76120';
    final String customerName = widget.order['customer'] ?? 'Alexander Santos';
    final String dishesText = widget.order['items'] ?? '1x Chicken Adobo, 2x Extra Rice, 1x Coke';

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        top: 24,
        left: 24,
        right: 24,
      ),
      child: SingleChildScrollView(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Prepared Food Photo Proof',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFFFE0B2)),
                  ),
                  child: Text(
                    orderId,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: widget.brandColor,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Capture and send food photo proof to customer before dispatching to rider',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9FB),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Customer: $customerName',
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.restaurant_menu_rounded, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          dishesText,
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700], fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Prepared Food Dish Photo',
              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 8),

            InkWell(
              onTap: _simulateCapturePhoto,
              borderRadius: BorderRadius.circular(18),
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FC),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: widget.brandColor.withOpacity(0.4), width: 1.5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(_foodPhoto, fit: BoxFit.cover),
                      Container(color: Colors.black.withOpacity(0.25)),
                      if (_isUploadingPhoto)
                        const Center(child: CircularProgressIndicator(color: Colors.white))
                      else
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: widget.brandColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 28),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tap to Retake Food Photo Proof',
                                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            GestureDetector(
              onTap: () => setState(() => _isQualityConfirmed = !_isQualityConfirmed),
              child: Row(
                children: [
                  Checkbox(
                    value: _isQualityConfirmed,
                    activeColor: widget.brandColor,
                    onChanged: (val) {
                      if (val != null) setState(() => _isQualityConfirmed = val);
                    },
                  ),
                  Expanded(
                    child: Text(
                      'I confirm that all dishes are complete, packaged securely, and match the customer order.',
                      style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _isQualityConfirmed
                    ? () {
                        widget.onConfirmSendPhoto();
                        Navigator.pop(context);
                      }
                    : null,
                icon: const Icon(Icons.send_rounded, size: 20, color: Colors.white),
                label: Text(
                  'Send Photo to Customer & Dispatch',
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.brandColor,
                  disabledBackgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
