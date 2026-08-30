import 'dart:async';
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
  
  // sequence of animations
  late Animation<double> _iconFadeAnimation;
  late Animation<double> _textRevealAnimation;
  late Animation<double> _textFadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // splash timing
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // show icon
    _iconFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    // icon slides left while name reveals
    _textRevealAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.9, curve: Curves.easeInOutQuart),
      ),
    );

    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.6, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
    _startTransitionTimer();
  }

  void _startTransitionTimer() {
    // wait for sequence and go to next
    Timer(const Duration(milliseconds: 3500), () {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // icon
                Opacity(
                  opacity: _iconFadeAnimation.value,
                  child: Image.asset(
                    'assets/images/gocrave_app_logo.png',
                    width: 70, // icon size as per youtube style proportions
                    height: 70,
                    fit: BoxFit.contain,
                  ),
                ),
                
                // typed reveal
                // icon slides left
                ClipRect(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: _textRevealAnimation.value,
                    child: Opacity(
                      opacity: _textFadeAnimation.value,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Image.asset(
                          'assets/images/gocrave_official_logo.png',
                          width: 160,
                          height: 60,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
