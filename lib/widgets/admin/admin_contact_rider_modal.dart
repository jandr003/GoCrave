import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../screens/chat_screen.dart';

class AdminContactRiderModal extends StatelessWidget {
  final Map<String, dynamic> rider;
  final Color brandColor;

  const AdminContactRiderModal({
    super.key,
    required this.rider,
    required this.brandColor,
  });

  @override
  Widget build(BuildContext context) {
    final String riderName = rider['rider']?.toString() ?? rider['name']?.toString() ?? 'Ramon Castillo (#RIDER-027)';
    final String riderPhone = rider['riderPhone']?.toString() ?? rider['phone']?.toString() ?? '0917 123 4567';
    final String riderAvatar = rider['riderAvatar']?.toString() ?? rider['avatar']?.toString() ?? 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&auto=format&fit=crop';
    final String orderId = rider['id']?.toString() ?? rider['orderId']?.toString() ?? '#GC-0000128';

    return Container(
      padding: EdgeInsets.fromLTRB(24, 16, 24, MediaQuery.of(context).viewInsets.bottom + 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Contact Assigned Rider',
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
              ),
              IconButton(icon: const Icon(Icons.close_rounded, color: Colors.grey), onPressed: () => Navigator.pop(context)),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF5F2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFFFE0B2), width: 1.5),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundImage: NetworkImage(riderAvatar),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        riderName,
                        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Text(
                        'Honda Click 125i • Plate: MVC 1234',
                        style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600]),
                      ),
                      Row(
                        children: [
                          Icon(Icons.phone_outlined, size: 12, color: brandColor),
                          const SizedBox(width: 4),
                          Text(
                            riderPhone,
                            style: GoogleFonts.poppins(fontSize: 11, color: brandColor, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Text(
            'Choose Contact Action',
            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
          ),
          const SizedBox(height: 10),

          _buildActionTile(
            context,
            icon: Icons.phone_in_talk_rounded,
            title: 'Voice Call Rider ($riderPhone)',
            subtitle: 'Direct phone call line to rider',
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Calling $riderName at $riderPhone...', style: GoogleFonts.poppins()),
                  backgroundColor: brandColor,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),

          const SizedBox(height: 10),

          _buildActionTile(
            context,
            icon: Icons.chat_bubble_rounded,
            title: 'Live Chat Messaging',
            subtitle: 'Send real-time 2-way chat message for $orderId',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    name: riderName,
                    image: riderAvatar,
                    role: 'Rider ($orderId)',
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 10),

          _buildActionTile(
            context,
            icon: Icons.sms_rounded,
            title: 'Send SMS Direct Message',
            subtitle: 'Send cellular text notification to rider',
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('SMS prompt opened for $riderPhone', style: GoogleFonts.poppins()),
                  backgroundColor: Colors.blueAccent,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFEEEEEE)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: brandColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: brandColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black)),
                  Text(subtitle, style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[500])),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
