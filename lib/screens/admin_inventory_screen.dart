import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/inventory_manager.dart';

class AdminInventoryScreen extends StatefulWidget {
  final Color brandColor;

  const AdminInventoryScreen({
    super.key,
    this.brandColor = const Color(0xFFFF5622),
  });

  @override
  State<AdminInventoryScreen> createState() => _AdminInventoryScreenState();
}

class _AdminInventoryScreenState extends State<AdminInventoryScreen> {
  final InventoryManager _inventoryManager = InventoryManager();

  @override
  void initState() {
    super.initState();
    _inventoryManager.addListener(_onInventoryChanged);
  }

  @override
  void dispose() {
    _inventoryManager.removeListener(_onInventoryChanged);
    super.dispose();
  }

  void _onInventoryChanged() {
    if (mounted) {
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = _inventoryManager.inventoryItems;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: widget.brandColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Global Menu & Inventory Stock Central',
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        itemCount: items.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 14);
        },
        itemBuilder: (context, index) {
          final item = items[index];
          final bool inStock = item['inStock'];

          return Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['itemName'],
                        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                      ),
                      Text(
                        'Store: ${item['store']} • Price: ${item['price']}',
                        style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Switch.adaptive(
                      value: inStock,
                      activeColor: const Color(0xFF10B981),
                      onChanged: (val) {
                        _inventoryManager.toggleStock(item['id']);
                      },
                    ),
                    Text(
                      inStock ? 'In Stock' : 'Out of Stock',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: inStock ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
