import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminHeaderCard extends StatefulWidget {
  final Color brandColor;
  final String? adminAvatarUrl;
  final VoidCallback onTapAssignRider;
  final VoidCallback onTapManageOrders;
  final VoidCallback onTapManageRiders;

  const AdminHeaderCard({
    super.key,
    required this.brandColor,
    this.adminAvatarUrl,
    required this.onTapAssignRider,
    required this.onTapManageOrders,
    required this.onTapManageRiders,
  });

  @override
  State<AdminHeaderCard> createState() => _AdminHeaderCardState();
}

class _AdminHeaderCardState extends State<AdminHeaderCard> {
  final List<double> _weeklyOrderCounts = [10.0, 20.0, 20.0, 32.0, 26.0, 40.0, 47.0];

  void _showQuickDetailsModal(String title, String subtitle, String category, String details) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(24, 20, 24, MediaQuery.of(context).viewInsets.bottom + 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  category,
                  style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: widget.brandColor),
                ),
              ),
              const SizedBox(height: 10),
              Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
              Text(subtitle, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Text(
                  details,
                  style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF334155), height: 1.5),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (category.contains('Order') || category.contains('Payment')) {
                      widget.onTapManageOrders();
                    } else if (category.contains('Rider')) {
                      widget.onTapManageRiders();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.brandColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: Text('Take Action Now', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFEEEEEE)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good morning, Admin',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Manage your delivery operations',
                      style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                radius: 22,
                backgroundColor: widget.brandColor.withOpacity(0.12),
                backgroundImage: NetworkImage(
                  widget.adminAvatarUrl ?? 'https://api.dicebear.com/7.x/avataaars/png?seed=AdminGoCrave&backgroundColor=ff5622',
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildOverviewCard('128', 'Total Orders', widget.brandColor),
              const SizedBox(width: 10),
              _buildOverviewCard('18', 'Active Deliveries', const Color(0xFF2563EB)),
              const SizedBox(width: 10),
              _buildOverviewCard('96', 'Completed Today', const Color(0xFF10B981)),
            ],
          ),
        ),

        const SizedBox(height: 24),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            'Pending Actions',
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
          ),
        ),
        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _buildPendingActionCard(
                title: 'Orders to Review',
                subtitle: 'Orders needing admin approval',
                badgeCount: '05',
                badgeColor: const Color(0xFFEF4444),
                onTap: () {
                  widget.onTapManageOrders();
                },
              ),
              const SizedBox(height: 10),
              _buildPendingActionCard(
                title: 'Orders to Assign',
                subtitle: 'Orders without an assigned rider',
                badgeCount: '03',
                badgeColor: widget.brandColor,
                onTap: () {
                  widget.onTapAssignRider();
                },
              ),
              const SizedBox(height: 10),
              _buildPendingActionCard(
                title: 'Payments to Verify',
                subtitle: 'Transactions awaiting verification',
                badgeCount: '02',
                badgeColor: const Color(0xFFD97706),
                onTap: () {
                  widget.onTapManageOrders();
                },
              ),
            ],
          ),
        ),



        const SizedBox(height: 24),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Weekly Transactions',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
              ),
              Row(
                children: [
                  const Icon(Icons.trending_up_rounded, color: Color(0xFF10B981), size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '+12%',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF10B981),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFEEEEEE)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('128 total orders processed this week', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                const SizedBox(height: 14),
                SizedBox(
                  height: 140,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: _WeeklyTransactionsPainter(
                      dataPoints: _weeklyOrderCounts,
                      lineColor: widget.brandColor,
                      maxY: 60,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            'Latest Updates',
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
          ),
        ),
        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFEEEEEE)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Column(
              children: [
                _buildLatestUpdateTile(
                  title: 'New Customer Order Received',
                  subtitle: 'Order #GC-0000128 placed by Juan Dela Cruz',
                  time: '2 mins ago',
                  icon: Icons.assignment_turned_in_rounded,
                  onTap: () => _showQuickDetailsModal(
                    'New Customer Order Received',
                    'Order #GC-0000128 placed for McDonald\'s',
                    'Latest Update',
                    'Customer Juan Dela Cruz placed order #GC-0000128 for ₱249. Awaiting merchant confirmation.',
                  ),
                ),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                _buildLatestUpdateTile(
                  title: 'Rider Assignment Confirmed',
                  subtitle: 'Miguel Reyes accepted assignment for #GC-0000128',
                  time: '5 mins ago',
                  icon: Icons.two_wheeler_rounded,
                  onTap: () => _showQuickDetailsModal(
                    'Rider Assignment Confirmed',
                    'Miguel Reyes assigned to #GC-0000128',
                    'Latest Update',
                    'Rider Miguel Reyes (#R001) accepted delivery assignment for McDonald\'s order #GC-0000128.',
                  ),
                ),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                _buildLatestUpdateTile(
                  title: 'Payment Verification Updated',
                  subtitle: 'GCash reference code #GC-8842 verified',
                  time: '12 mins ago',
                  icon: Icons.check_circle_rounded,
                  onTap: () => _showQuickDetailsModal(
                    'Payment Verification Updated',
                    'GCash payment of ₱320 verified',
                    'Latest Update',
                    'GCash transaction reference code #GC-8842 was verified by Admin. Order status set to Paid.',
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildOverviewCard(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFEEEEEE)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF64748B),
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingActionCard({
    required String title,
    required String subtitle,
    required String badgeCount,
    required Color badgeColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFEEEEEE)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                  ),
                ],
              ),
            ),
            Text(
              badgeCount,
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w900, color: badgeColor),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right_rounded, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryStatusPill(String label, String count, Color color) {
    return Column(
      children: [
        Text(
          count,
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w900, color: color),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF64748B)),
        ),
      ],
    );
  }

  Widget _buildLatestUpdateTile({
    required String title,
    required String subtitle,
    required String time,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 20, color: widget.brandColor),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                  Text(subtitle, style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(time, style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF94A3B8))),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right_rounded, color: Colors.grey, size: 18),
          ],
        ),
      ),
    );
  }
}

class _WeeklyTransactionsPainter extends CustomPainter {
  final List<double> dataPoints;
  final Color lineColor;
  final double maxY;

  _WeeklyTransactionsPainter({
    required this.dataPoints,
    required this.lineColor,
    required this.maxY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double leftPadding = 28.0;
    const double bottomPadding = 24.0;
    final double chartWidth = size.width - leftPadding;
    final double chartHeight = size.height - bottomPadding;

    final Paint gridPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 1.0;

    final TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);

    final List<int> yLabels = [60, 40, 20, 0];
    for (int i = 0; i < yLabels.length; i++) {
      final double yPos = (i / (yLabels.length - 1)) * chartHeight;
      canvas.drawLine(Offset(leftPadding, yPos), Offset(size.width, yPos), gridPaint);

      textPainter.text = TextSpan(
        text: '${yLabels[i]}',
        style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF94A3B8), fontWeight: FontWeight.w500),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(0, yPos - textPainter.height / 2));
    }

    final List<String> xLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    for (int i = 0; i < xLabels.length; i++) {
      final double xPos = leftPadding + (i / (xLabels.length - 1)) * chartWidth;
      textPainter.text = TextSpan(
        text: xLabels[i],
        style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF94A3B8), fontWeight: FontWeight.w500),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(xPos - textPainter.width / 2, size.height - textPainter.height + 4));
    }

    if (dataPoints.isEmpty) return;

    final List<Offset> points = [];
    final double stepX = chartWidth / (dataPoints.length - 1);
    for (int i = 0; i < dataPoints.length; i++) {
      final double x = leftPadding + (i * stepX);
      final double normalizedY = (dataPoints[i] / maxY).clamp(0.0, 1.0);
      final double y = chartHeight - (normalizedY * chartHeight);
      points.add(Offset(x, y));
    }

    final Path linePath = Path();
    linePath.moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final Offset p0 = points[i];
      final Offset p1 = points[i + 1];
      final Offset controlPoint1 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p0.dy);
      final Offset controlPoint2 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p1.dy);
      linePath.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx, controlPoint2.dy, p1.dx, p1.dy);
    }

    final Path fillPath = Path.from(linePath);
    fillPath.lineTo(points.last.dx, chartHeight);
    fillPath.lineTo(points.first.dx, chartHeight);
    fillPath.close();

    final Paint fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          lineColor.withOpacity(0.28),
          lineColor.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, chartHeight));

    canvas.drawPath(fillPath, fillPaint);

    final Paint strokePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(linePath, strokePaint);

    final Paint dotOutlinePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Paint dotInnerPaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.fill;

    for (final Offset point in points) {
      canvas.drawCircle(point, 5.0, dotOutlinePaint);
      canvas.drawCircle(point, 3.5, dotInnerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _WeeklyTransactionsPainter oldDelegate) {
    return oldDelegate.dataPoints != dataPoints || oldDelegate.lineColor != lineColor;
  }
}
