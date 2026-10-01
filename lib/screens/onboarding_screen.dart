import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int _currentPage = 0;
  int _foodImageIndex = 0;
  Timer? _foodFadeTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _startFoodFadeTimer();
  }

  void _startFoodFadeTimer() {
    _foodFadeTimer?.cancel();
    _foodFadeTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _foodImageIndex = (_foodImageIndex + 1) % 3;
        });
      }
    });
  }

  @override
  void dispose() {
    _foodFadeTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _onboardingData = [
    {
      'category': '🍔 FAST FOOD',
      'title': 'Juicy Burgers & Crispy Pizzas',
      'subtitle': 'Savor flame-grilled beef burgers, New York pizzas, and hot golden fries.',
      'images': [
        'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=1000&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=1000&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1561758033-d89a9ad46330?q=80&w=1000&auto=format&fit=crop',
      ],
    },
    {
      'category': '🍲 HOME-STYLE',
      'title': 'Hearty Filipino Home Favorites',
      'subtitle': 'Tender chicken adobo, sour pork sinigang, and warm comfort meals.',
      'images': [
        'https://images.unsplash.com/photo-1547592166-23ac45744acd?q=80&w=1000&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1625398407796-82650a8c135f?q=80&w=1000&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1606787366850-de6330128bfc?q=80&w=1000&auto=format&fit=crop',
      ],
    },
    {
      'category': '🥗 VEGETARIAN',
      'title': 'Fresh & Nutritious Green Bowls',
      'subtitle': 'Organic quinoa salad bowls and fresh garden greens made for a healthier you.',
      'images': [
        'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=1000&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1540420773420-3366772f4999?q=80&w=1000&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=1000&auto=format&fit=crop',
      ],
    },
    {
      'category': '🍟 SNACKS',
      'title': 'Crispy Nachos & Street Bites',
      'subtitle': 'Loaded cheesy nachos supreme, street bites, and mid-day snacks.',
      'images': [
        'https://images.unsplash.com/photo-1513456852971-30c0b8199d4d?q=80&w=1000&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1566478989037-eec170784d0b?q=80&w=1000&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1585325701165-351af916e581?q=80&w=1000&auto=format&fit=crop',
      ],
    },
    {
      'category': '🍰 DESSERTS',
      'title': 'Sweet Cravings & Decadent Cakes',
      'subtitle': 'Molten chocolate lava cakes, berry ice cream gelato, and gourmet sweets.',
      'images': [
        'https://images.unsplash.com/photo-1565958011703-44f9829ba187?q=80&w=1000&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1578985545062-69928b1d9587?q=80&w=1000&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1551024709-8f23befc6f87?q=80&w=1000&auto=format&fit=crop',
      ],
    },
    {
      'category': '🥤 DRINKS & SHAKES',
      'title': 'Refreshingly Cool Shakes & Teas',
      'subtitle': 'Sweet mango graham shakes, chilled fruit juices, and boba milk teas.',
      'images': [
        'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?q=80&w=1000&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1572490122747-3968b75cc699?q=80&w=1000&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1551024709-8f23befc6f87?q=80&w=1000&auto=format&fit=crop',
      ],
    },
  ];

  void _onFinish() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            );
            return FadeTransition(
              opacity: curvedAnimation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.08),
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: child,
              ),
            );
          },
        ),
      );
    }
  }

  void _onPrimaryButtonPressed() {
    final currentSlideIndex = _currentPage % _onboardingData.length;
    final isLastSlide = currentSlideIndex == _onboardingData.length - 1;

    if (isLastSlide) {
      _onFinish();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 900),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentSlideIndex = _currentPage % _onboardingData.length;
    final isLastSlide = currentSlideIndex == _onboardingData.length - 1;
    final categoryData = _onboardingData[currentSlideIndex];
    final List<String> currentCategoryImages = List<String>.from(categoryData['images']);
    final activeImageUrl = currentCategoryImages[_foodImageIndex % currentCategoryImages.length];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
                _foodImageIndex = 0;
              });
            },
            itemBuilder: (context, index) {
              final slideData = _onboardingData[index];
              final List<String> images = List<String>.from(slideData['images']);
              final imgUrl = (index == currentSlideIndex)
                  ? activeImageUrl
                  : images[0];

              return Stack(
                fit: StackFit.expand,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 1000),
                    child: Image.network(
                      imgUrl,
                      key: ValueKey<String>(imgUrl),
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(color: Colors.grey[900]);
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.35),
                          Colors.black.withOpacity(0.88),
                        ],
                        stops: const [0.2, 1.0],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: _onFinish,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Skip',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: Container(
                      key: ValueKey<String>(categoryData['category']),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF5622),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF5622).withOpacity(0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        categoryData['category'],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Column(
                      key: ValueKey<int>(currentSlideIndex),
                      children: [
                        Text(
                          categoryData['title'],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          categoryData['subtitle'],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white70,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingData.length,
                      (index) {
                        final isSelected = index == currentSlideIndex;
                        final double dotWidth = isSelected ? 32 : 8;

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: dotWidth,
                          decoration: BoxDecoration(
                            color: isSelected 
                              ? const Color(0xFFFF5622)
                              : Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 36),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _onPrimaryButtonPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isLastSlide ? const Color(0xFFFF5622) : Colors.white,
                        foregroundColor: isLastSlide ? Colors.white : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: isLastSlide ? 8 : 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isLastSlide ? 'Get Started' : 'Next',
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 20,
                            color: isLastSlide ? Colors.white : Colors.black,
                          ),
                        ],
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
