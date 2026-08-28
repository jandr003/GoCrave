import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentPage < _onboardingData.length - 1) {
        _pageController.animateToPage(
          _currentPage + 1,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutQuart,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutQuart,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Get Fastest Delivery in 30 Minutes 🍕',
      'subtitle': 'Pick your desired food item from the menu there are more than 200 items.',
      'image': 'https://img.freepik.com/free-photo/delicious-pizza-indoors_23-2150873870.jpg',
    },
    {
      'title': 'Fresh Ingredients & Great Taste 🥗',
      'subtitle': 'We only use the freshest ingredients to ensure the best quality for your cravings.',
      'image': 'https://img.freepik.com/free-photo/fresh-salad-with-vegetables-meat_23-2148515516.jpg',
    },
    {
      'title': 'Easy Tracking & Live Status 🛵',
      'subtitle': 'Track your order in real-time and get notified at every step of the delivery.',
      'image': 'https://img.freepik.com/free-photo/delivery-man-scooter-delivering-food_23-2149103444.jpg',
    },
  ];

  void _onFinish() async {
    // Commented out for development so onboarding always shows
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('isFirstTime', false);
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              return PageView.builder(
                controller: _pageController,
                itemCount: _onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                  _startTimer();
                },
                itemBuilder: (context, index) {
                  double page = 0.0;
                  if (_pageController.hasClients && _pageController.page != null) {
                    page = _pageController.page!;
                  }
                  
                  // Parallax effect: offset the image slightly opposite to the scroll
                  double parallaxOffset = (index - page) * 100;

                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRect(
                        child: Transform.translate(
                          offset: Offset(parallaxOffset, 0),
                          child: Image.network(
                            _onboardingData[index]['image']!,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                            alignment: Alignment( (index - page) * 0.5, 0),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.8),
                            ],
                            stops: const [0.5, 1.0],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Column(
                      key: ValueKey<int>(_currentPage),
                      children: [
                        Text(
                          _onboardingData[_currentPage]['title']!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _onboardingData[_currentPage]['subtitle']!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _onboardingData.length,
                          (index) {
                            double selectedness = 0.0;
                            if (_pageController.hasClients && _pageController.page != null) {
                              selectedness = (1.0 - (index - _pageController.page!).abs()).clamp(0.0, 1.0);
                            } else if (index == _currentPage) {
                              selectedness = 1.0;
                            }

                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              height: 8,
                              width: 8 + (16 * selectedness),
                              decoration: BoxDecoration(
                                color: Color.lerp(Colors.white38, Colors.white, selectedness),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _onFinish,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Text(
                        'Click To Start',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
