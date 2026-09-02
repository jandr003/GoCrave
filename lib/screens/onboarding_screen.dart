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
    // start at a high number for the infinite scroll loop
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
        duration: const Duration(milliseconds: 1200),
        curve: Curves.easeInOutCubic,
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
    // force onboarding to stay for now while testing
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
      backgroundColor: Colors.black,
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

                  // transition settings
                  final double position = index - page;
                  final double opacity = (1.0 - position.abs()).clamp(0.0, 1.0);
                  final double screenWidth = MediaQuery.of(context).size.width;

                  return Transform.translate(
                    offset: Offset(-position * screenWidth, 0),
                    child: Opacity(
                      opacity: opacity,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            _onboardingData[dataIndex]['image']!,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                            alignment: Alignment(position * 0.2, 0.0), // subtler parallax
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white.withOpacity(0.5),
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[900],
                                child: const Icon(Icons.error_outline,
                                    color: Colors.white24, size: 40),
                              );
                            },
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
                      ),
                    ),
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
                              double normalizedPage = _pageController.page! % _onboardingData.length;
                              double distance = (index - normalizedPage).abs();
                              
                              // handle wrap around for infinite scroll
                              if (distance > _onboardingData.length / 2) {
                                distance = (distance - _onboardingData.length).abs();
                              }

                              selectedness = (1.0 - distance).clamp(0.0, 1.0);
                            } else if (index == (_currentPage % _onboardingData.length)) {
                              selectedness = 1.0;
                            }

                            // liquid stretching effect
                            final double dotWidth = 8 + (28 * selectedness);

                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              height: 8,
                              width: dotWidth,
                              decoration: BoxDecoration(
                                color: selectedness > 0.5 
                                  ? Colors.white 
                                  : Colors.white.withOpacity(0.3 + (0.7 * selectedness)),
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
                        'Get Started',
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
