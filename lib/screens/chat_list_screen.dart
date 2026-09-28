import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final List<Map<String, dynamic>> _conversations = [
    {
      'id': '1',
      'name': 'Ramon Castillo',
      'role': 'Delivery Rider',
      'roleColor': const Color(0xFF2E7D32),
      'roleBg': const Color(0xFFE8F5E9),
      'avatar': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&auto=format&fit=crop',
      'lastMessage': 'Nasa biyahe na po ako papunta dyan dala ang order nyo.',
      'time': '2 mins ago',
      'unreadCount': 1,
      'isOnline': true,
      'orderId': '#GOC98231',
    },
    {
      'id': '2',
      'name': 'GoCrave Central Kitchen',
      'role': 'Restaurant Merchant',
      'roleColor': const Color(0xFFE65100),
      'roleBg': const Color(0xFFFFF3E0),
      'avatar': 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?q=80&w=200&auto=format&fit=crop',
      'lastMessage': 'Niluluto na po ang inyong inorder na Juicy Beef Burger.',
      'time': '15 mins ago',
      'unreadCount': 0,
      'isOnline': true,
      'orderId': '#GOC98231',
    },
    {
      'id': '3',
      'name': 'GoCrave Customer Support',
      'role': '24/7 Help Desk',
      'roleColor': const Color(0xFF1565C0),
      'roleBg': const Color(0xFFE3F2FD),
      'avatar': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop',
      'lastMessage': 'Hi Alexander! How can we assist you with your GoCrave account today?',
      'time': 'Yesterday',
      'unreadCount': 0,
      'isOnline': true,
      'orderId': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    const Color brandColor = Color(0xFFFF5622);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Messages & Support',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Active chats with riders & restaurants',
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F3F5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search rider or restaurant chat...',
                        hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 13),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _conversations.length,
              itemBuilder: (context, index) {
                final chat = _conversations[index];
                return _buildConversationCard(context, chat, brandColor);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversationCard(BuildContext context, Map<String, dynamic> chat, Color brandColor) {
    final bool hasUnread = (chat['unreadCount'] as int) > 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            chat['unreadCount'] = 0;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                name: chat['name'],
                image: chat['avatar'],
                role: chat['role'],
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage(chat['avatar']),
                  ),
                  if (chat['isOnline'] == true)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
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
                        Expanded(
                          child: Text(
                            chat['name'],
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          chat['time'],
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: hasUnread ? brandColor : Colors.grey[400],
                            fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: chat['roleBg'] as Color,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            chat['role'],
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: chat['roleColor'] as Color,
                            ),
                          ),
                        ),
                        if (chat['orderId'] != null) ...[
                          const SizedBox(width: 6),
                          Text(
                            chat['orderId'],
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      chat['lastMessage'],
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: hasUnread ? Colors.black87 : Colors.grey[500],
                        fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (hasUnread) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF5622),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${chat['unreadCount']}',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
