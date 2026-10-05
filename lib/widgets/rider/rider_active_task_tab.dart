import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderActiveTaskTab extends StatelessWidget {
  final Map<String, dynamic>? activeTask;
  final int taskStep;
  final Color brandColor;
  final VoidCallback onAdvanceTaskStep;

  const RiderActiveTaskTab({
    super.key,
    required this.activeTask,
    required this.taskStep,
    required this.brandColor,
    required this.onAdvanceTaskStep,
  });

  @override
  Widget build(BuildContext context) {
    if (activeTask == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              Icon(Icons.near_me_disabled_rounded, size: 60, color: Colors.grey[300]),
              const SizedBox(height: 12),
              Text(
                'No Active Delivery Task',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Accept a request from the Deliveries tab to start a delivery workflow.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      );
    }

    String actionBtnLabel = 'Navigate to Pickup';
    IconData actionIcon = Icons.navigation_rounded;

    if (taskStep == 2) {
      actionBtnLabel = 'Confirm Food Pick Up';
      actionIcon = Icons.takeout_dining_rounded;
    } else if (taskStep == 3) {
      actionBtnLabel = 'Complete Delivery & Collect ${activeTask!['payout']}';
      actionIcon = Icons.check_circle_rounded;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFEEEEEE)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [brandColor, const Color(0xFFFF7043)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Active Delivery',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'View Details >',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          activeTask!['id'],
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            activeTask!['payout'],
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2E7D32),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFF3D00),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.restaurant_rounded, color: Colors.white, size: 12),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          activeTask!['restaurant'],
                                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                        ),
                                        Text(
                                          activeTask!['restoAddress'],
                                          style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[500]),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 11.0, top: 2, bottom: 2),
                                child: Container(
                                  width: 2,
                                  height: 16,
                                  color: Colors.grey[300],
                                ),
                              ),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFF5622),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.location_on_rounded, color: Colors.white, size: 12),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          activeTask!['customer'],
                                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                        ),
                                        Text(
                                          activeTask!['customerAddress'],
                                          style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[500]),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F2FE),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: const Color(0xFFBBDEFB)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: CustomPaint(
                                      painter: _MapRoutePainter(),
                                    ),
                                  ),
                                  const Positioned(
                                    left: 20,
                                    top: 15,
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Color(0xFFFF5622),
                                      child: Icon(Icons.two_wheeler_rounded, color: Colors.white, size: 14),
                                    ),
                                  ),
                                  const Positioned(
                                    right: 15,
                                    bottom: 15,
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.redAccent,
                                      child: Icon(Icons.location_on_rounded, color: Colors.white, size: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FC),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFEEEEEE)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.restaurant_menu_rounded, size: 16, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              activeTask!['items'],
                              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[800], fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.near_me_rounded, size: 14, color: Color(0xFFFF5622)),
                            const SizedBox(width: 4),
                            Text(
                              activeTask!['distance'],
                              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Row(
                          children: [
                            const Icon(Icons.access_time_rounded, size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              'ETA 12 mins',
                              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: onAdvanceTaskStep,
                        icon: Icon(actionIcon, size: 18, color: Colors.white),
                        label: Text(
                          actionBtnLabel,
                          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: brandColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MapRoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = const Color(0xFF1E88E5)
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(25, 20);
    path.lineTo(size.width * 0.45, 20);
    path.lineTo(size.width * 0.45, size.height * 0.7);
    path.lineTo(size.width - 20, size.height * 0.7);

    canvas.drawPath(path, paintLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
