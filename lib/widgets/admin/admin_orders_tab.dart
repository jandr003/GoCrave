import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      'price': '₱249.00',
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
      'price': '₱320.00',
      'time': '10:18 AM • Apr 26, 2025',
      'status': 'In Progress',
      'statusBg': Color(0xFFFFF3E0),
      'statusColor': Color(0xFFFF5622),
      'logo': 'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?q=80&w=200&auto=format&fit=crop',
    },
    {
      'id': '#GC-0000126',
      'store': 'Jollibee',
      'dish': 'Chickenjoy 2pc Meal',
      'customer': 'Juan Dela Cruz',
      'customerPhone': '+63 918 777 6655',
      'address': 'Brgy. Sta. Cruz, Guiguinto',
      'rider': 'Juan Dela Cruz (#RIDER-027)',
      'price': '₱185.00',
      'time': '10:12 AM • Apr 26, 2025',
      'status': 'On Delivery',
      'statusBg': Color(0xFFF3E8FF),
      'statusColor': Color(0xFF7C3AED),
      'logo': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=200&auto=format&fit=crop',
    },
    {
      'id': '#GC-0000125',
      'store': 'Shake Shack',
      'dish': 'ShackBurger & Fries',
      'customer': 'Alexander Santos',
      'customerPhone': '+63 919 555 4433',
      'address': 'Brgy. San Miguel, Bulacan',
      'rider': 'Mark Santos (#RIDER-042)',
      'price': '₱265.00',
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
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order Details', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: order['statusBg'], borderRadius: BorderRadius.circular(10)),
                    child: Text(order['status'], style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: order['statusColor'])),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(order['id'], style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w900, color: widget.brandColor)),
              Text(order['time'], style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500])),
              const SizedBox(height: 16),
              _buildModalDetailRow(Icons.person_rounded, 'Customer', '${order['customer']} (${order['customerPhone']})'),
              const SizedBox(height: 10),
              _buildModalDetailRow(Icons.location_on_rounded, 'Address', order['address']),
              const SizedBox(height: 10),
              _buildModalDetailRow(Icons.store_rounded, 'Restaurant', order['store']),
              const SizedBox(height: 10),
              _buildModalDetailRow(Icons.fastfood_rounded, 'Dishes', order['dish']),
              const SizedBox(height: 10),
              _buildModalDetailRow(Icons.two_wheeler_rounded, 'Assigned Courier', order['rider']),
              const SizedBox(height: 10),
              _buildModalDetailRow(Icons.payments_rounded, 'Total Amount', order['price']),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
                  label: Text('Close Details', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: widget.brandColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildModalDetailRow(IconData icon, String title, String val) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: widget.brandColor),
        const SizedBox(width: 10),
        Text('$title: ', style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[600])),
        Expanded(child: Text(val, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Orders Management', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
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
              hintText: 'Search by order ID, customer or restaurant',
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
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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

        ..._ordersList.map((order) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () => _showOrderDetailsModal(order),
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(order['logo'], width: 48, height: 48, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(order['id'], style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(color: order['statusBg'], borderRadius: BorderRadius.circular(6)),
                                child: Text(order['status'], style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: order['statusColor'])),
                              ),
                            ],
                          ),
                          Text(order['store'], style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
                          Text(order['dish'], style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(order['price'], style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w900, color: widget.brandColor)),
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
