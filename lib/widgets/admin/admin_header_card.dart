import 'dart:math' as math;
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
  int _selectedSalesFilterIndex = 0;
  final List<String> _salesFilters = ['Last 7 Days', 'This Month', 'This Year'];

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
                    Row(
                      children: [
                        Text(
                          'Good morning, Admin',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text('👋', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Here\'s what\'s happening with your GoCrave platform today.',
                      style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600]),
                      maxLines: 2,
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

        SizedBox(
          height: 122,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildGradientKpiCard(
                title: 'Total Orders',
                value: '128',
                rate: '↗ +12%',
                icon: Icons.shopping_bag_rounded,
                bgGradient: const LinearGradient(
                  colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                accentColor: widget.brandColor,
              ),
              const SizedBox(width: 10),
              _buildGradientKpiCard(
                title: 'Active Riders',
                value: '24',
                rate: '↗ +8%',
                icon: Icons.two_wheeler_rounded,
                bgGradient: const LinearGradient(
                  colors: [Color(0xFFE0F2FE), Color(0xFFBAE6FD)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                accentColor: const Color(0xFF0284C7),
              ),
              const SizedBox(width: 10),
              _buildGradientKpiCard(
                title: 'Restaurants',
                value: '86',
                rate: '↗ +5%',
                icon: Icons.storefront_rounded,
                bgGradient: const LinearGradient(
                  colors: [Color(0xFFDCFCE7), Color(0xFFBBF7D0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                accentColor: const Color(0xFF16A34A),
              ),
              const SizedBox(width: 10),
              _buildGradientKpiCard(
                title: 'Customers',
                value: '12.5K',
                rate: '↗ +7%',
                icon: Icons.group_rounded,
                bgGradient: const LinearGradient(
                  colors: [Color(0xFFF3E8FF), Color(0xFFE9D5FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                accentColor: const Color(0xFF9333EA),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFEEEEEE)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.bar_chart_rounded, color: widget.brandColor, size: 18),
                            const SizedBox(width: 6),
                            Text(
                              'Sales Overview',
                              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                            ),
                          ],
                        ),
                        Text(
                          'Total sales in the last 7 days',
                          style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                        ),
                      ],
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: _selectedSalesFilterIndex,
                        dropdownColor: Colors.white,
                        icon: Icon(Icons.keyboard_arrow_down_rounded, color: widget.brandColor, size: 18),
                        style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedSalesFilterIndex = val);
                        },
                        items: List.generate(_salesFilters.length, (idx) {
                          return DropdownMenuItem(
                            value: idx,
                            child: Text(_salesFilters[idx]),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Text(
                      '₱48,750',
                      style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w900, color: const Color(0xFF0F172A)),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.trending_up_rounded, color: Color(0xFF10B981), size: 12),
                          const SizedBox(width: 2),
                          Text(
                            '+14%',
                            style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF10B981)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: 130,
                  child: CustomPaint(
                    size: const Size(double.infinity, 130),
                    painter: _BezierSalesChartPainter(brandColor: widget.brandColor),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: CustomPaint(
                          painter: _DonutChartPainter(
                            completedPct: 0.68,
                            inProgressPct: 0.20,
                            pendingPct: 0.12,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('68%', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w900, color: const Color(0xFF0F172A))),
                                Text('Completed', style: GoogleFonts.poppins(fontSize: 7, color: const Color(0xFF64748B))),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLegendItem('Completed', widget.brandColor),
                            const SizedBox(height: 4),
                            _buildLegendItem('In Progress', const Color(0xFF2563EB)),
                            const SizedBox(height: 4),
                            _buildLegendItem('Pending', const Color(0xFF94A3B8)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 18),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(18),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Rider Activity', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                    InkWell(
                      onTap: widget.onTapManageRiders,
                      child: Text('View All →', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: widget.brandColor)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildRiderActivityRow('Miguel Reyes', 'Available', const Color(0xFF10B981), null),
                const Divider(height: 16, color: Color(0xFFF1F5F9)),
                _buildRiderActivityRow('Juan Dela Cruz', 'On Delivery', const Color(0xFF2563EB), '#1247'),
                const Divider(height: 16, color: Color(0xFFF1F5F9)),
                _buildRiderActivityRow('Adrian Cruz', 'Pending Review', const Color(0xFFD97706), null),
              ],
            ),
          ),
        ),

        const SizedBox(height: 18),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(18),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.assignment_outlined, color: widget.brandColor, size: 18),
                        const SizedBox(width: 6),
                        Text('Recent Orders', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                      ],
                    ),
                    InkWell(
                      onTap: widget.onTapManageOrders,
                      child: Text('View All →', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: widget.brandColor)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildRecentOrderRow('#GC-0000128', 'Maria Santos', 'KFC', 'In Progress', const Color(0xFF2563EB), const Color(0xFFEFF6FF), '₱320', '2m ago'),
                const Divider(height: 16, color: Color(0xFFF1F5F9)),
                _buildRecentOrderRow('#GC-0000127', 'Juan Dela Cruz', 'McDonald\'s', 'Pending', const Color(0xFFEF4444), const Color(0xFFFEF2F2), '₱249', '5m ago'),
                const Divider(height: 16, color: Color(0xFFF1F5F9)),
                _buildRecentOrderRow('#GC-0000126', 'Ana Reyes', 'Jollibee', 'Completed', const Color(0xFF10B981), const Color(0xFFECFDF5), '₱185', '8m ago'),
                const Divider(height: 16, color: Color(0xFFF1F5F9)),
                _buildRecentOrderRow('#GC-0000125', 'Mark Castillo', 'Shake Shack', 'On Delivery', const Color(0xFF2563EB), const Color(0xFFEFF6FF), '₱265', '12m ago'),
              ],
            ),
          ),
        ),

        const SizedBox(height: 18),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [widget.brandColor, const Color(0xFFFF7043)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(color: widget.brandColor.withOpacity(0.35), blurRadius: 12, offset: const Offset(0, 4)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.bolt_rounded, color: Colors.white, size: 22),
                    const SizedBox(width: 6),
                    Text('Quick Actions', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
                Text('Manage your platform efficiently.', style: GoogleFonts.poppins(fontSize: 11, color: Colors.white.withOpacity(0.9))),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1.6,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _buildQuickActionGridCard('Register Rider', Icons.person_add_alt_1_rounded, widget.onTapManageRiders),
                    _buildQuickActionGridCard('Add Restaurant', Icons.storefront_rounded, widget.onTapManageOrders),
                    _buildQuickActionGridCard('View Reports', Icons.bar_chart_rounded, widget.onTapManageOrders),
                    _buildQuickActionGridCard('Settings', Icons.settings_rounded, widget.onTapManageOrders),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 18),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: const Color(0xFFEEEEEE)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order Status', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          SizedBox(
                            width: 56,
                            height: 56,
                            child: CustomPaint(
                              painter: _DonutChartPainter(completedPct: 0.56, inProgressPct: 0.30, pendingPct: 0.14),
                              child: Center(
                                child: Text('128', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSmallStatusRow('Completed', '72 (56%)', const Color(0xFF10B981)),
                                _buildSmallStatusRow('In Progress', '38 (30%)', const Color(0xFF2563EB)),
                                _buildSmallStatusRow('Pending', '18 (14%)', const Color(0xFFEF4444)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFA7F3D0)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle),
                  child: const Icon(Icons.check_rounded, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('All Systems Operational', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF065F46))),
                      Text('Last updated: Apr 26, 2025 • 10:42 AM', style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF047857))),
                    ],
                  ),
                ),
                Icon(Icons.restaurant_rounded, color: const Color(0xFF10B981).withOpacity(0.5), size: 28),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildGradientKpiCard({
    required String title,
    required String value,
    required String rate,
    required IconData icon,
    required LinearGradient bgGradient,
    required Color accentColor,
  }) {
    return Container(
      width: 122,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: bgGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: accentColor.withOpacity(0.15), blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.8), shape: BoxShape.circle),
            child: Icon(icon, color: accentColor, size: 16),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w900, color: const Color(0xFF0F172A))),
              Text(title, style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF475569)), maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(rate, style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: accentColor)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF475569))),
      ],
    );
  }

  Widget _buildRiderActivityRow(String name, String status, Color statusColor, String? tag) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: widget.brandColor.withOpacity(0.12),
          child: Text(name[0], style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: widget.brandColor)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
              Row(
                children: [
                  Container(width: 6, height: 6, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  Text(status, style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: statusColor)),
                ],
              ),
            ],
          ),
        ),
        if (tag != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: const Color(0xFFFFF3E0), borderRadius: BorderRadius.circular(6)),
            child: Text(tag, style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: widget.brandColor)),
          )
        else
          const Icon(Icons.chevron_right_rounded, color: Colors.grey, size: 18),
      ],
    );
  }

  Widget _buildRecentOrderRow(String id, String customer, String restaurant, String status, Color statusColor, Color statusBg, String price, String time) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(id, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(6)),
                    child: Text(status, style: GoogleFonts.poppins(fontSize: 9, fontWeight: FontWeight.bold, color: statusColor)),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text('$customer • $restaurant', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)), maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(price, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w900, color: const Color(0xFF0F172A))),
            Text(time, style: GoogleFonts.poppins(fontSize: 9, color: const Color(0xFF94A3B8))),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionGridCard(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: widget.brandColor, size: 20),
            const SizedBox(height: 4),
            Text(title, textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallStatusRow(String label, String val, Color color) {
    return Row(
      children: [
        Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Expanded(
          child: Text(label, style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF64748B))),
        ),
        Text(val, style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
      ],
    );
  }
}

class _BezierSalesChartPainter extends CustomPainter {
  final Color brandColor;

  _BezierSalesChartPainter({required this.brandColor});

  @override
  void paint(Canvas canvas, Size size) {
    final points = [
      Offset(0, size.height * 0.7),
      Offset(size.width * 0.16, size.height * 0.55),
      Offset(size.width * 0.33, size.height * 0.4),
      Offset(size.width * 0.5, size.height * 0.5),
      Offset(size.width * 0.66, size.height * 0.2),
      Offset(size.width * 0.83, size.height * 0.3),
      Offset(size.width, size.height * 0.1),
    ];

    final fillPath = Path();
    fillPath.moveTo(points[0].dx, points[0].dy);
    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final controlPoint1 = Offset(p1.dx + (p2.dx - p1.dx) / 2, p1.dy);
      final controlPoint2 = Offset(p1.dx + (p2.dx - p1.dx) / 2, p2.dy);
      fillPath.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx, controlPoint2.dy, p2.dx, p2.dy);
    }
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    final fillGradient = LinearGradient(
      colors: [brandColor.withOpacity(0.4), brandColor.withOpacity(0.0)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    canvas.drawPath(
      fillPath,
      Paint()..shader = fillGradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );

    final linePath = Path();
    linePath.moveTo(points[0].dx, points[0].dy);
    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final controlPoint1 = Offset(p1.dx + (p2.dx - p1.dx) / 2, p1.dy);
      final controlPoint2 = Offset(p1.dx + (p2.dx - p1.dx) / 2, p2.dy);
      linePath.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx, controlPoint2.dy, p2.dx, p2.dy);
    }

    final linePaint = Paint()
      ..color = brandColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawPath(linePath, linePaint);

    for (var pt in points) {
      canvas.drawCircle(pt, 4, Paint()..color = Colors.white);
      canvas.drawCircle(pt, 2, Paint()..color = brandColor);
    }
  }

  @override
  bool shouldRepaint(covariant _BezierSalesChartPainter oldDelegate) => false;
}

class _DonutChartPainter extends CustomPainter {
  final double completedPct;
  final double inProgressPct;
  final double pendingPct;

  _DonutChartPainter({
    required this.completedPct,
    required this.inProgressPct,
    required this.pendingPct,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 4;
    final strokeWidth = 8.0;

    final rect = Rect.fromCircle(center: center, radius: radius);

    double startAngle = -math.pi / 2;

    final completedAngle = completedPct * 2 * math.pi;
    canvas.drawArc(rect, startAngle, completedAngle, false, Paint()..color = const Color(0xFFFF5622)..style = PaintingStyle.stroke..strokeWidth = strokeWidth..strokeCap = StrokeCap.round);
    startAngle += completedAngle;

    final inProgressAngle = inProgressPct * 2 * math.pi;
    canvas.drawArc(rect, startAngle, inProgressAngle, false, Paint()..color = const Color(0xFF2563EB)..style = PaintingStyle.stroke..strokeWidth = strokeWidth..strokeCap = StrokeCap.round);
    startAngle += inProgressAngle;

    final pendingAngle = pendingPct * 2 * math.pi;
    canvas.drawArc(rect, startAngle, pendingAngle, false, Paint()..color = const Color(0xFF94A3B8)..style = PaintingStyle.stroke..strokeWidth = strokeWidth..strokeCap = StrokeCap.round);
  }

  @override
  bool shouldRepaint(covariant _DonutChartPainter oldDelegate) => false;
}
