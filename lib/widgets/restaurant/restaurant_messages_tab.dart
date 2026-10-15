import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'merchant_chat_detail_modal.dart';

class RestaurantMessagesTab extends StatefulWidget {
  final Color brandColor;

  const RestaurantMessagesTab({
    super.key,
    required this.brandColor,
  });

  @override
  State<RestaurantMessagesTab> createState() => _RestaurantMessagesTabState();
}

class _RestaurantMessagesTabState extends State<RestaurantMessagesTab> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['All', 'Customer Chats', 'Rider Chats'];

  final List<Map<String, dynamic>> _chatThreads = [
    {
      'id': 'c1',
      'name': 'Sofia Mendoza',
      'role': 'Customer',
      'orderId': '#GOC98231',
      'lastMessage': 'Note: Please add extra secret sauce for the burger.',
      'time': 'Just now',
      'avatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop',
      'isUnread': true,
    },
    {
      'id': 'r1',
      'name': 'Ramon Castillo',
      'role': 'Rider',
      'orderId': '#GOC65112',
      'lastMessage': 'I am 2 mins away from the restaurant for food pickup.',
      'time': '2 mins ago',
      'avatar': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&auto=format&fit=crop',
      'isUnread': true,
    },
    {
      'id': 'c2',
      'name': 'Marco Valenzuela',
      'role': 'Customer',
      'orderId': '#GOC88123',
      'lastMessage': 'Hi! Is my Pepperoni Feast Pizza almost ready for pickup?',
      'time': '5 mins ago',
      'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=200&auto=format&fit=crop',
      'isUnread': false,
    },
    {
      'id': 'r2',
      'name': 'Maximo Santos',
      'role': 'Rider',
      'orderId': '#GOC54311',
      'lastMessage': 'Packed order received. Heading to customer location now.',
      'time': '25 mins ago',
      'avatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop',
      'isUnread': false,
    },
  ];

  void _openChatModal(Map<String, dynamic> thread) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return MerchantChatDetailModal(
          chatThread: thread,
          brandColor: widget.brandColor,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredThreads = _chatThreads.where((thread) {
      if (_selectedFilterIndex == 0) return true;
      if (_selectedFilterIndex == 1) return thread['role'] == 'Customer';
      if (_selectedFilterIndex == 2) return thread['role'] == 'Rider';
      return true;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Merchant Messages & Live Communications',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
        ),
        const SizedBox(height: 12),

        SizedBox(
          height: 38,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
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
                      color: isSelected ? widget.brandColor : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? widget.brandColor : const Color(0xFFEEEEEE),
                      ),
                    ),
                    child: Text(
                      _filters[index],
                      style: GoogleFonts.poppins(
                        fontSize: 12,
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

        ...filteredThreads.map((thread) {
          final bool isUnread = thread['isUnread'] == true;
          final bool isRider = thread['role'] == 'Rider';

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () {
                setState(() => thread['isUnread'] = false);
                _openChatModal(thread);
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isUnread ? const Color(0xFFFFF8F5) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isUnread ? widget.brandColor.withOpacity(0.3) : const Color(0xFFEEEEEE),
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
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: widget.brandColor,
                          backgroundImage: NetworkImage(thread['avatar']),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: isRider ? const Color(0xFFFF5622) : const Color(0xFF1565C0),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Icon(
                              isRider ? Icons.two_wheeler_rounded : Icons.person_rounded,
                              color: Colors.white,
                              size: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                thread['name'],
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              Text(
                                thread['time'],
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: isUnread ? widget.brandColor : Colors.grey[400],
                                  fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                decoration: BoxDecoration(
                                  color: isRider ? const Color(0xFFFFF3E0) : const Color(0xFFE3F2FD),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '${thread['role']} • ${thread['orderId']}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: isRider ? widget.brandColor : const Color(0xFF1565C0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            thread['lastMessage'],
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: isUnread ? Colors.black87 : Colors.grey[600],
                              fontWeight: isUnread ? FontWeight.w600 : FontWeight.normal,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
                          color: widget.brandColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
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
