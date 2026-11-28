import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/user_profile.dart';
import '../../data/cart_manager.dart';
import '../../screens/cart_screen.dart';
import '../voice_search_modal.dart';

class DashboardHeader extends StatelessWidget {
  final VoidCallback onSearchTap;

  const DashboardHeader({
    super.key,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Transform.translate(
                    offset: const Offset(0, -4),
                    child: Image.asset(
                      'assets/images/gocrave_app_logo.png',
                      height: 42,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Welcome to',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF5A6275),
                          ),
                        ),
                        SizedBox(
                          height: 42,
                          child: Transform.translate(
                            offset: const Offset(-18, 0),
                            child: Transform.scale(
                              scale: 2.6,
                              alignment: Alignment.centerLeft,
                              child: Image.asset(
                                'assets/images/gocrave_official_logo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const CartScreen();
                    },
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                      size: 22,
                      color: Colors.deepOrangeAccent,
                    ),
                    if (CartManager().items.isNotEmpty)
                      Positioned(
                        right: -2,
                        top: -2,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF5622),
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 14,
                            minHeight: 14,
                          ),
                          child: Text(
                            CartManager().items.fold<int>(0, (sum, i) {
                              return sum + i.quantity;
                            }).toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: UserProfile().profilePic.isNotEmpty
                      ? NetworkImage(UserProfile().profilePic)
                      : null,
                  child: UserProfile().profilePic.isEmpty
                      ? const Icon(Icons.person, color: Colors.grey)
                      : null,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        GestureDetector(
          onTap: onSearchTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 56,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'What are you craving for?',
                    style: GoogleFonts.poppins(color: Colors.grey),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.mic_rounded,
                    color: Color(0xFFFF5622),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                      ),
                      builder: (context) {
                        return const VoiceSearchModal(
                          brandColor: Color(0xFFFF5622),
                        );
                      },
                    );
                  },
                ),
                const Icon(Icons.tune, color: Colors.deepOrangeAccent),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
