import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/food_data.dart';
import '../data/order_manager.dart';
import 'main_nav_wrapper.dart';

class RestaurantDashboardScreen extends StatefulWidget {
  final String merchantEmail;
  const RestaurantDashboardScreen({super.key, this.merchantEmail = 'resto@gocrave.app'});

  @override
  State<RestaurantDashboardScreen> createState() => _RestaurantDashboardScreenState();
}

class _RestaurantDashboardScreenState extends State<RestaurantDashboardScreen> {
  int _selectedTab = 0; // 0: Incoming, 1: Preparing, 2: Ready for Pickup, 3: Menu Stock
  bool _isAcceptingOrders = true;
  double _todaySales = 14850.0;
  int _preparedOrdersCount = 28;
  final Color brandColor = const Color(0xFFFF5622);

  // In-memory food stock status tracker for merchant
  final Map<String, bool> _merchantStockStatus = {
    for (var item in allFoodItems) item['title']!: true,
  };

  // Kitchen Orders Pipeline
  final List<Map<String, dynamic>> _incomingOrders = [
    {
      'id': '#GOC98231',
      'customer': 'Sofia Mendoza',
      'items': '2x Juicy Beef Burger, 1x Mango Graham Shake',
      'note': 'Less ice on shake, extra secret sauce please.',
      'total': '₱465.00',
      'time': '2 mins ago',
      'address': 'Brgy. San Vicente, Malolos City',
    },
    {
      'id': '#GOC88123',
      'customer': 'Marco Valenzuela',
      'items': '1x Pepperoni Feast Pizza, 2x Drinks',
      'note': 'Crispy crust please.',
      'total': '₱540.00',
      'time': '5 mins ago',
      'address': 'Brgy. Sta. Cruz, Guiguinto',
    },
  ];

  final List<Map<String, dynamic>> _preparingOrders = [
    {
      'id': '#GOC76120',
      'customer': 'Alexander Santos',
      'items': '1x Chicken Adobo, 2x Extra Rice, 1x Coke',
      'note': 'Extra garlic on adobo.',
      'total': '₱280.00',
      'time': 'Started 8 mins ago',
      'prepStep': 'Cooking in Kitchen',
    },
  ];

  final List<Map<String, dynamic>> _readyOrders = [
    {
      'id': '#GOC65112',
      'customer': 'Patricia Gomez',
      'items': '1x Pork Sinigang, 2x Rice',
      'rider': 'Ramon Castillo (Honda Click • MVC 1234)',
      'total': '₱280.00',
      'time': 'Packed 3 mins ago',
      'riderStatus': 'Arriving in 2 mins',
    },
  ];

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

  void _acceptIncomingOrder(Map<String, dynamic> order) {
    setState(() {
      _incomingOrders.removeWhere((o) => o['id'] == order['id']);
      _preparingOrders.add({
        'id': order['id'],
        'customer': order['customer'],
        'items': order['items'],
        'note': order['note'],
        'total': order['total'],
        'time': 'Just accepted',
        'prepStep': 'Preparing Food',
      });
      _selectedTab = 1; // Switch to Preparing tab
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order ${order['id']} accepted! Moved to Kitchen Prep.'),
        backgroundColor: brandColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _markOrderReady(Map<String, dynamic> order) {
    setState(() {
      _preparingOrders.removeWhere((o) => o['id'] == order['id']);
      _readyOrders.add({
        'id': order['id'],
        'customer': order['customer'],
        'items': order['items'],
        'rider': 'Ramon Castillo (Honda Click • MVC 1234)',
        'total': order['total'],
        'time': 'Just packed',
        'riderStatus': 'Rider Dispatched',
      });
      _selectedTab = 2; // Switch to Ready tab
    });

    // Update customer live order status to Ready for Pickup
    final liveOrders = OrderManager().orders;
    if (liveOrders.isNotEmpty) {
      liveOrders.first.status = 'Processing';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order ${order['id']} is READY FOR PICKUP! Rider dispatched.'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _handOverToRider(Map<String, dynamic> order) {
    double totalNum = double.tryParse(order['total'].toString().replaceAll('₱', '')) ?? 300.0;

    setState(() {
      _readyOrders.removeWhere((o) => o['id'] == order['id']);
      _todaySales += totalNum;
      _preparedOrdersCount += 1;
    });

    // Update customer live order status to Out for Delivery
    final liveOrders = OrderManager().orders;
    if (liveOrders.isNotEmpty) {
      liveOrders.first.status = 'On the Way';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order ${order['id']} handed over to Rider Ramon Castillo! OUT FOR DELIVERY.'),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B2430),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'GoCrave Merchant Kitchen',
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              'Malolos Branch • ${widget.merchantEmail}',
              style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[400]),
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
                MaterialPageRoute(builder: (context) => const MainNavWrapper(initialIndex: 0)),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildMerchantHeaderCard(),
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

  Widget _buildMerchantHeaderCard() {
    return Container(
      color: const Color(0xFF1B2430),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: brandColor,
                child: const Icon(Icons.restaurant_rounded, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'GoCrave Central Kitchen',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Merchant ID: #MERCHANT-501 • Open',
                      style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Switch(
                    value: _isAcceptingOrders,
                    activeColor: Colors.greenAccent,
                    onChanged: (val) {
                      setState(() => _isAcceptingOrders = val);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(_isAcceptingOrders ? 'Kitchen is OPEN for incoming customer orders!' : 'Kitchen is now PAUSED.'),
                          backgroundColor: _isAcceptingOrders ? Colors.green : Colors.grey[700],
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  Text(
                    _isAcceptingOrders ? 'ACCEPTING' : 'PAUSED',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: _isAcceptingOrders ? Colors.greenAccent : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF283445),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.06)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildHeaderStat('Today Sales', '₱${_todaySales.toInt()}', Colors.greenAccent),
                Container(height: 30, width: 1, color: Colors.white12),
                _buildHeaderStat('Prepared', '$_preparedOrdersCount Orders', Colors.orangeAccent),
                Container(height: 30, width: 1, color: Colors.white12),
                _buildHeaderStat('Avg Prep', '14 Mins', Colors.lightBlueAccent),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String label, String val, Color color) {
    return Column(
      children: [
        Text(
          val,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w900, color: color),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[400]),
        ),
      ],
    );
  }

  Widget _buildModuleNavigation() {
    final tabs = [
      {'label': 'Incoming (${_incomingOrders.length})', 'icon': Icons.notifications_active_rounded},
      {'label': 'Preparing (${_preparingOrders.length})', 'icon': Icons.soup_kitchen_rounded},
      {'label': 'Ready (${_readyOrders.length})', 'icon': Icons.takeout_dining_rounded},
      {'label': 'Menu Stock', 'icon': Icons.inventory_2_rounded},
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        height: 42,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: tabs.length,
          itemBuilder: (context, index) {
            final isSelected = _selectedTab == index;
            final tab = tabs[index];
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
                        tab['icon'] as IconData,
                        size: 16,
                        color: isSelected ? Colors.white : Colors.grey[700],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        tab['label'] as String,
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
        return _buildPreparingTab();
      case 2:
        return _buildReadyTab();
      case 3:
        return _buildMenuStockTab();
      case 0:
      default:
        return _buildIncomingTab();
    }
  }

  Widget _buildIncomingTab() {
    if (!_isAcceptingOrders) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              Icon(Icons.pause_circle_filled_rounded, size: 60, color: Colors.grey[400]),
              const SizedBox(height: 12),
              Text('Kitchen is PAUSED', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('Turn on the Accepting switch at the top to receive new orders.', textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500])),
            ],
          ),
        ),
      );
    }

    if (_incomingOrders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              Icon(Icons.check_circle_outline_rounded, size: 60, color: Colors.green[300]),
              const SizedBox(height: 12),
              Text('No Pending Incoming Orders', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('New customer orders will ring here automatically.', textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500])),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Incoming Customer Orders', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        ..._incomingOrders.map((order) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFEEEEEE)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: const Color(0xFFFFF3E0), borderRadius: BorderRadius.circular(8)),
                      child: Text(order['id'], style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: brandColor)),
                    ),
                    Text(order['total'], style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black)),
                  ],
                ),
                const SizedBox(height: 10),
                Text('Customer: ${order['customer']}', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold)),
                Text(order['address'], style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500])),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFFF9F9FB), borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ordered Dishes:', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                      const SizedBox(height: 4),
                      Text(order['items'], style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                      if (order['note'].toString().isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text('Note: ${order['note']}', style: GoogleFonts.poppins(fontSize: 12, color: brandColor, fontWeight: FontWeight.w500)),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() => _incomingOrders.removeWhere((o) => o['id'] == order['id']));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Order ${order['id']} declined.'), backgroundColor: Colors.redAccent, behavior: SnackBarBehavior.floating),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.redAccent),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: Text('Decline', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton.icon(
                        onPressed: () => _acceptIncomingOrder(order),
                        icon: const Icon(Icons.soup_kitchen_rounded, size: 18, color: Colors.white),
                        label: Text('Accept & Start Prep', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: brandColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 0,
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

  Widget _buildPreparingTab() {
    if (_preparingOrders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              Icon(Icons.soup_kitchen_outlined, size: 60, color: Colors.grey[300]),
              const SizedBox(height: 12),
              Text('No Food Currently Preparing', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('Accept orders from the Incoming tab to start cooking.', textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500])),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Active Kitchen Cooking Pipeline', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        ..._preparingOrders.map((order) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(order['id'], style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: brandColor)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: Colors.amber[50], borderRadius: BorderRadius.circular(8)),
                      child: Text('Cooking in Kitchen', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.amber[900])),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Customer: ${order['customer']}', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
                Text(order['items'], style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700])),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () => _markOrderReady(order),
                    icon: const Icon(Icons.check_circle_rounded, size: 18, color: Colors.white),
                    label: Text('Mark Ready for Pickup', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildReadyTab() {
    if (_readyOrders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              Icon(Icons.takeout_dining_outlined, size: 60, color: Colors.grey[300]),
              const SizedBox(height: 12),
              Text('No Orders Waiting for Rider', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('Food marked ready in the Kitchen tab will appear here.', textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500])),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ready Food Items Waiting for Rider Pickup', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        ..._readyOrders.map((order) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(order['id'], style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: brandColor)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(8)),
                      child: Text('READY FOR PICKUP', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green[800])),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Customer: ${order['customer']}', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
                Text('Assigned Rider: ${order['rider']}', style: GoogleFonts.poppins(fontSize: 12, color: brandColor, fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () => _handOverToRider(order),
                    icon: const Icon(Icons.two_wheeler_rounded, size: 18, color: Colors.white),
                    label: Text('Hand Over to Rider (Start Delivery)', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildMenuStockTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Restaurant Menu Inventory & Availability', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        ...allFoodItems.map((food) {
          final title = food['title']!;
          final inStock = _merchantStockStatus[title] ?? true;

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
                  child: Image.network(food['image']!, width: 50, height: 50, fit: BoxFit.cover),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
                      Text('${food['category']} • ${food['price']}', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                    ],
                  ),
                ),
                Switch(
                  value: inStock,
                  activeColor: brandColor,
                  onChanged: (val) {
                    setState(() {
                      _merchantStockStatus[title] = val;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$title is now ${val ? "AVAILABLE" : "UNAVAILABLE"}'),
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
