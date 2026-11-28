import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/order_manager.dart';
import 'login_screen.dart';
import 'rider_settings_screen.dart';
import 'rider_notifications_screen.dart';
import '../widgets/rider/rider_header_card.dart';
import '../widgets/rider/rider_available_orders_tab.dart';
import '../widgets/rider/rider_active_task_tab.dart';
import '../widgets/rider/rider_history_tab.dart';
import '../widgets/rider/rider_wallet_tab.dart';
import '../widgets/rider/rider_profile_tab.dart';
import '../widgets/rider/rider_edit_profile_modal.dart';
import '../widgets/rider/rider_government_id_modal.dart';
import '../widgets/rider/rider_weather_advisory_widget.dart';

class RiderDashboardScreen extends StatefulWidget {
  final String riderEmail;
  const RiderDashboardScreen({
    super.key,
    this.riderEmail = 'rider@gocrave.app',
  });

  @override
  State<RiderDashboardScreen> createState() {
    return _RiderDashboardScreenState();
  }
}

class _RiderDashboardScreenState extends State<RiderDashboardScreen> {
  int _selectedTab = 0;
  bool _isOnline = true;
  double _todayEarnings = 1450.0;
  int _completedTripsCount = 8;
  final Color brandColor = const Color(0xFFFF5622);

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
      'items': 'ChickenJoy Bucket Meal (x1)',
    },
    {
      'id': '#GOC98232',
      'restaurant': 'McDonald\'s - Malolos Crossing',
      'restoAddress': 'Crossing, Malolos, Bulacan',
      'customer': 'Crisostomo Ibarra',
      'customerAddress': 'Brgy. San Juan, Malolos City',
      'distance': '1.8 km',
      'payout': '₱70.00',
      'items': 'Big Mac Extra Value Meal (x2)',
    },
  ];

  final List<Map<String, dynamic>> _completedHistory = [
    {
      'id': '#GOC98200',
      'restaurant': 'Bulacan Goto King',
      'customer': 'Simoun P.',
      'payout': '₱95.00',
      'date': 'Today • 11:30 AM',
      'status': 'Delivered',
    },
    {
      'id': ' #GOC98185',
      'restaurant': 'Malolos Litson Manok',
      'customer': 'Basilio S.',
      'payout': '₱120.00',
      'date': 'Yesterday • 6:45 PM',
      'status': 'Delivered',
    },
  ];

  void _acceptDelivery(Map<String, dynamic> request) {
    setState(() {
      _activeTask = request;
      _taskStep = 1;
      _availableRequests.remove(request);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Accepted delivery task ${request['id']}!', style: GoogleFonts.poppins()),
        backgroundColor: brandColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _advanceTaskStep() {
    if (_taskStep < 3) {
      setState(() {
        _taskStep++;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Delivery step updated to milestone #$_taskStep', style: GoogleFonts.poppins()),
          backgroundColor: brandColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      _completeActiveTask();
    }
  }

  void _completeActiveTask() {
    if (_activeTask == null) {
      return;
    }

    final double payoutVal = double.tryParse(_activeTask!['payout'].replaceAll('₱', '')) ?? 85.0;

    setState(() {
      _completedHistory.insert(0, {
        'id': _activeTask!['id'],
        'restaurant': _activeTask!['restaurant'],
        'customer': _activeTask!['customer'],
        'payout': _activeTask!['payout'],
        'date': 'Just now • Completed',
        'status': 'Delivered',
      });
      _todayEarnings += payoutVal;
      _completedTripsCount++;
      _activeTask = null;
      _taskStep = 1;
    });

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Padding(
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
                'You earned ₱${payoutVal.toStringAsFixed(2)} + ₱15 Tip on this trip!',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
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
      MaterialPageRoute(
        builder: (context) {
          return const LoginScreen();
        },
      ),
      (route) {
        return false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
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
                  builder: (context) {
                    return const RiderNotificationsScreen();
                  },
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
                  builder: (context) {
                    return RiderSettingsScreen(
                      riderName: _riderName,
                      riderPhone: _riderPhone,
                      vehiclePlate: _vehiclePlate,
                      avatarUrl: _riderAvatarUrl,
                      onUpdateProfile: (name, phone, vehicle, avatar) {
                        setState(() {
                          _riderName = name;
                          _riderPhone = phone;
                          _vehiclePlate = vehicle;
                          _riderAvatarUrl = avatar;
                        });
                      },
                    );
                  },
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
            if (_selectedTab < 3)
              RiderHeaderCard(
                riderName: _riderName,
                vehiclePlate: _vehiclePlate,
                avatarUrl: _riderAvatarUrl,
                isOnline: _isOnline,
                todayEarnings: _todayEarnings,
                completedTripsCount: _completedTripsCount,
                brandColor: brandColor,
                onOnlineChanged: (val) {
                  setState(() {
                    _isOnline = val;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(_isOnline ? 'You are now ONLINE and available for orders!' : 'You are now OFFLINE.'),
                      backgroundColor: _isOnline ? Colors.green : Colors.grey[700],
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                onTapEditProfile: () {
                  _showEditRiderProfileModal(context);
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
    Widget tabWidget;
    switch (_selectedTab) {
      case 1:
        tabWidget = RiderActiveTaskTab(
          activeTask: _activeTask,
          taskStep: _taskStep,
          brandColor: brandColor,
          onAdvanceTaskStep: _advanceTaskStep,
        );
        break;
      case 2:
        tabWidget = RiderHistoryTab(
          completedHistory: _completedHistory,
          brandColor: brandColor,
        );
        break;
      case 3:
        tabWidget = RiderWalletTab(
          todayEarnings: _todayEarnings,
        );
        break;
      case 4:
        tabWidget = RiderProfileTab(
          riderName: _riderName,
          riderPhone: _riderPhone,
          vehiclePlate: _vehiclePlate,
          avatarUrl: _riderAvatarUrl,
          completedTripsCount: _completedTripsCount,
          brandColor: brandColor,
          onTapEditProfile: () {
            _showEditRiderProfileModal(context);
          },
          onTapGovernmentId: () {
            _showRiderGovernmentIdModal(context);
          },
          onLogOut: _onLogOut,
        );
        break;
      case 0:
      default:
        tabWidget = RiderAvailableOrdersTab(
          isOnline: _isOnline,
          availableRequests: _availableRequests,
          brandColor: brandColor,
          onAcceptDelivery: _acceptDelivery,
        );
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RiderWeatherAdvisoryWidget(
          brandColor: brandColor,
        ),
        const SizedBox(height: 12),
        tabWidget,
      ],
    );
  }
}
