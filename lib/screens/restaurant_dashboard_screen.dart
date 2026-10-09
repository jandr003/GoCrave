import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/food_data.dart';
import '../data/order_manager.dart';
import 'login_screen.dart';
import 'restaurant_notifications_screen.dart';
import 'restaurant_settings_screen.dart';
import '../widgets/restaurant/restaurant_header_card.dart';
import '../widgets/restaurant/restaurant_incoming_tab.dart';
import '../widgets/restaurant/restaurant_preparing_tab.dart';
import '../widgets/restaurant/restaurant_ready_tab.dart';
import '../widgets/restaurant/restaurant_menu_stock_tab.dart';
import '../widgets/restaurant/restaurant_profile_tab.dart';
import '../widgets/restaurant/restaurant_edit_profile_modal.dart';

class RestaurantDashboardScreen extends StatefulWidget {
  final String merchantEmail;
  const RestaurantDashboardScreen({super.key, this.merchantEmail = 'resto@gocravestaff.ph'});

  @override
  State<RestaurantDashboardScreen> createState() => _RestaurantDashboardScreenState();
}

class _RestaurantDashboardScreenState extends State<RestaurantDashboardScreen> {
  int _selectedTab = 0;
  bool _isAcceptingOrders = true;
  double _todaySales = 14850.0;
  int _preparedOrdersCount = 28;
  final Color brandColor = const Color(0xFFFF5622);

  String _storeName = 'GoCrave Central Kitchen';
  String _storePhone = '0917 888 9900';
  String _branchAddress = 'McArthur Highway, Malolos City, Bulacan';
  String _operatingHours = '8:00 AM - 10:00 PM (Mon - Sun)';
  String _storeAvatarUrl = 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?q=80&w=200&auto=format&fit=crop';

  final List<String> _storeAvatars = [
    'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?q=80&w=200&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=200&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1552566626-52f8b828add9?q=80&w=200&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1537047902294-62a40c20a6ae?q=80&w=200&auto=format&fit=crop',
  ];

  final Map<String, bool> _merchantStockStatus = {
    for (var item in allFoodItems) item['title']!: true,
  };

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
      _selectedTab = 1;
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
      _selectedTab = 2;
    });

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

  void _showEditStoreProfileModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return RestaurantEditProfileModal(
          currentStoreName: _storeName,
          currentPhone: _storePhone,
          currentAddress: _branchAddress,
          currentHours: _operatingHours,
          currentAvatar: _storeAvatarUrl,
          avatars: _storeAvatars,
          brandColor: brandColor,
          onSave: (name, phone, address, hours, avatar) {
            setState(() {
              _storeName = name;
              _storePhone = phone;
              _branchAddress = address;
              _operatingHours = hours;
              _storeAvatarUrl = avatar;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Store profile and operating hours updated!', style: GoogleFonts.poppins()),
                backgroundColor: brandColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            );
          },
        );
      },
    );
  }

  void _onLogOut() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
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
        titleSpacing: 20,
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
                  builder: (context) => const RestaurantNotificationsScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Color(0xFF0F172A), size: 22),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RestaurantSettingsScreen(
                    merchantEmail: widget.merchantEmail,
                  ),
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
            if (_selectedTab != 4)
              RestaurantHeaderCard(
                isAcceptingOrders: _isAcceptingOrders,
                todaySales: _todaySales,
                preparedOrdersCount: _preparedOrdersCount,
                brandColor: brandColor,
                onAcceptingChanged: (val) {
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _buildSelectedTabContent(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: (index) {
            setState(() {
              _selectedTab = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: brandColor,
          unselectedItemColor: Colors.grey[500],
          selectedLabelStyle: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold),
          unselectedLabelStyle: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w500),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.notifications_active_rounded),
              activeIcon: const Icon(Icons.notifications_active_rounded, size: 26),
              label: 'Incoming (${_incomingOrders.length})',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.soup_kitchen_rounded),
              activeIcon: const Icon(Icons.soup_kitchen_rounded, size: 26),
              label: 'Preparing (${_preparingOrders.length})',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.takeout_dining_rounded),
              activeIcon: const Icon(Icons.takeout_dining_rounded, size: 26),
              label: 'Ready (${_readyOrders.length})',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.inventory_2_rounded),
              activeIcon: const Icon(Icons.inventory_2_rounded, size: 26),
              label: 'Menu Stock',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.account_circle_outlined),
              activeIcon: const Icon(Icons.account_circle_rounded, size: 26),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedTabContent() {
    switch (_selectedTab) {
      case 1:
        return RestaurantPreparingTab(
          preparingOrders: _preparingOrders,
          brandColor: brandColor,
          onMarkReady: _markOrderReady,
        );
      case 2:
        return RestaurantReadyTab(
          readyOrders: _readyOrders,
          brandColor: brandColor,
          onHandOverToRider: _handOverToRider,
        );
      case 3:
        return RestaurantMenuStockTab(
          merchantStockStatus: _merchantStockStatus,
          brandColor: brandColor,
          onToggleStock: (title, inStock) {
            setState(() {
              _merchantStockStatus[title] = inStock;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$title is now ${inStock ? "AVAILABLE" : "UNAVAILABLE"}'),
                backgroundColor: inStock ? Colors.green : Colors.grey[700],
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        );
      case 4:
        return RestaurantProfileTab(
          storeName: _storeName,
          storePhone: _storePhone,
          branchAddress: _branchAddress,
          operatingHours: _operatingHours,
          avatarUrl: _storeAvatarUrl,
          todaySales: _todaySales,
          preparedOrdersCount: _preparedOrdersCount,
          brandColor: brandColor,
          onTapEditProfile: () => _showEditStoreProfileModal(context),
          onTapSettings: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RestaurantSettingsScreen(merchantEmail: widget.merchantEmail),
              ),
            );
          },
          onTapNotifications: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RestaurantNotificationsScreen(),
              ),
            );
          },
          onLogOut: _onLogOut,
        );
      case 0:
      default:
        return RestaurantIncomingTab(
          isAcceptingOrders: _isAcceptingOrders,
          incomingOrders: _incomingOrders,
          brandColor: brandColor,
          onAcceptOrder: _acceptIncomingOrder,
          onDeclineOrder: (order) {
            setState(() => _incomingOrders.removeWhere((o) => o['id'] == order['id']));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Order ${order['id']} declined.'),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        );
    }
  }
}
