import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/food_data.dart';
import '../data/order_manager.dart';
import 'main_nav_wrapper.dart';

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

  final List<Map<String, dynamic>> _riders = [
    {
      'name': 'Ricardo Dalisay',
      'plate': 'MVC 1234',
      'rating': '4.9 ⭐',
      'status': 'Delivering',
      'deliveries': '142 orders',
      'phone': '0917 123 4567',
    },
    {
      'name': 'Cardo Dalisay',
      'plate': 'ABC 5678',
      'rating': '4.8 ⭐',
      'status': 'Available',
      'deliveries': '98 orders',
      'phone': '0918 987 6543',
    },
    {
      'name': 'Juan Dela Cruz',
      'plate': 'XYZ 9101',
      'rating': '5.0 ⭐',
      'status': 'Delivering',
      'deliveries': '210 orders',
      'phone': '0919 456 7890',
    },
    {
      'name': 'Pedro Penduko',
      'plate': 'GOC 2026',
      'rating': '4.7 ⭐',
      'status': 'Offline',
      'deliveries': '65 orders',
      'phone': '0920 111 2233',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E2C),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'GoCrave Admin Control Panel',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Super Admin: ${widget.adminEmail}',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.storefront_rounded, color: Colors.white),
            tooltip: 'Customer View',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainNavWrapper(initialIndex: 0),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
            onPressed: () {
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Dashboard metrics refreshed!', style: GoogleFonts.poppins()),
                  backgroundColor: brandColor,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildExecutiveSummary(),
            _buildModuleNavigation(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _buildSelectedTabContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExecutiveSummary() {
    final liveOrders = OrderManager().orders;
    final activeOrdersCount = liveOrders.where((o) => o.status == 'Processing' || o.status == 'On the Way').length;

    return Container(
      color: const Color(0xFF1E1E2C),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
      child: Column(
        children: [
          Row(
            children: [
              _buildKpiCard('Total Revenue', '₱128,450', '+14.2% vs last week', Icons.payments_rounded, Colors.greenAccent),
              const SizedBox(width: 12),
              _buildKpiCard('Active Orders', '$activeOrdersCount Orders', 'Live in system', Icons.receipt_long_rounded, Colors.orangeAccent),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildKpiCard('Total Cravers', '1,280', 'Active accounts', Icons.people_alt_rounded, Colors.lightBlueAccent),
              const SizedBox(width: 12),
              _buildKpiCard('Rider Fleet', '24 Active', '4 On delivery', Icons.two_wheeler_rounded, Colors.amberAccent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKpiCard(String label, String value, String sub, IconData icon, Color accentColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A3C),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, size: 22, color: accentColor),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    sub,
                    style: GoogleFonts.poppins(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleNavigation() {
    final modules = [
      {'label': 'Overview', 'icon': Icons.dashboard_rounded},
      {'label': 'Orders', 'icon': Icons.shopping_bag_rounded},
      {'label': 'Menu Items', 'icon': Icons.restaurant_menu_rounded},
      {'label': 'Riders', 'icon': Icons.two_wheeler_rounded},
      {'label': 'Promos & Coins', 'icon': Icons.card_giftcard_rounded},
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        height: 42,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: modules.length,
          itemBuilder: (context, index) {
            final isSelected = _selectedTab == index;
            final module = modules[index];
            return Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                onTap: () => setState(() => _selectedTab = index),
                borderRadius: BorderRadius.circular(14),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? brandColor : const Color(0xFFF2F2F7),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        module['icon'] as IconData,
                        size: 16,
                        color: isSelected ? Colors.white : Colors.grey[700],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        module['label'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSelectedTabContent() {
    switch (_selectedTab) {
      case 1:
        return _buildOrdersManagementTab();
      case 2:
        return _buildMenuManagementTab();
      case 3:
        return _buildRidersManagementTab();
      case 4:
        return _buildPromosTab();
      case 0:
      default:
        return _buildOverviewAnalyticsTab();
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
            color: Colors.black,
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

  Widget _buildOrdersManagementTab() {
    final liveOrders = OrderManager().orders;

    if (liveOrders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Icon(Icons.inbox_rounded, size: 60, color: Colors.grey[300]),
              const SizedBox(height: 12),
              Text(
                'No orders placed yet',
                style: GoogleFonts.poppins(fontSize: 15, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Live Platform Orders (${liveOrders.length})',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Admin Override Enabled',
              style: GoogleFonts.poppins(fontSize: 11, color: brandColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ...liveOrders.map((order) {
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order.id,
                      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: brandColor),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        order.status,
                        style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: brandColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  order.title,
                  style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Customer: ${order.customerName} • Rider: ${order.riderName}',
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: ${order.totalAmount}',
                      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (newStatus) {
                        setState(() {
                          order.status = newStatus;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Order ${order.id} status updated to $newStatus"),
                            backgroundColor: brandColor,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'Processing', child: Text('Set: Processing')),
                        const PopupMenuItem(value: 'On the Way', child: Text('Set: On the Way')),
                        const PopupMenuItem(value: 'Delivered', child: Text('Set: Delivered')),
                      ],
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Text('Override Status', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold)),
                            const Icon(Icons.arrow_drop_down, size: 18),
                          ],
                        ),
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
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _showAddFoodModal(context);
              },
              icon: const Icon(Icons.add, size: 16, color: Colors.white),
              label: Text('Add Item', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold)),
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
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
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

  Widget _buildRidersManagementTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Active Delivery Fleet (${_riders.length})',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        ..._riders.map((rider) {
          final isDelivering = rider['status'] == 'Delivering';
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: isDelivering ? Colors.orange[50] : Colors.grey[100],
                  child: Icon(Icons.two_wheeler_rounded, color: isDelivering ? brandColor : Colors.grey),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rider['name']!,
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Plate: ${rider['plate']} • ${rider['deliveries']}',
                        style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isDelivering ? Colors.orange[50] : Colors.green[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        rider['status']!,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isDelivering ? brandColor : Colors.green[800],
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      rider['rating']!,
                      style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold),
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

  Widget _buildPromosTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Active Platform Vouchers & Promos',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        _buildPromoCard('GOCRAVE20', '20% OFF on all Fast Food items', 'Active'),
        _buildPromoCard('HOMESTYLE15', '15% OFF on Family Meals', 'Active'),
        _buildPromoCard('FREEDEL', 'Free Delivery on Desserts', 'Active'),
      ],
    );
  }

  Widget _buildPromoCard(String code, String desc, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.local_offer_rounded, color: brandColor, size: 20),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    code,
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: brandColor),
                  ),
                  Text(
                    desc,
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green[800]),
            ),
          ),
        ],
      ),
    );
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
              Text(
                'Add New Food Item',
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
              ),
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
}
