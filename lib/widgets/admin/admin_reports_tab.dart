import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart' hide Path;
import '../../data/order_model.dart';
import '../../screens/admin_export_pdf_screen.dart';

class AdminReportsTab extends StatefulWidget {
  final Color brandColor;
  final List<OrderModel>? orders;
  final Map<String, List<double>>? customChartData;

  const AdminReportsTab({
    super.key,
    required this.brandColor,
    this.orders,
    this.customChartData,
  });

  @override
  State<AdminReportsTab> createState() => _AdminReportsTabState();
}

class _AdminReportsTabState extends State<AdminReportsTab> {
  int _viewMode = 0;
  int _periodIndex = 0;
  int _selectedTab = 0;
  String _selectedDate = 'Apr 26, 2025';

  final List<String> _viewModes = ['Overview Chart', 'Reports Summary'];
  final List<String> _periods = ['Daily', 'Weekly', 'Monthly'];
  final List<String> _tabs = ['Orders', 'Revenue', 'Performance'];
  final List<String> _availableDates = ['Apr 26, 2025', 'Apr 25, 2025', 'Apr 24, 2025', 'This Week', 'This Month'];

  Map<int, List<double>> get _chartDataSets {
    if (widget.customChartData != null) {
      return {
        0: widget.customChartData!['orders'] ?? [10, 20, 20, 32, 26, 40, 36, 47],
        1: widget.customChartData!['revenue'] ?? [12, 18, 25, 30, 38, 42, 40, 52],
        2: widget.customChartData!['performance'] ?? [85, 88, 90, 92, 91, 95, 94, 98],
      };
    }
    return const {
      0: [10, 20, 20, 32, 26, 40, 36, 47],
      1: [12, 18, 25, 30, 38, 42, 40, 52],
      2: [85, 88, 90, 92, 91, 95, 94, 98],
    };
  }

  Map<String, int> _calculateStatusCounts() {
    final Map<String, int> counts = {
      'Pending': 18,
      'Assigned': 28,
      'In Progress': 34,
      'On Delivery': 22,
      'Completed': 72,
    };

    if (widget.orders != null && widget.orders!.isNotEmpty) {
      counts['Pending'] = 0;
      counts['Assigned'] = 0;
      counts['In Progress'] = 0;
      counts['On Delivery'] = 0;
      counts['Completed'] = 0;

      for (var order in widget.orders!) {
        final status = order.status.trim().toLowerCase();
        if (status.contains('pending')) {
          counts['Pending'] = (counts['Pending'] ?? 0) + 1;
        } else if (status.contains('assigned')) {
          counts['Assigned'] = (counts['Assigned'] ?? 0) + 1;
        } else if (status.contains('in progress') || status.contains('progress')) {
          counts['In Progress'] = (counts['In Progress'] ?? 0) + 1;
        } else if (status.contains('delivery') || status.contains('on delivery')) {
          counts['On Delivery'] = (counts['On Delivery'] ?? 0) + 1;
        } else if (status.contains('completed') || status.contains('delivered')) {
          counts['Completed'] = (counts['Completed'] ?? 0) + 1;
        }
      }
    }

    return counts;
  }

  double _calculateTotalRevenue() {
    if (widget.orders != null && widget.orders!.isNotEmpty) {
      return widget.orders!.fold(0.0, (sum, order) {
        final double val = double.tryParse(order.price.replaceAll('₱', '').replaceAll(',', '').trim()) ?? 0.0;
        return sum + val;
      });
    }
    return 28450.0;
  }

  int _calculateTotalOrders() {
    if (widget.orders != null && widget.orders!.isNotEmpty) {
      return widget.orders!.length;
    }
    return 128;
  }

  @override
  Widget build(BuildContext context) {
    final activeData = _chartDataSets[_selectedTab] ?? _chartDataSets[0]!;
    final Color chartColor = widget.brandColor;
    final statusCounts = _calculateStatusCounts();
    final int totalStatusOrders = statusCounts.values.fold(0, (sum, count) => sum + count);
    final int effectiveTotalOrders = totalStatusOrders > 0 ? totalStatusOrders : _calculateTotalOrders();
    final double totalRevenueVal = _calculateTotalRevenue();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(_viewModes.length, (idx) {
            final isSelected = _viewMode == idx;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: idx == 0 ? 8.0 : 0.0),
                child: InkWell(
                  onTap: () => setState(() => _viewMode = idx),
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? widget.brandColor : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: isSelected ? widget.brandColor : const Color(0xFFE2E8F0)),
                      boxShadow: isSelected
                          ? [BoxShadow(color: widget.brandColor.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 3))]
                          : [],
                    ),
                    child: Center(
                      child: Text(
                        _viewModes[idx],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                          color: isSelected ? Colors.white : const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),

        const SizedBox(height: 18),

        if (_viewMode == 0) ...[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Orders Overview',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
            Row(
              children: [
                _buildDateDropdownPill(),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.download_rounded, color: widget.brandColor, size: 22),
                  tooltip: 'Export Monthly PDF Report',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminExportPdfScreen(brandColor: widget.brandColor),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: List.generate(_tabs.length, (idx) {
                final isSelected = _selectedTab == idx;
                return Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _selectedTab = idx),
                    borderRadius: BorderRadius.circular(12),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? widget.brandColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: isSelected
                            ? [BoxShadow(color: widget.brandColor.withOpacity(0.35), blurRadius: 8, offset: const Offset(0, 3))]
                            : [],
                      ),
                      child: Center(
                        child: Text(
                          _tabs[idx],
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? Colors.white : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 16),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: SizedBox(
              height: 180,
              width: double.infinity,
              child: CustomPaint(
                painter: _CurvedChartPainter(
                  dataPoints: activeData,
                  lineColor: chartColor,
                  maxY: 60,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Container(
            width: double.infinity,
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
                Text(
                  'Order Status',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 16),
                _buildDynamicStatusRow(
                  dotColor: const Color(0xFFEF4444),
                  label: 'Pending',
                  count: statusCounts['Pending'] ?? 0,
                  total: effectiveTotalOrders,
                ),
                const Divider(height: 20, color: Color(0xFFF1F5F9)),
                _buildDynamicStatusRow(
                  dotColor: widget.brandColor,
                  label: 'Assigned',
                  count: statusCounts['Assigned'] ?? 0,
                  total: effectiveTotalOrders,
                ),
                const Divider(height: 20, color: Color(0xFFF1F5F9)),
                _buildDynamicStatusRow(
                  dotColor: const Color(0xFFF59E0B),
                  label: 'In Progress',
                  count: statusCounts['In Progress'] ?? 0,
                  total: effectiveTotalOrders,
                ),
                const Divider(height: 20, color: Color(0xFFF1F5F9)),
                _buildDynamicStatusRow(
                  dotColor: const Color(0xFF2563EB),
                  label: 'On Delivery',
                  count: statusCounts['On Delivery'] ?? 0,
                  total: effectiveTotalOrders,
                ),
                const Divider(height: 20, color: Color(0xFFF1F5F9)),
                _buildDynamicStatusRow(
                  dotColor: const Color(0xFF10B981),
                  label: 'Completed',
                  count: statusCounts['Completed'] ?? 0,
                  total: effectiveTotalOrders,
                ),
              ],
            ),
          ),
        ] else ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reports Summary',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F172A),
                ),
              ),
              _buildDateDropdownPill(),
            ],
          ),

          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: List.generate(_periods.length, (idx) {
                final isSelected = _periodIndex == idx;
                return Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _periodIndex = idx),
                    borderRadius: BorderRadius.circular(14),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? widget.brandColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: isSelected
                            ? [BoxShadow(color: widget.brandColor.withOpacity(0.35), blurRadius: 8, offset: const Offset(0, 3))]
                            : [],
                      ),
                      child: Center(
                        child: Text(
                          _periods[idx],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? Colors.white : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 18),

          Builder(
            builder: (context) {
              int displayOrders = effectiveTotalOrders;
              double displayRevenue = totalRevenueVal;
              String ordersChange = '↑ 12% vs. yesterday';
              String revenueChange = '↑ 15% vs. yesterday';
              String timeVal = '28 min';
              String timeChange = '↓ 8% vs. yesterday';
              String ratingVal = '4.8 / 5';
              String ratingChange = '↑ 2% vs. yesterday';

              if (_periodIndex == 1) {
                displayOrders = (effectiveTotalOrders * 6.8).round();
                displayRevenue = totalRevenueVal * 6.8;
                ordersChange = '↑ 18% vs. last week';
                revenueChange = '↑ 21% vs. last week';
                timeVal = '26 min';
                timeChange = '↓ 12% vs. last week';
                ratingChange = '↑ 4% vs. last week';
              } else if (_periodIndex == 2) {
                displayOrders = (effectiveTotalOrders * 28.5).round();
                displayRevenue = totalRevenueVal * 28.5;
                ordersChange = '↑ 24% vs. last month';
                revenueChange = '↑ 28% vs. last month';
                timeVal = '25 min';
                timeChange = '↓ 15% vs. last month';
                ratingChange = '↑ 6% vs. last month';
              }

              return Column(
                children: [
                  _buildKpiReportCard(
                    title: 'Total Orders',
                    value: '$displayOrders',
                    changeText: ordersChange,
                    isPositive: true,
                    icon: Icons.bar_chart_rounded,
                  ),
                  const SizedBox(height: 12),
                  _buildKpiReportCard(
                    title: 'Revenue',
                    value: '₱${displayRevenue.toStringAsFixed(0)}',
                    changeText: revenueChange,
                    isPositive: true,
                    icon: Icons.payments_rounded,
                  ),
                  const SizedBox(height: 12),
                  _buildKpiReportCard(
                    title: 'Avg. Delivery Time',
                    value: timeVal,
                    changeText: timeChange,
                    isPositive: false,
                    icon: Icons.access_time_rounded,
                  ),
                  const SizedBox(height: 12),
                  _buildKpiReportCard(
                    title: 'Customer Rating',
                    value: ratingVal,
                    changeText: ratingChange,
                    isPositive: true,
                    icon: Icons.star_outline_rounded,
                  ),
                ],
              );
            },
          ),
        ],
      ],
    );
  }

  Widget _buildDateDropdownPill() {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedDate,
          icon: Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: widget.brandColor),
          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF334155)),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() => _selectedDate = newValue);
            }
          },
          items: _availableDates.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  Icon(Icons.calendar_today_rounded, size: 14, color: widget.brandColor),
                  const SizedBox(width: 8),
                  Text(value),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildKpiReportCard({
    required String title,
    required String value,
    required String changeText,
    required bool isPositive,
    required IconData icon,
  }) {
    final Color badgeColor = isPositive ? const Color(0xFF10B981) : const Color(0xFFEF4444);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B), fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w900, color: const Color(0xFF0F172A)),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    changeText.split(' ')[0],
                    style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: badgeColor),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    changeText.substring(changeText.indexOf(' ') + 1),
                    style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8), fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          Icon(icon, color: widget.brandColor, size: 24),
        ],
      ),
    );
  }

  Widget _buildDynamicStatusRow({
    required Color dotColor,
    required String label,
    required int count,
    required int total,
  }) {
    final int pct = total > 0 ? ((count / total) * 100).round() : 0;

    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        const Spacer(),
        Text(
          '$count',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 42,
          child: Text(
            '$pct%',
            textAlign: TextAlign.end,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ),
      ],
    );
  }
}

class _CurvedChartPainter extends CustomPainter {
  final List<double> dataPoints;
  final Color lineColor;
  final double maxY;

  _CurvedChartPainter({
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

    final List<String> xLabels = ['8AM', '11AM', '2PM', '5PM', '8PM'];
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
  bool shouldRepaint(covariant _CurvedChartPainter oldDelegate) {
    return oldDelegate.dataPoints != dataPoints || oldDelegate.lineColor != lineColor;
  }
}
