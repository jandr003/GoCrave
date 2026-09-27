import 'dart:math';
import 'package:flutter/material.dart';

class GoogleLogoIcon extends StatelessWidget {
  final double size;

  const GoogleLogoIcon({
    super.key,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        size: Size(size, size),
        painter: GoogleLogoPainter(),
      ),
    );
  }
}

class GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double cx = w / 2;
    final double cy = h / 2;
    final double R = w / 2;
    final double r = R * 0.52;

    final Rect outerRect = Rect.fromCircle(center: Offset(cx, cy), radius: R);
    final Rect innerRect = Rect.fromCircle(center: Offset(cx, cy), radius: r);

    final Paint fill = Paint()..style = PaintingStyle.fill;

    void drawSector(double startAngle, double sweepAngle, Color color) {
      fill.color = color;
      final Path path = Path();
      path.arcTo(outerRect, startAngle, sweepAngle, false);
      path.arcTo(innerRect, startAngle + sweepAngle, -sweepAngle, false);
      path.close();
      canvas.drawPath(path, fill);
    }

    drawSector(-pi * 0.88, pi * 0.72, const Color(0xFFEA4335));

    drawSector(pi * 0.68, pi * 0.44, const Color(0xFFFBBC05));

    drawSector(pi * 0.05, pi * 0.63, const Color(0xFF34A853));

    drawSector(-pi * 0.16, pi * 0.21, const Color(0xFF4285F4));

    final double barThickness = R - r;
    fill.color = const Color(0xFF4285F4);
    canvas.drawRect(
      Rect.fromLTWH(cx - w * 0.02, cy - barThickness / 2, R + w * 0.02, barThickness),
      fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
