import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/order_manager.dart';
import 'login_screen.dart';
import '../widgets/rider/rider_header_card.dart';
import '../widgets/rider/rider_available_orders_tab.dart';
import '../widgets/rider/rider_active_task_tab.dart';
import '../widgets/rider/rider_history_tab.dart';
import '../widgets/rider/rider_wallet_tab.dart';
import '../widgets/rider/rider_profile_tab.dart';
import '../widgets/rider/rider_edit_profile_modal.dart';
import '../widgets/rider/rider_government_id_modal.dart';

class RiderDashboardScreen extends StatefulWidget {
  final String riderEmail;
  const RiderDashboardScreen({super.key, this.riderEmail = 'rider@gocrave.app'});

  @override
  State<RiderDashboardScreen> createState() => _RiderDashboardScreenState();
}

class _RiderDashboardScreenState extends State<RiderDashboardScreen> {
  int _selectedTab = 0;
  bool _isOnline = true;
  double _todayEarnings = 1450.0;
  int _completedTripsCount = 8;
  final Color brandColor = const Color(0xFFFF5622);

  // Rider Editable Profile State
  String _riderName = 'Ricardo Dalisay';
  String _riderPhone = '0917 888 9900';
  String _vehiclePlate = 'Honda Click 125i • Plate: MVC 1234';
  String _riderAvatarUrl = 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&auto=format&fit=crop';

  Map<String, dynamic>? _activeTask;
  int _taskStep = 1;

  final List<String> _riderAvatars = [
    'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=200&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?q=80&w=200&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=200&auto=format&fit=crop',
    'https://api.dicebear.com/7.x/adventurer/png?seed=RiderMax&scale=120',
    'https://api.dicebear.com/7.x/adventurer/png?seed=RiderLeo&scale=120',
  ];

  final List<Map<String, dynamic>> _availableRequests = [
    {
      'id': '#GOC98231',
      'restaurant': 'Jollibee - Malolos',
      'restoAddress': 'McArthur Highway, Malolos, Bulacan',
      'customer': 'Maria Clara',
      'customerAddress': 'Brgy. San Vicente, Malolos City',
      'distance': '2.4 km',
      'payout': '₱85.00',
      'items': '2x Chickenjoy Meal, 1x Jolly Spaghetti',
      'phone': '0917 888 9900',
    },
    {
      'id': '#GOC88123',
      'restaurant': 'Mang Inasal - Guiguinto',
      'restoAddress': 'Tabang Crossing, Guiguinto, Bulacan',
      'customer': 'Juan Tamad',
      'customerAddress': 'Brgy. Sta. Cruz, Guiguinto',
      'distance': '1.8 km',
      'payout': '₱65.00',
      'items': '1x PM1 PM2 Combo, 2x Extra Rice',
      'phone': '0918 777 6655',
    },
    {
      'id': '#GOC76120',
      'restaurant': 'GoCrave Central Kitchen',
      'restoAddress': 'San Miguel, Bulacan',
      'customer': 'John Andrew',
      'customerAddress': 'Brgy. San Miguel, Bulacan...',
      'distance': '3.1 km',
      'payout': '₱95.00',
      'items': '1x Juicy Beef Burger, 1x Fries',
      'phone': '0919 555 4433',
    },
  ];

  final List<Map<String, dynamic>> _completedHistory = [
    {
      'id': '#GOC65112',
      'customer': 'Liza Soberano',
      'resto': 'Burger King - Balagtas',
      'payout': '₱90.00',
      'tip': '₱20.00',
      'time': '12:30 PM Today',
    },
    {
      'id': '#GOC54311',
      'customer': 'Enrique Gil',
      'resto': 'Pizza Hut - Marilao',
      'payout': '₱110.00',
      'tip': '₱30.00',
      'time': '11:15 AM Today',
    },
    {
      'id': '#GOC43210',
      'customer': 'Kathryn Bernardo',
      'resto': 'Chowking - Meycauayan',
      'payout': '₱75.00',
      'tip': '₱15.00',
      'time': '10:00 AM Today',
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

  void _acceptDelivery(Map<String, dynamic> request) {
    setState(() {
      _activeTask = Map<String, dynamic>.from(request);
      _taskStep = 1;
      _selectedTab = 1;
      _availableRequests.removeWhere((r) => r['id'] == request['id']);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Accepted delivery ${request['id']}! Heading to ${request['restaurant']}.'),
        backgroundColor: brandColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _advanceTaskStep() {
    if (_activeTask == null) return;

    if (_taskStep == 1) {
      setState(() => _taskStep = 2);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Arrived at ${_activeTask!['restaurant']}. Waiting for food pickup...'),
          backgroundColor: Colors.orangeAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else if (_taskStep == 2) {
      setState(() => _taskStep = 3);
      final liveOrders = OrderManager().orders;
      if (liveOrders.isNotEmpty) {
        liveOrders.first.status = 'On the Way';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Food picked up! Status updated to OUT FOR DELIVERY.'),
          backgroundColor: Colors.blueAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else if (_taskStep == 3) {
      double payoutNum = double.tryParse(_activeTask!['payout'].toString().replaceAll('₱', '')) ?? 80.0;
      setState(() {
        _todayEarnings += payoutNum;
        _completedTripsCount += 1;
        _completedHistory.insert(0, {
          'id': _activeTask!['id'],
          'customer': _activeTask!['customer'],
          'resto': _activeTask!['restaurant'],
          'payout': _activeTask!['payout'],
          'tip': '₱15.00',
          'time': 'Just now',
        });
        _activeTask = null;
        _taskStep = 1;
        _selectedTab = 2;
      });

      final liveOrders = OrderManager().orders;
      if (liveOrders.isNotEmpty) {
        liveOrders.first.status = 'Delivered';
      }

      _showDeliverySuccessModal(payoutNum);
    }
  }

  void _showDeliverySuccessModal(double payout) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded, color: Color(0xFF2E7D32), size: 54),
              ),
              const SizedBox(height: 16),
              Text(
                'Delivery Completed!',
                style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                'You earned ₱${payout.toStringAsFixed(2)} + ₱15 Tip on this trip!',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brandColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(
                    'Great! Back to Dashboard',
                    style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditRiderProfileModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return RiderEditProfileModal(
          currentName: _riderName,
          currentPhone: _riderPhone,
          currentVehicle: _vehiclePlate,
          currentAvatar: _riderAvatarUrl,
          avatars: _riderAvatars,
          brandColor: brandColor,
          onSave: (name, phone, vehicle, avatar) {
            setState(() {
              _riderName = name;
              _riderPhone = phone;
              _vehiclePlate = vehicle;
              _riderAvatarUrl = avatar;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Rider profile updated successfully!', style: GoogleFonts.poppins()),
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

  void _showRiderGovernmentIdModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return RiderGovernmentIdModal(
          brandColor: brandColor,
          onSave: (idType, idNumber, frontPhoto, backPhoto) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Government ID ($idType) submitted for verification!', style: GoogleFonts.poppins()),
                backgroundColor: Colors.green,
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
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: brandColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
          tooltip: 'Log Out',
          onPressed: _onLogOut,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'GoCrave Rider Portal',
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              widget.riderEmail,
              style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[400]),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            if (_selectedTab != 4)
              RiderHeaderCard(
                riderName: _riderName,
                vehiclePlate: _vehiclePlate,
                avatarUrl: _riderAvatarUrl,
                isOnline: _isOnline,
                todayEarnings: _todayEarnings,
                completedTripsCount: _completedTripsCount,
                brandColor: brandColor,
                onOnlineChanged: (val) {
                  setState(() => _isOnline = val);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(_isOnline ? 'You are now ONLINE and available for orders!' : 'You are now OFFLINE.'),
                      backgroundColor: _isOnline ? Colors.green : Colors.grey[700],
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                onTapEditProfile: () => _showEditRiderProfileModal(context),
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
              icon: const Icon(Icons.radar_rounded),
              activeIcon: const Icon(Icons.radar_rounded, size: 26),
              label: 'Deliveries (${_availableRequests.length})',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  const Icon(Icons.near_me_rounded),
                  if (_activeTask != null)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
              activeIcon: const Icon(Icons.near_me_rounded, size: 26),
              label: 'Active Task',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.history_rounded),
              activeIcon: const Icon(Icons.history_rounded, size: 26),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.account_balance_wallet_rounded),
              activeIcon: const Icon(Icons.account_balance_wallet_rounded, size: 26),
              label: 'Wallet',
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
        return RiderActiveTaskTab(
          activeTask: _activeTask,
          taskStep: _taskStep,
          brandColor: brandColor,
          onAdvanceTaskStep: _advanceTaskStep,
        );
      case 2:
        return RiderHistoryTab(
          completedHistory: _completedHistory,
          brandColor: brandColor,
        );
      case 3:
        return RiderWalletTab(
          todayEarnings: _todayEarnings,
        );
      case 4:
        return RiderProfileTab(
          riderName: _riderName,
          riderPhone: _riderPhone,
          vehiclePlate: _vehiclePlate,
          avatarUrl: _riderAvatarUrl,
          completedTripsCount: _completedTripsCount,
          brandColor: brandColor,
          onTapEditProfile: () => _showEditRiderProfileModal(context),
          onTapGovernmentId: () => _showRiderGovernmentIdModal(context),
          onLogOut: _onLogOut,
        );
      case 0:
      default:
        return RiderAvailableOrdersTab(
          isOnline: _isOnline,
          availableRequests: _availableRequests,
          brandColor: brandColor,
          onAcceptDelivery: _acceptDelivery,
        );
    }
  }
}
