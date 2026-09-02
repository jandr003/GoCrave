import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_screen.dart';
import 'login_screen.dart';
import 'main_nav_wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // timing settings
  late Animation<double> _iconPopScale;
  late Animation<double> _iconPopFade;
  late Animation<double> _circleReveal;
  late Animation<double> _finalLogoReveal;
  late Animation<double> _finalLogoFade;

  double _maxScreenRadius = 0;
  late final List<Widget> _staticImages;

  @override
  void initState() {
    super.initState();

    _staticImages = [
      Image.asset(
        'assets/images/gocrave_app_logo.png',
        width: 140,
        height: 140,
        fit: BoxFit.contain,
        key: const ValueKey('logo_pop'),
      ),
      Image.asset(
        'assets/images/gocrave_app_logo.png',
        width: 100, // app icon size
        height: 100,
        fit: BoxFit.contain,
        key: const ValueKey('logo_final_icon'),
      ),
      Image.asset(
        'assets/images/gocrave_official_logo.png',
        width: 600, // even bigger official wordmark
        height: 200,
        fit: BoxFit.contain,
        key: const ValueKey('logo_final_text'),
      ),
    ];

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    // icon pop reveal
    _iconPopFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.2, curve: Curves.easeIn),
      ),
    );
    _iconPopScale = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOutBack),
      ),
    );

    // orange boom effect
    _circleReveal = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.35, 0.6, curve: Curves.easeInOutQuart),
      ),
    );

    // horizontal reveal
    _finalLogoReveal = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.65, 0.9, curve: Curves.easeInOutQuart),
      ),
    );
    _finalLogoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.65, 0.75, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
    _startTransitionTimer();
  }

  void _startTransitionTimer() {
    // wait for sequence and go to next screen
    Timer(const Duration(milliseconds: 6500), () {
      _checkPersistence();
    });
  }

  Future<void> _checkPersistence() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!mounted) return;

    if (isFirstTime) {
      _navigate(const OnboardingScreen());
    } else if (isLoggedIn) {
      _navigate(const MainNavWrapper());
    } else {
      _navigate(const LoginScreen());
    }
  }

  void _navigate(Widget screen) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, anim, secondaryAnim) => screen,
        transitionsBuilder: (context, anim, secondaryAnim, child) {
          return FadeTransition(opacity: anim, child: child);
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const orangeColor = Color(0xFFFF5622);

    if (_maxScreenRadius == 0) {
      final size = MediaQuery.of(context).size;
      _maxScreenRadius = sqrt(size.width * size.width + size.height * size.height);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // orange circle expansion
          RepaintBoundary(
            child: AnimatedBuilder(
              animation: _circleReveal,
              builder: (context, child) {
                return CustomPaint(
                  painter: CircleRevealPainter(
                    progress: _circleReveal.value,
                    color: orangeColor,
                    maxRadius: _maxScreenRadius,
                  ),
                  size: Size.infinite,
                );
              },
            ),
          ),

          // center part
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final isOrangeBg = _circleReveal.value > 0.8;
                final reveal = _finalLogoReveal.value;

                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // initial icon pop
                    if (!isOrangeBg)
                      Opacity(
                        opacity: _iconPopFade.value,
                        child: Transform.scale(
                          scale: _iconPopScale.value,
                          child: _staticImages[0],
                        ),
                      ),

                    // perfectly centered horizontal lockup
                    if (isOrangeBg)
                      Opacity(
                        opacity: _finalLogoFade.value,
                        child: ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                          child: ClipRect(
                            child: Align(
                              alignment: Alignment.center,
                              widthFactor: reveal,
                              child: _staticImages[2],
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CircleRevealPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double maxRadius;

  CircleRevealPainter({
    required this.progress,
    required this.color,
    required this.maxRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = maxRadius * progress;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(CircleRevealPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
