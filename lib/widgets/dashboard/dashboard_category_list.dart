import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/food_data.dart';
import '../../screens/category_detail_screen.dart';

class DashboardCategoryList extends StatelessWidget {
  const DashboardCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          _buildCategoryItem(
            context,
            'Fast Food',
            Icons.fastfood_rounded,
            'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=600&auto=format&fit=crop',
          ),
          _buildCategoryItem(
            context,
            'Home-Style',
            Icons.restaurant_rounded,
            'https://images.unsplash.com/photo-1547592166-23ac45744acd?q=80&w=600&auto=format&fit=crop',
          ),
          _buildCategoryItem(
            context,
            'Vegetarian',
            Icons.eco_rounded,
            'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=600&auto=format&fit=crop',
          ),
          _buildCategoryItem(
            context,
            'Drinks',
            Icons.local_drink_rounded,
            'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?q=80&w=600&auto=format&fit=crop',
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, String label, IconData iconData, String imageUrl) {
    return InkWell(
      onTap: () {
        final filteredItems = allFoodItems.where((item) {
          return item['category'] == label;
        }).toList();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CategoryDetailScreen(
                categoryName: label,
                foodItems: filteredItems,
              );
            },
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  iconData,
                  size: 14,
                  color: const Color(0xFFFF5622),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
