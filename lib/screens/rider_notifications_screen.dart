import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderNotificationsScreen extends StatefulWidget {
  const RiderNotificationsScreen({super.key});

  @override
  State<RiderNotificationsScreen> createState() => _RiderNotificationsScreenState();
}

class _RiderNotificationsScreenState extends State<RiderNotificationsScreen> {
  final Color brandColor = const Color(0xFFFF5622);
  int _selectedFilterIndex = 0;

  final List<String> _filters = ['All', 'Orders', 'Earnings', 'System'];

  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'title': 'New Delivery Request Available',
      'body': 'New order request #GOC98231 from Jollibee - Malolos (₱85.00 Payout • 2.4 km).',
      'time': '2 mins ago',
      'category': 'Orders',
      'icon': Icons.radar_rounded,
      'iconColor': const Color(0xFFFF5622),
      'iconBg': const Color(0xFFFFF3E0),
      'isUnread': true,
    },
    {
      'id': '2',
      'title': 'GCash Payout Transferred',
      'body': '₱1,450.00 weekly earnings successfully transferred to your GCash Account.',
      'time': '1 hour ago',
      'category': 'Earnings',
      'icon': Icons.account_balance_wallet_rounded,
      'iconColor': const Color(0xFF2E7D32),
      'iconBg': const Color(0xFFE8F5E9),
      'isUnread': true,
    },
    {
      'id': '3',
      'title': 'Customer Message Received',
      'body': 'Maria Clara: "Please be careful on the road. Thank you!"',
      'time': '3 hours ago',
      'category': 'Orders',
      'icon': Icons.chat_bubble_rounded,
      'iconColor': Colors.blueAccent,
      'iconBg': const Color(0xFFE3F2FD),
      'isUnread': false,
    },
    {
      'id': '4',
      'title': '5-Star Rating & Tip Added!',
      'body': 'Customer Juan Tamad rated your delivery 5 Stars + added ₱20.00 Tip!',
      'time': 'Yesterday',
      'category': 'Earnings',
      'icon': Icons.star_rounded,
      'iconColor': Colors.amber[900],
      'iconBg': Colors.amber[50],
      'isUnread': false,
    },
    {
      'id': '5',
      'title': 'PhilSys Government ID Verified',
      'body': 'Your PhilSys National ID (#PH-NID-88123-90) was verified by GoCrave Logistics.',
      'time': '2 days ago',
      'category': 'System',
      'icon': Icons.verified_user_rounded,
      'iconColor': Colors.teal,
      'iconBg': const Color(0xFFE0F2F1),
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
        content: Text('All notifications marked as read.', style: GoogleFonts.poppins()),
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
          'Rider Notifications',
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
