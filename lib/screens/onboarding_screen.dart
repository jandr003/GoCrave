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
  late final PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start at a high page number for seamless infinite scroll
    const initialPage = 6 * 500;
    _pageController = PageController(initialPage: initialPage);
    _currentPage = initialPage;
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      _pageController.animateToPage(
        _pageController.page!.toInt() + 1,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutQuart,
      );
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
      'title': 'Quick & Tasty Meals 🍔',
      'subtitle': 'Crispy burgers and fries delivered to your doorstep.',
      'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=1000&auto=format&fit=crop',
    },
    {
      'title': 'Taste of Home 🍲',
      'subtitle': 'Hearty home-cooked meals and warm flavors for the family.',
      'image': 'https://images.unsplash.com/photo-1606787366850-de6330128bfc?q=80&w=1000&auto=format&fit=crop',
    },
    {
      'title': 'Healthy & Fresh 🥗',
      'subtitle': 'Nutritious green bowls and salads for a better you.',
      'image': 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=1000&auto=format&fit=crop',
    },
    {
      'title': 'Perfect Mid-day Bites 🍟',
      'subtitle': 'Street foods and quick snacks to fuel your day.',
      'image': 'https://images.unsplash.com/photo-1566478989037-eec170784d0b?q=80&w=1000&auto=format&fit=crop',
    },
    {
      'title': 'Sweet Cravings Satisfied 🍰',
      'subtitle': 'Cakes, ice cream, and sweets to end your meal right.',
      'image': 'https://images.unsplash.com/photo-1565958011703-44f9829ba187?q=80&w=1000&auto=format&fit=crop',
    },
    {
      'title': 'Refreshingly Cool 🥤',
      'subtitle': 'Shakes, juices, and milk teas for a perfect break.',
      'image': 'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?q=80&w=1000&auto=format&fit=crop',
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
                itemCount: 10000,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                  _startTimer();
                },
                itemBuilder: (context, index) {
                  final dataIndex = index % _onboardingData.length;
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
                            _onboardingData[dataIndex]['image']!,
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
                      key: ValueKey<int>(_currentPage % _onboardingData.length),
                      children: [
                        Text(
                          _onboardingData[_currentPage % _onboardingData.length]['title']!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _onboardingData[_currentPage % _onboardingData.length]['subtitle']!,
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
                              // Modulo the current page to match dots
                              double normalizedPage = _pageController.page! % _onboardingData.length;
                              selectedness = (1.0 - (index - normalizedPage).abs()).clamp(0.0, 1.0);
                              
                              // Handle wrap-around selectedness for dots
                              double altSelectedness = (1.0 - (index - (normalizedPage - _onboardingData.length)).abs()).clamp(0.0, 1.0);
                              selectedness = selectedness > altSelectedness ? selectedness : altSelectedness;

                            } else if (index == (_currentPage % _onboardingData.length)) {
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
