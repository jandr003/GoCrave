import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'confetti_particles.dart';

class SuccessTransitionOverlay extends StatefulWidget {
  final VoidCallback onContinue;

  const SuccessTransitionOverlay({
    super.key,
    required this.onContinue,
  });

  @override
  State<SuccessTransitionOverlay> createState() => _SuccessTransitionOverlayState();
}

class _SuccessTransitionOverlayState extends State<SuccessTransitionOverlay>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _particleController;
  final List<Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    
    // breathing animation
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    // particle physics
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..forward();

    // start the burst
    _initializeBurst();
  }

  void _initializeBurst() {
    _particles.clear();
    for (int i = 0; i < 60; i++) {
      final angle = _random.nextDouble() * 2 * pi;
      final speed = 0.005 + _random.nextDouble() * 0.02;
      _particles.add(Particle(
        x: 0.5, // center x
        y: 0.45, // center y
        vx: cos(angle) * speed,
        vy: sin(angle) * speed,
        size: 8 + _random.nextDouble() * 12,
        color: [
          const Color(0xFFFF5622),
          const Color(0xFFFF9800),
          Colors.grey.withOpacity(0.5),
          const Color(0xFF4CAF50),
        ][_random.nextInt(4)],
        isCircle: _random.nextBool(),
      ));
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          // explosion effect
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _particleController,
              builder: (context, child) {
                for (var particle in _particles) {
                  particle.update();
                }
                return CustomPaint(
                  painter: ConfettiPainter(particles: _particles),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  // breathing checkmark
                  ScaleTransition(
                    scale: Tween<double>(begin: 0.95, end: 1.1).animate(
                      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
                    ),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF5622).withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF5622),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  Text(
                    'Verification Success',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFFFF5622),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'When you have completed your verification. You just need to click the button below to find out the food courier automatically.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[500],
                      height: 1.5,
                    ),
                  ),
                  const Spacer(flex: 3),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: widget.onContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF5622),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Find Your Food Courier',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
