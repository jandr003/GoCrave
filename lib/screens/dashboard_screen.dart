import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'browse_menu_screen.dart';
import 'category_detail_screen.dart';
import '../widgets/food_card.dart';
import '../data/food_data.dart';
import '../data/location_manager.dart';
import '../data/user_profile.dart';
import '../data/coin_manager.dart';
import '../data/cart_manager.dart';
import '../data/promo_manager.dart';
import '../widgets/daily_reward_modal.dart';
import '../widgets/dashboard/dashboard_header.dart';
import '../widgets/dashboard/dashboard_promo_carousel.dart';
import '../widgets/dashboard/dashboard_category_list.dart';
import 'chat_list_screen.dart';
import 'favorites_screen.dart';
import 'cart_screen.dart';

class DashboardScreen extends StatefulWidget {
  final VoidCallback onSearchTap;
  const DashboardScreen({
    super.key,
    required this.onSearchTap,
  });

  @override
  State<DashboardScreen> createState() {
    return _DashboardScreenState();
  }
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final PageController _promoController;
  Timer? _promoTimer;
  int _currentPromoPage = 0;

  @override
  void initState() {
    super.initState();
    _promoController = PageController(initialPage: 0);
    _startPromoTimer();
    LocationManager().addListener(_updateState);
    UserProfile().addListener(_updateState);
    CoinManager().addListener(_updateState);
    CartManager().addListener(_updateState);
    PromoManager().addListener(_updateState);
  }

  void _updateState() {
    if (mounted) {
      setState(() {
        
      });
    }
  }

  void _startPromoTimer() {
    _promoTimer?.cancel();
    _promoTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_promoController.hasClients) {
        final promos = _dynamicPromoData;
        if (promos.isNotEmpty) {
          final nextPage = (_currentPromoPage + 1) % promos.length;
          _promoController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOutCubic,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _promoTimer?.cancel();
    _promoController.dispose();
    LocationManager().removeListener(_updateState);
    UserProfile().removeListener(_updateState);
    CoinManager().removeListener(_updateState);
    CartManager().removeListener(_updateState);
    PromoManager().removeListener(_updateState);
    super.dispose();
  }

  List<Map<String, String>> get _dynamicPromoData {
    final active = PromoManager().activeVouchers;
    if (active.isNotEmpty) {
      return active.map((v) {
        return {
          'title': v['code']?.toString() ?? 'Promo',
          'subtitle': v['save']?.toString() ?? v['desc']?.toString() ?? '',
          'image': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=600&auto=format&fit=crop',
          'category': 'All',
        };
      }).toList();
    }
    return allFoodItems.take(4).map((item) {
      return {
        'title': item['title'] ?? 'Special Offer',
        'subtitle': item['subtitle'] ?? 'Discount applied at checkout',
        'image': item['image'] ?? 'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=600&auto=format&fit=crop',
        'category': item['category'] ?? 'Fast Food',
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final promoData = _dynamicPromoData;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                DashboardHeader(
                  onSearchTap: widget.onSearchTap,
                ),
                const SizedBox(height: 32),
                DashboardPromoCarousel(
                  promoController: _promoController,
                  currentPromoPage: _currentPromoPage,
                  promoData: promoData,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPromoPage = index;
                    });
                  },
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const BrowseMenuScreen(showBackButton: true);
                            },
                          ),
                        );
                      },
                      child: Text(
                        'See All',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const DashboardCategoryList(),
                const SizedBox(height: 32),
                Text(
                  'Explore More Cravings',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                ...allFoodItems.map((item) {
                  return FoodCard(foodItem: item);
                }).toList(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
