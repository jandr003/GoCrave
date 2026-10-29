import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCurvedNavBarItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const CustomCurvedNavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

class CustomCurvedNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int index) onTap;
  final List<CustomCurvedNavBarItem> items;
  final Color brandColor;

  const CustomCurvedNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.brandColor = const Color(0xFFFF5622),
  });

  @override
  State<CustomCurvedNavBar> createState() => _CustomCurvedNavBarState();
}

class _CustomCurvedNavBarState extends State<CustomCurvedNavBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final itemWidth = size.width / widget.items.length;
    final activeX = (widget.currentIndex * itemWidth) + (itemWidth / 2);

    return SizedBox(
      height: 75,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            top: 10,
            child: CustomPaint(
              painter: _CurvedNotchPainter(
                activeX: activeX,
                barColor: Colors.white,
                shadowColor: Colors.black.withOpacity(0.08),
              ),
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            left: activeX - 26,
            top: -10,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: widget.brandColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: widget.brandColor.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                widget.items[widget.currentIndex].activeIcon,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),

          Positioned.fill(
            top: 8,
            child: Row(
              children: List.generate(widget.items.length, (index) {
                final isSelected = widget.currentIndex == index;
                final item = widget.items[index];

                return Expanded(
                  child: InkWell(
                    onTap: () => widget.onTap(index),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: isSelected ? 0.0 : 1.0,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                item.icon,
                                color: const Color(0xFF64748B),
                                size: 20,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                item.label,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _CurvedNotchPainter extends CustomPainter {
  final double activeX;
  final Color barColor;
  final Color shadowColor;

  _CurvedNotchPainter({
    required this.activeX,
    required this.barColor,
    required this.shadowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = barColor
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = shadowColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final path = Path();
    path.moveTo(0, 0);

    final notchWidth = 72.0;
    final halfNotch = notchWidth / 2;

    path.lineTo(activeX - halfNotch - 10, 0);

    path.cubicTo(
      activeX - halfNotch + 5, 0,
      activeX - 25, 28,
      activeX, 28,
    );

    path.cubicTo(
      activeX + 25, 28,
      activeX + halfNotch - 5, 0,
      activeX + halfNotch + 10, 0,
    );

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path.shift(const Offset(0, -2)), shadowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CurvedNotchPainter oldDelegate) {
    return oldDelegate.activeX != activeX ||
        oldDelegate.barColor != barColor ||
        oldDelegate.shadowColor != shadowColor;
  }
}
