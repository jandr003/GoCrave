import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminNotificationsScreen extends StatefulWidget {
  const AdminNotificationsScreen({super.key});

  @override
  State<AdminNotificationsScreen> createState() => _AdminNotificationsScreenState();
}

class _AdminNotificationsScreenState extends State<AdminNotificationsScreen> {
  final Color brandColor = const Color(0xFFFF5622);
  int _selectedFilterIndex = 0;

  final List<String> _filters = ['All', 'Unread', 'Orders', 'Riders', 'System'];

  final List<Map<String, dynamic>> _notifications = [
    {
      'id': 'AN-001',
      'title': 'High Priority Order #GC-0000128',
      'body': 'Order assigned to rider Ramon Castillo (#RIDER-027). Delivery in progress in Malolos City.',
      'time': '5 mins ago',
      'category': 'Orders',
      'isUnread': true,
      'icon': Icons.local_shipping_rounded,
      'iconColor': const Color(0xFFFF5622),
      'bgColor': const Color(0xFFFFF3E0),
    },
    {
      'id': 'AN-002',
      'title': 'Rider Verification Request',
      'body': 'New rider Carlos Reyes (#RIDER-018) submitted government ID & license documents for admin review.',
      'time': '25 mins ago',
      'category': 'Riders',
      'isUnread': true,
      'icon': Icons.two_wheeler_rounded,
      'iconColor': const Color(0xFF1565C0),
      'bgColor': const Color(0xFFE3F2FD),
    },
    {
      'id': 'AN-003',
      'title': 'Daily Revenue Milestone Reached!',
      'body': 'GoCrave gross platform transactions crossed ₱28,450 for today (+15% vs yesterday).',
      'time': '1 hour ago',
      'category': 'System',
      'isUnread': true,
      'icon': Icons.payments_rounded,
      'iconColor': const Color(0xFF2E7D32),
      'bgColor': const Color(0xFFE8F5E9),
    },
    {
      'id': 'AN-004',
      'title': 'Merchant Stock Alert - KFC',
      'body': 'KFC Central Branch marked "Chicken Bucket" back in stock.',
      'time': '2 hours ago',
      'category': 'Orders',
      'isUnread': false,
      'icon': Icons.store_rounded,
      'iconColor': const Color(0xFF7C3AED),
      'bgColor': const Color(0xFFF3E8FF),
    },
    {
      'id': 'AN-005',
      'title': 'System Security Backup Complete',
      'body': 'Automated database snapshot backup completed successfully.',
      'time': '5 hours ago',
      'category': 'System',
      'isUnread': false,
      'icon': Icons.verified_user_rounded,
      'iconColor': const Color(0xFF0284C7),
      'bgColor': const Color(0xFFE0F2FE),
    },
  ];

  void _markAllAsRead() {
    setState(() {
      for (var n in _notifications) {
        n['isUnread'] = false;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('All admin notifications marked as read.', style: GoogleFonts.poppins()),
        backgroundColor: brandColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = _notifications.where((n) => n['isUnread'] == true).length;

    final filteredList = _notifications.where((n) {
      if (_selectedFilterIndex == 0) return true;
      if (_selectedFilterIndex == 1) return n['isUnread'] == true;
      final categoryFilter = _filters[_selectedFilterIndex].toLowerCase();
      return n['category'].toString().toLowerCase().contains(categoryFilter);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0F172A), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Text(
              'Admin Notifications',
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
            if (unreadCount > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: brandColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$unreadCount',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: _markAllAsRead,
            child: Text(
              'Mark All Read',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: brandColor,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: SizedBox(
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
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? brandColor : const Color(0xFFF1F3F5),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          _filters[idx],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? Colors.white : const Color(0xFF475569),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          Expanded(
            child: filteredList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_off_outlined, size: 60, color: Colors.grey[300]),
                        const SizedBox(height: 12),
                        Text(
                          'No Notifications Found',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final item = filteredList[index];
                      return _buildNotificationCard(item);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> item) {
    final bool isUnread = item['isUnread'] == true;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isUnread ? const Color(0xFFFFF8F5) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isUnread ? brandColor.withOpacity(0.3) : const Color(0xFFEEEEEE),
          width: isUnread ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            item['isUnread'] = !isUnread;
          });
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                item['icon'] as IconData,
                color: item['iconColor'] as Color,
                size: 22,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item['title'].toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        if (isUnread)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: brandColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['body'].toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF475569),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['time'].toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF94A3B8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
