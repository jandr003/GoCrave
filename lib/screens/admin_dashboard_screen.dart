import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/food_data.dart';
import '../data/order_manager.dart';
import 'login_screen.dart';
import 'admin_settings_screen.dart';
import 'admin_notifications_screen.dart';
import '../widgets/admin/admin_header_card.dart';
import '../widgets/admin/admin_orders_tab.dart';
import '../widgets/admin/admin_riders_tab.dart';
import '../widgets/admin/admin_reports_tab.dart';
import '../widgets/admin/custom_curved_nav_bar.dart';

class AdminDashboardScreen extends StatefulWidget {
  final String adminEmail;
  const AdminDashboardScreen({super.key, this.adminEmail = 'Admin01'});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedTab = 0;
  final Color brandColor = const Color(0xFFFF5622);
  String _adminAvatarUrl = 'https://api.dicebear.com/7.x/avataaars/png?seed=AdminGoCrave&backgroundColor=ff5622';

  final Map<String, bool> _foodStockStatus = {
    for (var item in allFoodItems) item['title']!: true,
  };

  @override
  void initState() {
    super.initState();
    OrderManager().addListener(_updateState);
  }

  @override
  void dispose() {
    OrderManager().removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    if (mounted) {
      setState(() {
        
      });
    }
  }

  void _showAddFoodModal(BuildContext context) {
    final titleController = TextEditingController();
    final priceController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add New Food Item', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Food Title (e.g. Sizzling Sisig)'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Price (e.g. ₱195.00)'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty) {
                      setState(() {
                        allFoodItems.add({
                          'title': titleController.text,
                          'subtitle': 'New Admin Creation',
                          'price': priceController.text.contains('₱') ? priceController.text : '₱${priceController.text}',
                          'rating': '5.0',
                          'category': 'Home-Style',
                          'image': 'https://images.unsplash.com/photo-1547592166-23ac45744acd?q=80&w=500&auto=format&fit=crop',
                          'ingredients': '🥩,🧅,🧄',
                          'time': '15 Min',
                          'spice': 'Mild',
                          'kcal': '400 Kcal',
                          'longDescription': 'Freshly added menu item by GoCrave Admin.',
                        });
                        _foodStockStatus[titleController.text] = true;
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${titleController.text} added to menu!'),
                          backgroundColor: brandColor,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: brandColor),
                  child: const Text('Add to Menu', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: brandColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleSpacing: 18,
        title: Row(
          children: [
            Image.asset(
              'assets/images/gocrave_app_logo.png',
              height: 38,
              fit: BoxFit.contain,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Transform.translate(
              offset: const Offset(-16, 0),
              child: Transform.scale(
                scale: 2.3,
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/images/gocrave_official_logo.png',
                  height: 32,
                  fit: BoxFit.contain,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_none_rounded, color: Colors.white, size: 22),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            tooltip: 'Notifications',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const AdminNotificationsScreen();
                  },
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white, size: 22),
            tooltip: 'Admin Settings',
            onPressed: () async {
              final updatedAvatar = await Navigator.push<String>(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AdminSettingsScreen(
                      adminEmail: widget.adminEmail,
                      currentAvatarUrl: _adminAvatarUrl,
                      onAvatarUpdated: (newUrl) {
                        if (mounted) {
                          setState(() {
                            _adminAvatarUrl = newUrl;
                          });
                        }
                      },
                    );
                  },
                ),
              );
              if (updatedAvatar != null && mounted) {
                setState(() {
                  _adminAvatarUrl = updatedAvatar;
                });
              }
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: AdminHeaderCard(
              brandColor: brandColor,
              adminAvatarUrl: _adminAvatarUrl,
              onTapAssignRider: () {
                setState(() {
                  _selectedTab = 2;
                });
              },
              onTapManageOrders: () {
                setState(() {
                  _selectedTab = 1;
                });
              },
              onTapManageRiders: () {
                setState(() {
                  _selectedTab = 2;
                });
              },
            ),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20.0),
            child: AdminOrdersTab(brandColor: brandColor),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20.0),
            child: AdminRidersTab(brandColor: brandColor),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20.0),
            child: AdminReportsTab(brandColor: brandColor),
          ),
        ],
      ),
      bottomNavigationBar: CustomCurvedNavBar(
        currentIndex: _selectedTab,
        brandColor: brandColor,
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        items: const [
          CustomCurvedNavBarItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home_rounded,
            label: 'Home',
          ),
          CustomCurvedNavBarItem(
            icon: Icons.assignment_outlined,
            activeIcon: Icons.assignment_rounded,
            label: 'Orders',
          ),
          CustomCurvedNavBarItem(
            icon: Icons.two_wheeler_outlined,
            activeIcon: Icons.two_wheeler_rounded,
            label: 'Riders',
          ),
          CustomCurvedNavBarItem(
            icon: Icons.bar_chart_outlined,
            activeIcon: Icons.bar_chart_rounded,
            label: 'Reports',
          ),
        ],
      ),
    );
  }
}
