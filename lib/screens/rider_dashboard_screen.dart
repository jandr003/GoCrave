import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/order_manager.dart';
import 'main_nav_wrapper.dart';

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

  Map<String, dynamic>? _activeTask;
  int _taskStep = 1;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF161622),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
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
            _buildRiderHeaderCard(),
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

  Widget _buildRiderHeaderCard() {
    return Container(
      color: const Color(0xFF161622),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: brandColor,
                child: const Icon(Icons.two_wheeler_rounded, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Ricardo Dalisay',
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '4.9 ⭐',
                            style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.amber),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Honda Click 125i • Plate: MVC 1234',
                      style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Switch(
                    value: _isOnline,
                    activeColor: Colors.greenAccent,
                    onChanged: (val) {
                      setState(() => _isOnline = val);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(_isOnline ? 'You are now ONLINE and available for orders!' : 'You are now OFFLINE.'),
                          backgroundColor: _isOnline ? Colors.green : Colors.grey[700],
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  Text(
                    _isOnline ? 'ONLINE' : 'OFFLINE',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: _isOnline ? Colors.greenAccent : Colors.grey,
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
              color: const Color(0xFF232332),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.06)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildHeaderStat('Today Earnings', '₱${_todayEarnings.toInt()}', Colors.greenAccent),
                Container(height: 30, width: 1, color: Colors.white12),
                _buildHeaderStat('Completed', '$_completedTripsCount Trips', Colors.orangeAccent),
                Container(height: 30, width: 1, color: Colors.white12),
                _buildHeaderStat('Cash Wallet', '₱620', Colors.lightBlueAccent),
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
      {'label': 'Available (${_availableRequests.length})', 'icon': Icons.radar_rounded},
      {'label': 'Active Task ${_activeTask != null ? "🔴" : ""}', 'icon': Icons.near_me_rounded},
      {'label': 'History', 'icon': Icons.history_rounded},
      {'label': 'Wallet', 'icon': Icons.account_balance_wallet_rounded},
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
        return _buildActiveTaskTab();
      case 2:
        return _buildHistoryTab();
      case 3:
        return _buildWalletEarningsTab();
      case 0:
      default:
        return _buildAvailableRequestsTab();
    }
  }

  Widget _buildAvailableRequestsTab() {
    if (!_isOnline) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              Icon(Icons.portable_wifi_off_rounded, size: 60, color: Colors.grey[400]),
              const SizedBox(height: 12),
              Text(
                'You are currently OFFLINE',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Toggle the Online switch at the top to receive new delivery orders.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      );
    }

    if (_availableRequests.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              Icon(Icons.check_circle_outline_rounded, size: 60, color: Colors.green[300]),
              const SizedBox(height: 12),
              Text(
                'No pending requests nearby',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'New orders from restaurants will appear here automatically.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nearby Orders Ready for Pickup',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        ..._availableRequests.map((req) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFEEEEEE)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
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
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        req['id'],
                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: brandColor),
                      ),
                    ),
                    Text(
                      req['payout'],
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.green[800]),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.store_rounded, color: Colors.black87, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        req['restaurant'],
                        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      req['distance'],
                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: brandColor),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 26.0),
                  child: Text(
                    req['restoAddress'],
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.location_on_rounded, color: brandColor, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Customer: ${req['customer']}',
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 26.0),
                  child: Text(
                    req['customerAddress'],
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F9FB),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.fastfood_outlined, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          req['items'],
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () => _acceptDelivery(req),
                    icon: const Icon(Icons.check_circle_rounded, size: 18, color: Colors.white),
                    label: Text(
                      'Accept Delivery',
                      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: brandColor,
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

  Widget _buildActiveTaskTab() {
    if (_activeTask == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              Icon(Icons.near_me_disabled_rounded, size: 60, color: Colors.grey[300]),
              const SizedBox(height: 12),
              Text(
                'No Active Delivery Task',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Accept a request from the Available tab to start a delivery workflow.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      );
    }

    String actionBtnLabel = 'Arrived at Restaurant';
    IconData actionIcon = Icons.store_rounded;

    if (_taskStep == 2) {
      actionBtnLabel = 'Confirm Food Pick Up';
      actionIcon = Icons.takeout_dining_rounded;
    } else if (_taskStep == 3) {
      actionBtnLabel = 'Complete Delivery & Collect ${_activeTask!['payout']}';
      actionIcon = Icons.check_circle_rounded;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFEEEEEE)),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 16, offset: const Offset(0, 6)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Active Order ${_activeTask!['id']}',
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: brandColor),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Payout: ${_activeTask!['payout']}',
                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green[800]),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  _buildStepCircle(1, 'Resto', _taskStep >= 1),
                  _buildStepLine(_taskStep >= 2),
                  _buildStepCircle(2, 'Pick Up', _taskStep >= 2),
                  _buildStepLine(_taskStep >= 3),
                  _buildStepCircle(3, 'Deliver', _taskStep >= 3),
                ],
              ),

              const SizedBox(height: 20),
              const Divider(height: 1, color: Color(0xFFEEEEEE)),
              const SizedBox(height: 16),

              Row(
                children: [
                  Icon(Icons.store_rounded, color: brandColor, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_activeTask!['restaurant'], style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold)),
                        Text(_activeTask!['restoAddress'], style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500])),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  const Icon(Icons.person_pin_circle_rounded, color: Colors.blueAccent, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_activeTask!['customer'], style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold)),
                        Text(_activeTask!['customerAddress'], style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500])),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Calling ${_activeTask!['customer']}... (${_activeTask!['phone']})'),
                            backgroundColor: Colors.blueAccent,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.phone, size: 16, color: Colors.blueAccent),
                      label: Text('Call Customer', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.blueAccent),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Opening Navigation Maps...'),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.navigation_rounded, size: 16, color: Colors.green),
                      label: Text('Open Maps', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.green),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _advanceTaskStep,
                  icon: Icon(actionIcon, size: 20, color: Colors.white),
                  label: Text(
                    actionBtnLabel,
                    style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brandColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStepCircle(int step, String label, bool isDone) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: isDone ? brandColor : Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isDone
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : Text('$step', style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: GoogleFonts.poppins(fontSize: 10, fontWeight: isDone ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildStepLine(bool isDone) {
    return Expanded(
      child: Container(
        height: 3,
        color: isDone ? brandColor : Colors.grey[200],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Completed Delivery History',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        ..._completedHistory.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8F5E9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Color(0xFF2E7D32), size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item['id']} • ${item['customer']}',
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${item['resto']} • ${item['time']}',
                        style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      item['payout'],
                      style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.green[800]),
                    ),
                    Text(
                      '+${item['tip']} Tip',
                      style: GoogleFonts.poppins(fontSize: 11, color: brandColor, fontWeight: FontWeight.bold),
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

  Widget _buildWalletEarningsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF161622), Color(0xFF28283C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rider Wallet Balance', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[400])),
              const SizedBox(height: 4),
              Text('₱${_todayEarnings.toStringAsFixed(2)}', style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.greenAccent)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Withdrawal request of ₱${_todayEarnings.toStringAsFixed(2)} sent to GCash!'),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.account_balance_wallet, size: 16, color: Colors.black),
                      label: Text('Withdraw to GCash', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
