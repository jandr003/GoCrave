import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/kds_manager.dart';

class MerchantKdsScreen extends StatefulWidget {
  final Color brandColor;

  const MerchantKdsScreen({
    super.key,
    this.brandColor = const Color(0xFFFF5622),
  });

  @override
  State<MerchantKdsScreen> createState() {
    return _MerchantKdsScreenState();
  }
}

class _MerchantKdsScreenState extends State<MerchantKdsScreen> {
  final KdsManager _kdsManager = KdsManager();
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['All Tickets', 'Incoming', 'Cooking', 'Ready'];

  @override
  void initState() {
    super.initState();
    _kdsManager.addListener(_onKdsChanged);
  }

  @override
  void dispose() {
    _kdsManager.removeListener(_onKdsChanged);
    super.dispose();
  }

  void _onKdsChanged() {
    if (mounted) {
      setState(() {
        
      });
    }
  }

  List<KdsOrder> get _filteredOrders {
    final orders = _kdsManager.kdsOrders;
    if (_selectedFilterIndex == 0) {
      return orders;
    }
    final filter = _filters[_selectedFilterIndex];
    return orders.where((o) {
      return o.kitchenStatus == filter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredOrders;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: widget.brandColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Kitchen Display System (KDS)',
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(_filters.length, (idx) {
                  final isSelected = _selectedFilterIndex == idx;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedFilterIndex = idx;
                        });
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? widget.brandColor : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: isSelected ? widget.brandColor : const Color(0xFFE2E8F0)),
                        ),
                        child: Text(
                          _filters[idx],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                            color: isSelected ? Colors.white : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Text(
                      'No kitchen tickets found',
                      style: GoogleFonts.poppins(color: const Color(0xFF64748B)),
                    ),
                  )
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    itemCount: filtered.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 14);
                    },
                    itemBuilder: (context, index) {
                      final order = filtered[index];
                      final status = order.kitchenStatus;

                      Color statusColor = const Color(0xFFF59E0B);
                      if (status == 'Cooking') {
                        statusColor = const Color(0xFF2563EB);
                      }
                      if (status == 'Ready') {
                        statusColor = const Color(0xFF10B981);
                      }

                      return Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
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
                                Text(
                                  order.id,
                                  style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: widget.brandColor),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: statusColor.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    status,
                                    style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: statusColor),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Customer: ${order.customerName} • ${order.orderTime}',
                              style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                            ),
                            const SizedBox(height: 12),
                            const Divider(height: 1, color: Color(0xFFF1F5F9)),
                            const SizedBox(height: 12),
                            ...order.items.map((item) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '• ${item['name']}',
                                      style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                                    ),
                                    Text(
                                      'x${item['qty']}',
                                      style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: widget.brandColor),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            const SizedBox(height: 12),
                            const Divider(height: 1, color: Color(0xFFF1F5F9)),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total: ${order.totalAmount}',
                                  style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                                ),
                                Row(
                                  children: [
                                    if (status == 'Incoming')
                                      SizedBox(
                                        height: 36,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _kdsManager.startCooking(order.id);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Order ${order.id} moved to Cooking.', style: GoogleFonts.poppins()),
                                                backgroundColor: const Color(0xFF2563EB),
                                                behavior: SnackBarBehavior.floating,
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF2563EB),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            elevation: 0,
                                          ),
                                          child: Text('Start Cooking', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                                        ),
                                      ),
                                    if (status == 'Cooking')
                                      SizedBox(
                                        height: 36,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _kdsManager.markReady(order.id);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Order ${order.id} marked as Ready for Pickup!', style: GoogleFonts.poppins()),
                                                backgroundColor: const Color(0xFF10B981),
                                                behavior: SnackBarBehavior.floating,
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF10B981),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            elevation: 0,
                                          ),
                                          child: Text('Mark Ready', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                                        ),
                                      ),
                                    if (status == 'Ready')
                                      SizedBox(
                                        height: 36,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _kdsManager.completeOrder(order.id);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Order ${order.id} completed and handed over.', style: GoogleFonts.poppins()),
                                                backgroundColor: const Color(0xFF64748B),
                                                behavior: SnackBarBehavior.floating,
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF64748B),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            elevation: 0,
                                          ),
                                          child: Text('Hand Over', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
