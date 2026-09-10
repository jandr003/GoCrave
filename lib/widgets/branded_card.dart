import 'package:flutter/material.dart';

class BrandedCard extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final Color baseColor;
  final double borderRadius;

  const BrandedCard({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(24),
    this.baseColor = const Color(0xFFFF5622),
    this.borderRadius = 32.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: baseColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _WavyPatternPainter(
                  color: Colors.white.withOpacity(0.15), // Increased from 0.08 for better visibility
                ),
              ),
            ),
            if (child != null)
              Padding(
                padding: padding,
                child: child!,
              ),
          ],
        ),
      ),
    );
  }
}

class _WavyPatternPainter extends CustomPainter {
  final Color color;

  _WavyPatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path1 = Path();
    path1.moveTo(size.width * 0.6, 0);
    path1.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.2,
      size.width,
      size.height * 0.1,
    );
    path1.lineTo(size.width, 0);
    path1.close();
    canvas.drawPath(path1, paint);

    final path2 = Path();
    path2.moveTo(size.width * 0.3, 0);
    path2.cubicTo(
      size.width * 0.45,
      size.height * 0.4,
      size.width * 0.6,
      size.height * 0.1,
      size.width * 0.8,
      size.height * 0.6,
    );
    path2.cubicTo(
      size.width * 0.9,
      size.height * 0.9,
      size.width * 0.5,
      size.height * 0.8,
      size.width * 0.4,
      size.height,
    );
    path2.lineTo(0, size.height);
    path2.lineTo(0, 0);
    path2.close();
    
    final paint2 = Paint()
      ..color = color.withOpacity(color.opacity * 0.8)
      ..style = PaintingStyle.fill;
      
    canvas.drawPath(path2, paint2);
    
    final path3 = Path();
    path3.moveTo(0, size.height * 0.7);
    path3.quadraticBezierTo(
      size.width * 0.15,
      size.height * 0.85,
      size.width * 0.1,
      size.height,
    );
    path3.lineTo(0, size.height);
    path3.close();
    canvas.drawPath(path3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
