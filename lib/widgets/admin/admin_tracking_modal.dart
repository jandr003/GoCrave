import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminTrackingModal extends StatelessWidget {
  final Map<String, dynamic> rider;
  final Color brandColor;

  const AdminTrackingModal({
    super.key,
    required this.rider,
    required this.brandColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.82,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Rider Live Tracking', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                IconButton(icon: const Icon(Icons.close_rounded, color: Colors.grey), onPressed: () => Navigator.pop(context)),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFEEEEEE)),

          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F2FE),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFBBDEFB)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(painter: _TrackingRoutePainter()),
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4))],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(radius: 20, backgroundImage: NetworkImage(rider['avatar'] ?? 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&auto=format&fit=crop')),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(rider['name'] ?? 'Rider', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
                                  Text('On the way • ETA 12 mins', style: GoogleFonts.poppins(fontSize: 11, color: brandColor, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 80,
                      top: 120,
                      child: CircleAvatar(radius: 14, backgroundColor: Color(0xFFFF5622), child: Icon(Icons.two_wheeler_rounded, color: Colors.white, size: 16)),
                    ),
                    const Positioned(
                      right: 60,
                      bottom: 80,
                      child: CircleAvatar(radius: 14, backgroundColor: Colors.redAccent, child: Icon(Icons.location_on_rounded, color: Colors.white, size: 16)),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStepBadge('Assigned', true),
                _buildStepBadge('Picked Up', true),
                _buildStepBadge('On Delivery', true),
                _buildStepBadge('Delivered', false),
              ],
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildStepBadge(String label, bool isDone) {
    return Column(
      children: [
        Icon(isDone ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded, size: 18, color: isDone ? const Color(0xFF2E7D32) : Colors.grey),
        const SizedBox(height: 4),
        Text(label, style: GoogleFonts.poppins(fontSize: 10, fontWeight: isDone ? FontWeight.bold : FontWeight.normal, color: isDone ? const Color(0xFF0F172A) : Colors.grey)),
      ],
    );
  }
}

class _TrackingRoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = const Color(0xFF1E88E5)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(80, 120);
    path.lineTo(size.width * 0.5, 120);
    path.lineTo(size.width * 0.5, size.height - 80);
    path.lineTo(size.width - 60, size.height - 80);

    canvas.drawPath(path, paintLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
