import 'package:flutter/material.dart';

class WhatsAppIcon extends StatelessWidget {
  final double size;
  final Color? color;

  const WhatsAppIcon({
    super.key,
    this.size = 24.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = color ?? const Color(0xFF25D366);
    
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: WhatsAppPainter(color: themeColor),
          ),
          Icon(
            Icons.phone,
            color: Colors.white,
            size: size * 0.55,
          ),
        ],
      ),
    );
  }
}

class WhatsAppPainter extends CustomPainter {
  final Color color;

  WhatsAppPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double w = size.width;
    final double h = size.height;

    final path = Path();
    path.addOval(Rect.fromLTWH(0, 0, w, h));

    final tailPath = Path();
    tailPath.moveTo(w * 0.15, h * 0.85);
    tailPath.lineTo(w * 0.05, h * 0.98);
    tailPath.lineTo(w * 0.25, h * 0.92);
    tailPath.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(tailPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
