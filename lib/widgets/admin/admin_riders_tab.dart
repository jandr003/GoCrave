import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../screens/chat_screen.dart';
import 'admin_tracking_modal.dart';

class AdminRidersTab extends StatefulWidget {
  final Color brandColor;

  const AdminRidersTab({
    super.key,
    required this.brandColor,
  });

  @override
  State<AdminRidersTab> createState() => _AdminRidersTabState();
}

class _AdminRidersTabState extends State<AdminRidersTab> {
  int _selectedFilterIndex = 0;
  final TextEditingController _searchCtrl = TextEditingController();
  final List<String> _filters = ['All 12', 'Active 8', 'Offline 4'];

  final List<Map<String, dynamic>> _ridersList = [
    {
      'id': '#027',
      'name': 'Juan Dela Cruz',
      'plate': 'MVC 1234',
      'rating': '4.9 ⭐',
      'status': 'Online',
      'deliveries': '142 orders',
      'phone': '0917 123 4567',
      'avatar': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&auto=format&fit=crop',
    },
    {
      'id': '#042',
      'name': 'Mark Santos',
      'plate': 'ABC 5678',
      'rating': '4.8 ⭐',
      'status': 'Online',
      'deliveries': '98 orders',
      'phone': '0918 987 6543',
      'avatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop',
    },
    {
      'id': '#018',
      'name': 'Carlos Reyes',
      'plate': 'XYZ 9101',
      'rating': '5.0 ⭐',
      'status': 'On Delivery',
      'deliveries': '210 orders',
      'phone': '0919 456 7890',
      'avatar': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=200&auto=format&fit=crop',
    },
    {
      'id': '#031',
      'name': 'Ana Lim',
      'plate': 'GOC 2026',
      'rating': '4.9 ⭐',
      'status': 'Online',
      'deliveries': '115 orders',
      'phone': '0920 111 2233',
      'avatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop',
    },
    {
      'id': '#016',
      'name': 'Miguel Torres',
      'plate': 'PH 8812',
      'rating': '4.7 ⭐',
      'status': 'Offline',
      'deliveries': '65 orders',
      'phone': '0921 555 4433',
      'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=200&auto=format&fit=crop',
    },
  ];

  void _openLiveTracking(Map<String, dynamic> rider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AdminTrackingModal(
          rider: rider,
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
        Text('Active Delivery Fleet', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFEEEEEE)),
          ),
          child: TextField(
            controller: _searchCtrl,
            style: GoogleFonts.poppins(fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Search rider name or ID',
              hintStyle: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[400]),
              border: InputBorder.none,
              icon: const Icon(Icons.search_rounded, color: Colors.grey),
            ),
          ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 38,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _filters.length,
            itemBuilder: (context, idx) {
              final isSelected = _selectedFilterIndex == idx;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: InkWell(
                  onTap: () => setState(() => _selectedFilterIndex = idx),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? widget.brandColor : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isSelected ? widget.brandColor : const Color(0xFFEEEEEE)),
                    ),
                    child: Text(
                      _filters[idx],
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 16),

        ..._ridersList.map((rider) {
          final isDelivering = rider['status'] == 'On Delivery';
          final isOnline = rider['status'] == 'Online';

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
                  border: Border.all(color: const Color(0xFFEEEEEE)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(rider['avatar']),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(rider['name'], style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
                          Text('Rider ${rider['id']} • Plate: ${rider['plate']}', style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[500])),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: isDelivering ? Colors.purple : (isOnline ? const Color(0xFF2E7D32) : Colors.grey),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                rider['status'],
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: isDelivering ? Colors.purple : (isOnline ? const Color(0xFF2E7D32) : Colors.grey),
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
                          icon: const Icon(Icons.chat_bubble_outline_rounded, color: Colors.grey, size: 20),
                          tooltip: 'Chat Rider',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                  name: rider['name'],
                                  image: rider['avatar'],
                                  role: 'Rider ${rider['id']}',
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.phone_outlined, color: widget.brandColor, size: 20),
                          tooltip: 'Call Rider',
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Calling ${rider['name']} (${rider['phone']})...', style: GoogleFonts.poppins()),
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
      ],
    );
  }
}
