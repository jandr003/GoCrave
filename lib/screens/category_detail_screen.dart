import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/food_card.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String categoryName;
  final List<Map<String, String>> foodItems;

  const CategoryDetailScreen({
    super.key,
    required this.categoryName,
    required this.foodItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          categoryName,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: foodItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.restaurant_menu, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text(
                    'No items found in this category.',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: foodItems.length,
              itemBuilder: (context, index) {
                final item = foodItems[index];
                return FoodCard(
                  title: item['title']!,
                  subtitle: item['subtitle']!,
                  price: item['price']!,
                  rating: item['rating']!,
                  imageUrl: item['image']!,
                );
              },
            ),
    );
  }
}
