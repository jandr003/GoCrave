import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'profile_screen.dart';
import 'browse_menu_screen.dart';
import 'orders_screen.dart';
import 'favorites_screen.dart';
import 'cart_screen.dart';
import 'chat_list_screen.dart';

class MainNavWrapper extends StatefulWidget {
  final int initialIndex;
  const MainNavWrapper({super.key, this.initialIndex = 0});

  @override
  State<MainNavWrapper> createState() => _MainNavWrapperState();
}

class _MainNavWrapperState extends State<MainNavWrapper> {
  late int _currentIndex;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _screens = [
      DashboardScreen(
        onSearchTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BrowseMenuScreen(showBackButton: true)),
          );
        },
      ),
      const FavoritesScreen(),
      const OrdersScreen(),
      const ChatListScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFFFF5622),
          unselectedItemColor: Colors.grey[500],
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11.5),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded, size: 22),
              activeIcon: Icon(Icons.grid_view_rounded, size: 25),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_rounded, size: 22),
              activeIcon: Icon(Icons.favorite_rounded, size: 25),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_mall_outlined, size: 22),
              activeIcon: Icon(Icons.local_mall_rounded, size: 25),
              label: 'My Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.forum_outlined, size: 22),
              activeIcon: Icon(Icons.forum_rounded, size: 25),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined, size: 22),
              activeIcon: Icon(Icons.account_circle_rounded, size: 25),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
