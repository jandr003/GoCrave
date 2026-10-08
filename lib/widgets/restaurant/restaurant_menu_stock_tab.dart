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
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(food['image']!, width: 50, height: 50, fit: BoxFit.cover),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
                      Text('${food['category']} • ${food['price']}', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
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
