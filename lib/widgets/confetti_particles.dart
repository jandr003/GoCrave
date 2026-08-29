import 'package:flutter/material.dart';
import 'dart:math';

class Particle {
  double x, y;
  double vx, vy;
  double size;
  double life;
  double opacity;
  Color color;
  bool isCircle;

  Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.size,
    required this.color,
    required this.isCircle,
    this.life = 1.0,
    this.opacity = 1.0,
  });

  void update() {
    x += vx;
    y += vy;
    vy += 0.0001; // pull it down
    vx *= 0.98;   // slow it down
    vy *= 0.98;
    life -= 0.005;
    opacity = life.clamp(0.0, 1.0);
  }
}

class ConfettiPainter extends CustomPainter {
  final List<Particle> particles;

  ConfettiPainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      if (particle.life <= 0) continue;
      
      final paint = Paint()..color = particle.color.withOpacity(particle.opacity);
      
      if (particle.isCircle) {
        canvas.drawCircle(
          Offset(particle.x * size.width, particle.y * size.height),
          particle.size / 2,
          paint,
        );
      } else {
        canvas.save();
        canvas.translate(particle.x * size.width, particle.y * size.height);
        canvas.rotate(particle.life * 5); // spin it as it drops
        canvas.drawRect(
          Rect.fromCenter(center: Offset.zero, width: particle.size * 0.5, height: particle.size),
          paint,
        );
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
