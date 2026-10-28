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
    if (mounted) setState(() {});
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
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleSpacing: 18,
        title: Row(
          children: [
            Image.asset(
              'assets/images/gocrave_app_logo.png',
              height: 38,
              fit: BoxFit.contain,
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
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_none_rounded, color: Color(0xFF0F172A), size: 22),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF5622),
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
                  builder: (context) => const AdminNotificationsScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Color(0xFF0F172A), size: 22),
            tooltip: 'Admin Settings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminSettingsScreen(adminEmail: widget.adminEmail),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            if (_selectedTab == 0)
              AdminHeaderCard(
                brandColor: brandColor,
                onTapAssignRider: () => setState(() => _selectedTab = 2),
                onTapManageOrders: () => setState(() => _selectedTab = 1),
                onTapManageRiders: () => setState(() => _selectedTab = 2),
              ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _buildSelectedTabContent(),
            ),
          ],
        ),
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

  Widget _buildSelectedTabContent() {
    switch (_selectedTab) {
      case 1:
        return AdminOrdersTab(brandColor: brandColor);
      case 2:
        return AdminRidersTab(brandColor: brandColor);
      case 3:
        return AdminReportsTab(brandColor: brandColor);
      case 0:
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildOverviewAnalyticsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Performing Food Items',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 12),
        ...allFoodItems.take(4).map((food) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    food['image']!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food['title']!,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        food['category']!,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      food['price']!,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: brandColor,
                      ),
                    ),
                    Text(
                      '${food['rating']} ⭐ Rating',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildMenuManagementTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Menu Stock & Availability',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _showAddFoodModal(context);
              },
              icon: const Icon(Icons.add, size: 16, color: Colors.white),
              label: Text('Add Item', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: brandColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...allFoodItems.map((food) {
          final title = food['title']!;
          final inStock = _foodStockStatus[title] ?? true;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    food['image']!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Text(
                        '${food['category']} • ${food['price']}',
                        style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: inStock,
                  activeColor: brandColor,
                  onChanged: (val) {
                    setState(() {
                      _foodStockStatus[title] = val;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$title is now ${val ? "IN STOCK" : "OUT OF STOCK"}'),
                        backgroundColor: val ? Colors.green : Colors.grey[700],
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
