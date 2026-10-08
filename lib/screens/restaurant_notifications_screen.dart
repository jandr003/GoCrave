import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantNotificationsScreen extends StatefulWidget {
  const RestaurantNotificationsScreen({super.key});

  @override
  State<RestaurantNotificationsScreen> createState() => _RestaurantNotificationsScreenState();
}

class _RestaurantNotificationsScreenState extends State<RestaurantNotificationsScreen> {
  final Color brandColor = const Color(0xFFFF5622);
  int _selectedFilterIndex = 0;

  final List<String> _filters = ['All', 'Orders', 'Riders', 'Stock', 'System'];

  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'title': 'New Incoming Customer Order',
      'body': 'New order request #GOC98231 received from Sofia Mendoza (Total Bill: ₱465.00).',
      'time': '2 mins ago',
      'category': 'Orders',
      'icon': Icons.notifications_active_rounded,
      'iconColor': const Color(0xFFFF5622),
      'iconBg': const Color(0xFFFFF3E0),
      'isUnread': true,
    },
    {
      'id': '2',
      'title': 'Rider Arrived at Restaurant',
      'body': 'Rider Ramon Castillo (Honda Click • MVC 1234) has arrived to pick up Order #GOC65112.',
      'time': '15 mins ago',
      'category': 'Riders',
      'icon': Icons.two_wheeler_rounded,
      'iconColor': const Color(0xFF1565C0),
      'iconBg': const Color(0xFFE3F2FD),
      'isUnread': true,
    },
    {
      'id': '3',
      'title': 'Low Inventory Stock Warning',
      'body': 'Pepperoni Feast Pizza stock is running low. Please check ingredient inventory.',
      'time': '1 hour ago',
      'category': 'Stock',
      'icon': Icons.warning_amber_rounded,
      'iconColor': Colors.amber[900],
      'iconBg': Colors.amber[50],
      'isUnread': false,
    },
    {
      'id': '4',
      'title': 'Daily Sales Target Reached!',
      'body': 'Great job! Malolos Branch sales reached ₱14,850.00 today across 28 orders.',
      'time': '3 hours ago',
      'category': 'System',
      'icon': Icons.monetization_on_rounded,
      'iconColor': const Color(0xFF2E7D32),
      'iconBg': const Color(0xFFE8F5E9),
      'isUnread': false,
    },
    {
      'id': '5',
      'title': '5-Star Merchant Review Received',
      'body': 'Customer Maria Clara rated GoCrave Central Kitchen 5 Stars: "Delicious & fast!"',
      'time': 'Yesterday',
      'category': 'System',
      'icon': Icons.star_rounded,
      'iconColor': Colors.amber[900],
      'iconBg': Colors.amber[50],
      'isUnread': false,
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
        content: Text('All merchant notifications marked as read.', style: GoogleFonts.poppins()),
        backgroundColor: brandColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _notifications.where((n) {
      if (_selectedFilterIndex == 0) return true;
      final selectedCategory = _filters[_selectedFilterIndex];
      return n['category'] == selectedCategory;
    }).toList();

    final unreadCount = _notifications.where((n) => n['isUnread'] == true).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Merchant Notifications',
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F172A),
          ),
        ),
        centerTitle: false,
        actions: [
          if (unreadCount > 0)
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
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips Row
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: Colors.white,
            child: SizedBox(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _filters.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedFilterIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: InkWell(
                      onTap: () => setState(() => _selectedFilterIndex = index),
                      borderRadius: BorderRadius.circular(16),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? brandColor : const Color(0xFFF1F3F5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          _filters[index],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Notifications List
          Expanded(
            child: filteredList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_off_outlined, size: 60, color: Colors.grey[300]),
                        const SizedBox(height: 12),
                        Text(
                          'No Merchant Notifications',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final notif = filteredList[index];
                      return _buildNotificationCard(notif);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notif) {
    final bool isUnread = notif['isUnread'] == true;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: notif['iconBg'] as Color,
              shape: BoxShape.circle,
            ),
            child: Icon(notif['icon'] as IconData, color: notif['iconColor'] as Color, size: 22),
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
                        notif['title'],
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      notif['time'],
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: isUnread ? brandColor : Colors.grey[400],
                        fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notif['body'],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          if (isUnread) ...[
            const SizedBox(width: 8),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: brandColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
