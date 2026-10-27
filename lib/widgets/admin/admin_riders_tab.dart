import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../screens/chat_screen.dart';
import '../../screens/admin_add_rider_screen.dart';
import 'admin_tracking_modal.dart';

class RiderModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String plate;
  final String status;
  final String subtitle;
  final String rating;
  final String totalDeliveries;
  final String avatarUrl;

  RiderModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.plate,
    required this.status,
    required this.subtitle,
    required this.rating,
    required this.totalDeliveries,
    required this.avatarUrl,
  });

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
  }
}

class AdminRidersTab extends StatefulWidget {
  final Color brandColor;
  final List<RiderModel>? initialRiders;
  final Function(RiderModel rider)? onRiderSelected;

  const AdminRidersTab({
    super.key,
    required this.brandColor,
    this.initialRiders,
    this.onRiderSelected,
  });

  @override
  State<AdminRidersTab> createState() => _AdminRidersTabState();
}

class _AdminRidersTabState extends State<AdminRidersTab> {
  final TextEditingController _searchCtrl = TextEditingController();
  int _selectedFilterIndex = 0;
  String _searchQuery = '';

  late List<RiderModel> _riders;

  final List<String> _filterChips = [
    'All',
    'Pending Review',
    'Available',
    'On Delivery',
    'Offline',
  ];

  @override
  void initState() {
    super.initState();
    _riders = widget.initialRiders ?? [
      RiderModel(
        id: 'R001',
        name: 'Miguel Reyes',
        email: 'miguel.reyes@gocrave.app',
        phone: '0917 123 4567',
        plate: 'MVC 1234',
        status: 'Available',
        subtitle: 'Ready for assignment',
        rating: '4.9 ⭐',
        totalDeliveries: '142 orders',
        avatarUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&auto=format&fit=crop',
      ),
      RiderModel(
        id: 'R002',
        name: 'Juan Dela Cruz',
        email: 'juan.delacruz@gocrave.app',
        phone: '0918 987 6543',
        plate: 'ABC 5678',
        status: 'On Delivery',
        subtitle: '1 active delivery',
        rating: '4.8 ⭐',
        totalDeliveries: '210 orders',
        avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop',
      ),
      RiderModel(
        id: 'R003',
        name: 'Adrian Cruz',
        email: 'adrian.cruz@gocrave.app',
        phone: '0919 456 7890',
        plate: 'XYZ 9101',
        status: 'Pending Review',
        subtitle: 'Account verification required',
        rating: '5.0 ⭐',
        totalDeliveries: '0 orders',
        avatarUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=200&auto=format&fit=crop',
      ),
      RiderModel(
        id: 'R004',
        name: 'Ana Lim',
        email: 'ana.lim@gocrave.app',
        phone: '0920 111 2233',
        plate: 'GOC 2026',
        status: 'Available',
        subtitle: 'Ready for assignment',
        rating: '4.9 ⭐',
        totalDeliveries: '115 orders',
        avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop',
      ),
      RiderModel(
        id: 'R005',
        name: 'Miguel Torres',
        email: 'miguel.torres@gocrave.app',
        phone: '0921 555 4433',
        plate: 'PH 8812',
        status: 'Offline',
        subtitle: 'Shift completed',
        rating: '4.7 ⭐',
        totalDeliveries: '65 orders',
        avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=200&auto=format&fit=crop',
      ),
    ];

    _searchCtrl.addListener(() {
      setState(() {
        _searchQuery = _searchCtrl.text.toLowerCase().trim();
      });
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  int get _totalCount => _riders.length + 19; // 24 total fleet benchmark
  int get _availableCount => _riders.where((r) => r.status == 'Available').length + 6; // 8 available benchmark
  int get _onDeliveryCount => _riders.where((r) => r.status == 'On Delivery').length + 11; // 12 on delivery benchmark

  List<RiderModel> get _filteredRiders {
    return _riders.where((rider) {
      final matchesSearch = rider.name.toLowerCase().contains(_searchQuery) ||
                            rider.id.toLowerCase().contains(_searchQuery) ||
                            rider.plate.toLowerCase().contains(_searchQuery);

      if (!matchesSearch) return false;

      if (_selectedFilterIndex == 0) return true; // All
      final selectedChip = _filterChips[_selectedFilterIndex];
      return rider.status == selectedChip;
    }).toList();
  }

  void _openLiveTracking(RiderModel rider) {
    widget.onRiderSelected?.call(rider);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AdminTrackingModal(
          rider: {
            'id': '#${rider.id}',
            'name': rider.name,
            'plate': rider.plate,
            'rating': rider.rating,
            'status': rider.status,
            'deliveries': rider.totalDeliveries,
            'phone': rider.phone,
            'avatar': rider.avatarUrl,
          },
          brandColor: widget.brandColor,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Riders',
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                ),
                Text(
                  'Manage your delivery fleet.',
                  style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: () async {
                final newRider = await Navigator.push<RiderModel>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminAddRiderScreen(
                      onRiderAdded: (rider) {
                        setState(() {
                          _riders.insert(0, rider);
                        });
                      },
                    ),
                  ),
                );
                if (newRider != null && mounted) {
                  setState(() {});
                }
              },
              icon: const Icon(Icons.add_rounded, size: 18, color: Colors.white),
              label: Text('Add Rider', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.brandColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            controller: _searchCtrl,
            style: GoogleFonts.poppins(fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Search rider name or ID...',
              hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
              border: InputBorder.none,
              icon: Icon(Icons.search_rounded, color: widget.brandColor),
            ),
          ),
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            _buildKpiCard('Total Riders', '24', widget.brandColor),
            const SizedBox(width: 10),
            _buildKpiCard('Available', '8', const Color(0xFF2563EB)),
            const SizedBox(width: 10),
            _buildKpiCard('On Delivery', '12', const Color(0xFF10B981)),
          ],
        ),

        const SizedBox(height: 18),

        SizedBox(
          height: 38,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _filterChips.length,
            itemBuilder: (context, idx) {
              final isSelected = _selectedFilterIndex == idx;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: InkWell(
                  onTap: () => setState(() => _selectedFilterIndex = idx),
                  borderRadius: BorderRadius.circular(16),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? widget.brandColor : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isSelected ? widget.brandColor : const Color(0xFFE2E8F0)),
                      boxShadow: isSelected
                          ? [BoxShadow(color: widget.brandColor.withOpacity(0.3), blurRadius: 6, offset: const Offset(0, 2))]
                          : [],
                    ),
                    child: Center(
                      child: Text(
                        _filterChips[idx],
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? Colors.white : const Color(0xFF475569),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Rider List',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
            Text(
              '${_filteredRiders.length} showing',
              style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
            ),
          ],
        ),
        const SizedBox(height: 10),

        ..._filteredRiders.map((rider) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () => _openLiveTracking(rider),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: widget.brandColor.withOpacity(0.12),
                      child: Text(
                        rider.initials,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: widget.brandColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rider.name,
                            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                          ),
                          Text(
                            'Rider #${rider.id}',
                            style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              _buildStatusTagPill(rider.status),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  rider.subtitle,
                                  style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.chat_rounded, color: widget.brandColor, size: 20),
                          tooltip: 'Chat Rider',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                  name: rider.name,
                                  image: rider.avatarUrl,
                                  role: 'Rider #${rider.id}',
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.phone_in_talk_rounded, color: widget.brandColor, size: 20),
                          tooltip: 'Call Rider',
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Calling ${rider.name} (${rider.phone})...', style: GoogleFonts.poppins()),
                                backgroundColor: widget.brandColor,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),



        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildKpiCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.9)),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTagPill(String status) {
    Color cardColor;

    if (status == 'Available') {
      cardColor = const Color(0xFF2563EB);
    } else if (status == 'On Delivery') {
      cardColor = const Color(0xFF10B981);
    } else if (status == 'Pending Review') {
      cardColor = const Color(0xFFD97706);
    } else {
      cardColor = const Color(0xFF64748B);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
