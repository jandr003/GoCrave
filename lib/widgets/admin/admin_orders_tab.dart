import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import '../../data/order_model.dart';
import '../../screens/chat_screen.dart';
import 'admin_tracking_modal.dart';
import 'admin_contact_rider_modal.dart';

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

  final List<OrderModel> _ordersList = const [
    OrderModel(
      id: '#GC-0000128',
      storeName: 'McDonald\'s',
      storeLogo: 'https://images.unsplash.com/photo-1550547660-d9450f859349?q=80&w=200&auto=format&fit=crop',
      dishName: 'Big Mac Meal',
      customerName: 'Sofia Mendoza',
      customerPhone: '+63 917 888 9900',
      address: 'Brgy. San Vicente, Malolos City',
      riderName: 'Ramon Castillo (#RIDER-027)',
      riderAvatar: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&auto=format&fit=crop',
      price: '₱ 249',
      time: '10:42 AM • Apr 26, 2025',
      status: 'Assigned',
      cityName: 'Malolos, Bulacan',
      centerLatLng: LatLng(14.8560, 120.8190),
      storeLatLng: LatLng(14.8527, 120.8160),
      riderLatLng: const LatLng(14.8560, 120.8163),
      customerLatLng: const LatLng(14.8570, 120.8252),
      routePoints: const [
        LatLng(14.8527, 120.8160),
        LatLng(14.8550, 120.8162),
        LatLng(14.8560, 120.8163),
        LatLng(14.8582, 120.8166),
        LatLng(14.8584, 120.8172),
        LatLng(14.8582, 120.8190),
        LatLng(14.8578, 120.8215),
        LatLng(14.8573, 120.8235),
        LatLng(14.8570, 120.8252),
      ],
    ),
    OrderModel(
      id: '#GC-0000127',
      storeName: 'KFC',
      storeLogo: 'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?q=80&w=200&auto=format&fit=crop',
      dishName: 'Chicken Bucket',
      customerName: 'Maria Santos',
      customerPhone: '+63 912 345 6789',
      address: '1234 Greenview St., Makati City',
      riderName: 'Carlos Reyes (#RIDER-018)',
      riderAvatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=200&auto=format&fit=crop',
      price: '₱ 320',
      time: '10:18 AM • Apr 26, 2025',
      status: 'In Progress',
      cityName: 'Makati City (NCR)',
      centerLatLng: LatLng(14.5560, 121.0280),
      storeLatLng: LatLng(14.5547, 121.0244),
      riderLatLng: LatLng(14.5562, 121.0280),
      customerLatLng: LatLng(14.5580, 121.0320),
      routePoints: [
        LatLng(14.5547, 121.0244),
        LatLng(14.5555, 121.0260),
        LatLng(14.5562, 121.0280),
        LatLng(14.5570, 121.0300),
        LatLng(14.5580, 121.0320),
      ],
    ),
    OrderModel(
      id: '#GC-0000126',
      storeName: 'Jollibee',
      storeLogo: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=200&auto=format&fit=crop',
      dishName: 'Chicken Joy',
      customerName: 'Juan Dela Cruz',
      customerPhone: '+63 918 777 6655',
      address: 'Brgy. Sta. Cruz, Guiguinto',
      riderName: 'Juan Dela Cruz (#RIDER-027)',
      riderAvatar: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&auto=format&fit=crop',
      price: '₱ 185',
      time: '10:12 AM • Apr 26, 2025',
      status: 'On Delivery',
      cityName: 'Guiguinto, Bulacan',
      centerLatLng: LatLng(14.8350, 120.8840),
      storeLatLng: LatLng(14.8320, 120.8800),
      riderLatLng: LatLng(14.8350, 120.8840),
      customerLatLng: LatLng(14.8380, 120.8880),
      routePoints: [
        LatLng(14.8320, 120.8800),
        LatLng(14.8335, 120.8820),
        LatLng(14.8350, 120.8840),
        LatLng(14.8365, 120.8860),
        LatLng(14.8380, 120.8880),
      ],
    ),
    OrderModel(
      id: '#GC-0000125',
      storeName: 'Shake Shack',
      storeLogo: 'https://images.unsplash.com/photo-1586190848861-99aa4a171e90?q=80&w=200&auto=format&fit=crop',
      dishName: 'ShackBurger',
      customerName: 'Alexander Santos',
      customerPhone: '+63 919 555 4433',
      address: 'Brgy. San Miguel, Bulacan',
      riderName: 'Mark Santos (#RIDER-042)',
      riderAvatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop',
      price: '₱ 265',
      time: '10:03 AM • Apr 26, 2025',
      status: 'Completed',
      cityName: 'San Miguel, Bulacan',
      centerLatLng: LatLng(15.1420, 120.9750),
      storeLatLng: LatLng(15.1400, 120.9700),
      riderLatLng: LatLng(15.1415, 120.9730),
      customerLatLng: LatLng(15.1450, 120.9780),
      routePoints: [
        LatLng(15.1400, 120.9700),
        LatLng(15.1415, 120.9730),
        LatLng(15.1430, 120.9750),
        LatLng(15.1450, 120.9780),
      ],
    ),
  ];

  Color _getStatusBg(String status) {
    switch (status.toLowerCase()) {
      case 'assigned':
        return widget.brandColor.withOpacity(0.12);
      case 'in progress':
        return const Color(0xFFFFF3E0);
      case 'on delivery':
        return const Color(0xFFF3E8FF);
      case 'completed':
        return const Color(0xFFE8F5E9);
      default:
        return Colors.grey[100]!;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'assigned':
        return widget.brandColor;
      case 'in progress':
        return const Color(0xFFFF5622);
      case 'on delivery':
        return const Color(0xFF7C3AED);
      case 'completed':
        return const Color(0xFF2E7D32);
      default:
        return Colors.grey[700]!;
    }
  }

  void _showOrderDetailsModal(OrderModel order) {
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
                  color: _getStatusBg(order.status),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  order.status,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(order.status),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                order.id,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F172A),
                ),
              ),
              Text(
                order.time,
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
                    backgroundColor: widget.brandColor.withOpacity(0.12),
                    child: Icon(Icons.person_rounded, color: widget.brandColor, size: 20),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Customer', style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[500])),
                        Text(
                          order.customerName,
                          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.phone_outlined, size: 12, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(order.customerPhone, style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600])),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 12, color: Colors.grey),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                order.address,
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
                    backgroundImage: NetworkImage(order.storeLogo),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Restaurant', style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[500])),
                        Text(
                          order.storeName,
                          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Text(
                          '🍱 ${order.dishName}  •  ${order.price}',
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
                          order.riderName,
                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.phone_outlined, color: widget.brandColor, size: 20),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Calling rider for ${order.id}...', style: GoogleFonts.poppins()),
                              backgroundColor: widget.brandColor,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.chat_bubble_outline_rounded, color: widget.brandColor, size: 20),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                name: order.riderName,
                                image: order.riderAvatar,
                                role: 'Rider (${order.id})',
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
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return AdminContactRiderModal(
                          rider: {
                            'id': order.id,
                            'name': order.riderName,
                            'avatar': order.riderAvatar,
                            'phone': '0917 123 4567',
                          },
                          brandColor: widget.brandColor,
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.phone_rounded, size: 18, color: widget.brandColor),
                  label: Text(
                    'Contact Rider',
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: widget.brandColor),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: widget.brandColor, width: 1.5),
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
                            'orderModel': order,
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
                    backgroundColor: widget.brandColor,
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
      return o.status.toLowerCase().contains(filterText);
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
                      color: isSelected ? widget.brandColor : const Color(0xFFF1F3F5),
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
                              order.id,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              order.time,
                              style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[400]),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusBg(order.status),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            order.status,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: _getStatusColor(order.status),
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
                          backgroundImage: NetworkImage(order.storeLogo),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.storeName,
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
                                      order.dishName,
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
                              order.price,
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
