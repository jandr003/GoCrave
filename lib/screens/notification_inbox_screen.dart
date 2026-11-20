import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/notification_inbox_manager.dart';

class NotificationInboxScreen extends StatefulWidget {
  final Color brandColor;

  const NotificationInboxScreen({
    super.key,
    this.brandColor = const Color(0xFFFF5622),
  });

  @override
  State<NotificationInboxScreen> createState() {
    return _NotificationInboxScreenState();
  }
}

class _NotificationInboxScreenState extends State<NotificationInboxScreen> {
  final NotificationInboxManager _inboxManager = NotificationInboxManager();
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['All', 'Orders', 'Promos', 'System'];

  @override
  void initState() {
    super.initState();
    _inboxManager.addListener(_onInboxChanged);
  }

  @override
  void dispose() {
    _inboxManager.removeListener(_onInboxChanged);
    super.dispose();
  }

  void _onInboxChanged() {
    if (mounted) {
      setState(() {
        
      });
    }
  }

  List<InboxNotificationItem> get _filteredNotifications {
    final notifications = _inboxManager.notifications;
    if (_selectedFilterIndex == 0) {
      return notifications;
    }
    final categoryFilter = _filters[_selectedFilterIndex];
    return notifications.where((n) {
      return n.category == categoryFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredNotifications;
    int unreadCount = 0;
    for (var n in _inboxManager.notifications) {
      if (n.isUnread) {
        unreadCount++;
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF0F172A),
            size: 18,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Text(
              'Notifications',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
            if (unreadCount > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: widget.brandColor,
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
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {
              _inboxManager.markAllAsRead();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'All notifications marked as read.',
                    style: GoogleFonts.poppins(),
                  ),
                  backgroundColor: widget.brandColor,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Text(
              'Mark All Read',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: widget.brandColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? widget.brandColor
                              : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? widget.brandColor
                                : const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: Text(
                          _filters[idx],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w600,
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF64748B),
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
                      'No notifications in this category',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  )
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    itemCount: filtered.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 14);
                    },
                    itemBuilder: (context, index) {
                      final item = filtered[index];

                      return InkWell(
                        onTap: () {
                          _inboxManager.markAsRead(item.id);
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: item.isUnread
                                ? const Color(0xFFFFF8F5)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: item.isUnread
                                  ? widget.brandColor.withOpacity(0.3)
                                  : const Color(0xFFE2E8F0),
                              width: item.isUnread ? 1.5 : 1.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: widget.brandColor
                                              .withOpacity(0.12),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          item.category,
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: widget.brandColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      if (item.isUnread)
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: widget.brandColor,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                    ],
                                  ),
                                  Text(
                                    item.timestamp,
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      color: const Color(0xFF94A3B8),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                item.title,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.body,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF475569),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
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
