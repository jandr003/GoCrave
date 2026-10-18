import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../screens/chat_screen.dart';
import 'admin_tracking_modal.dart';

class AdminOrdersTab extends StatefulWidget {
  final Color brandColor;

  const AdminOrdersTab({
    super.key,
    required this.brandColor,
  });

  @override
  State<AdminOrdersTab> createState() => _AdminOrdersTabState();
}

class _AdminOrdersTabState extends State<AdminOrdersTab> {
  int _selectedFilterIndex = 0;
  final TextEditingController _searchCtrl = TextEditingController();

  final List<String> _filters = ['All 128', 'Pending 18', 'In Progress 34', 'On Delivery 22', 'Completed 72'];

  final List<Map<String, dynamic>> _ordersList = [
    {
      'id': '#GC-0000128',
      'store': 'McDonald\'s',
      'dish': 'Big Mac Meal',
      'customer': 'Sofia Mendoza',
      'customerPhone': '+63 917 888 9900',
      'address': 'Brgy. San Vicente, Malolos City',
      'rider': 'Ramon Castillo (#RIDER-027)',
      'price': '₱ 249',
      'time': '10:42 AM • Apr 26, 2025',
      'status': 'Assigned',
      'statusBg': Color(0xFFE3F2FD),
      'statusColor': Color(0xFF1565C0),
      'logo': 'https://images.unsplash.com/photo-1550547660-d9450f859349?q=80&w=200&auto=format&fit=crop',
    },
    {
      'id': '#GC-0000127',
      'store': 'KFC',
      'dish': 'Chicken Bucket',
      'customer': 'Maria Santos',
      'customerPhone': '+63 912 345 6789',
      'address': '1234 Greenview St., Makati City',
      'rider': 'Carlos Reyes (#RIDER-018)',
      'price': '₱ 320',
      'time': '10:18 AM • Apr 26, 2025',
      'status': 'In Progress',
      'statusBg': Color(0xFFFFF3E0),
      'statusColor': Color(0xFFFF5622),
      'logo': 'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?q=80&w=200&auto=format&fit=crop',
    },
    {
      'id': '#GC-0000126',
      'store': 'Jollibee',
      'dish': 'Chicken Joy',
      'customer': 'Juan Dela Cruz',
      'customerPhone': '+63 918 777 6655',
      'address': 'Brgy. Sta. Cruz, Guiguinto',
      'rider': 'Juan Dela Cruz (#RIDER-027)',
      'price': '₱ 185',
      'time': '10:12 AM • Apr 26, 2025',
      'status': 'On Delivery',
      'statusBg': Color(0xFFF3E8FF),
      'statusColor': Color(0xFF7C3AED),
      'logo': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=200&auto=format&fit=crop',
    },
    {
      'id': '#GC-0000125',
      'store': 'Shake Shack',
      'dish': 'ShackBurger',
      'customer': 'Alexander Santos',
      'customerPhone': '+63 919 555 4433',
      'address': 'Brgy. San Miguel, Bulacan',
      'rider': 'Mark Santos (#RIDER-042)',
      'price': '₱ 265',
      'time': '10:03 AM • Apr 26, 2025',
      'status': 'Completed',
      'statusBg': Color(0xFFE8F5E9),
      'statusColor': Color(0xFF2E7D32),
      'logo': 'https://images.unsplash.com/photo-1586190848861-99aa4a171e90?q=80&w=200&auto=format&fit=crop',
    },
  ];

  void _showOrderDetailsModal(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.fromLTRB(
            24,
            16,
            24,
            MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    'Order Details',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: order['statusBg'],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  order['status'],
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: order['statusColor'],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                order['id'],
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F172A),
                ),
              ),
              Text(
                order['time'],
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
              ),

              const SizedBox(height: 16),
              const Divider(height: 1, color: Color(0xFFEEEEEE)),
              const SizedBox(height: 16),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color(0xFFE3F2FD),
                    child: const Icon(Icons.person_rounded, color: Color(0xFF1565C0), size: 20),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Customer', style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[500])),
                        Text(
                          order['customer'],
                          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.phone_outlined, size: 12, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(order['customerPhone'], style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600])),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 12, color: Colors.grey),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                order['address'],
                                style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600]),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const Divider(height: 1, color: Color(0xFFEEEEEE)),
              const SizedBox(height: 16),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[100],
                    backgroundImage: NetworkImage(order['logo']),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Restaurant', style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[500])),
                        Text(
                          order['store'],
                          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Text(
                          '🍱 ${order['dish']}  •  ${order['price']}',
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const Divider(height: 1, color: Color(0xFFEEEEEE)),
              const SizedBox(height: 16),

              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xFFFFF3E0),
                    child: Icon(Icons.two_wheeler_rounded, color: Color(0xFFFF5622), size: 20),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rider', style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[500])),
                        Text(
                          order['rider'],
                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.phone_outlined, color: Color(0xFF1565C0), size: 20),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Calling rider for ${order['id']}...', style: GoogleFonts.poppins()),
                              backgroundColor: widget.brandColor,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.chat_bubble_outline_rounded, color: Color(0xFF1565C0), size: 20),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                name: order['rider'],
                                image: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&auto=format&fit=crop',
                                role: 'Rider (${order['id']})',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Contacting rider for ${order['id']}...', style: GoogleFonts.poppins()),
                        backgroundColor: widget.brandColor,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.phone_rounded, size: 18, color: Color(0xFF1565C0)),
                  label: Text(
                    'Contact Rider',
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF1565C0)),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF1565C0), width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return AdminTrackingModal(
                          rider: {
                            'name': order['rider'],
                            'id': order['id'],
                          },
                          brandColor: widget.brandColor,
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.map_rounded, size: 18, color: Colors.white),
                  label: Text(
                    'View on Map',
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1565C0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
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
    final filteredOrders = _ordersList.where((o) {
      if (_selectedFilterIndex == 0) return true;
      final filterText = _filters[_selectedFilterIndex].split(' ')[0].toLowerCase();
      return o['status'].toString().toLowerCase().contains(filterText);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Orders', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
        const SizedBox(height: 14),

        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F3F5),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: TextField(
                  controller: _searchCtrl,
                  style: GoogleFonts.poppins(fontSize: 13),
                  decoration: InputDecoration(
                    hintText: 'Search by order ID, customer or restaurant',
                    hintStyle: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[400]),
                    border: InputBorder.none,
                    icon: const Icon(Icons.search_rounded, color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F3F5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(Icons.tune_rounded, color: widget.brandColor, size: 22),
            ),
          ],
        ),

        const SizedBox(height: 14),

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
                  borderRadius: BorderRadius.circular(18),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF1565C0) : const Color(0xFFF1F3F5),
                      borderRadius: BorderRadius.circular(18),
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

        ...filteredOrders.map((order) {
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            child: InkWell(
              onTap: () => _showOrderDetailsModal(order),
              borderRadius: BorderRadius.circular(22),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: const Color(0xFFEEEEEE)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order['id'],
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              order['time'],
                              style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[400]),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: order['statusBg'],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            order['status'],
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: order['statusColor'],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[100],
                          backgroundImage: NetworkImage(order['logo']),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order['store'],
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.takeout_dining_rounded, size: 14, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      order['dish'],
                                      style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
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
                          children: [
                            Text(
                              order['price'],
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.chevron_right_rounded, color: Colors.grey, size: 20),
                          ],
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
