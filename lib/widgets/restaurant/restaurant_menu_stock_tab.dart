import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/food_data.dart';

class RestaurantMenuStockTab extends StatelessWidget {
  final Map<String, bool> merchantStockStatus;
  final Color brandColor;
  final Function(String title, bool inStock) onToggleStock;

  const RestaurantMenuStockTab({
    super.key,
    required this.merchantStockStatus,
    required this.brandColor,
    required this.onToggleStock,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Restaurant Menu Inventory & Availability', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
        const SizedBox(height: 14),
        ...allFoodItems.map((food) {
          final title = food['title']!;
          final inStock = merchantStockStatus[title] ?? true;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
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
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    food['image']!,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: inStock ? const Color(0xFFE8F5E9) : Colors.red[50],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              inStock ? 'IN STOCK' : 'OUT OF STOCK',
                              style: GoogleFonts.poppins(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: inStock ? const Color(0xFF2E7D32) : Colors.redAccent,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            food['price']!,
                            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: brandColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: inStock,
                  activeColor: brandColor,
                  onChanged: (val) => onToggleStock(title, val),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
