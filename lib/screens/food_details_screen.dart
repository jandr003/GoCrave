import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/order_manager.dart';
import '../data/favorite_manager.dart';
import '../data/cart_manager.dart';
import '../data/review_data.dart';
import 'main_nav_wrapper.dart';

class FoodDetailsScreen extends StatefulWidget {
  final Map<String, String> foodItem;

  const FoodDetailsScreen({super.key, required this.foodItem});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int _quantity = 1;
  bool _isFavorite = false;
  bool _isDescriptionExpanded = false;
  int _selectedReviewStar = 5;
  final Color brandColor = const Color(0xFFFF5622);

  @override
  void initState() {
    super.initState();
    _isFavorite = FavoriteManager().isFavorite(widget.foodItem['title']!);
  }

  double get _itemPrice {
    return double.tryParse(widget.foodItem['price']?.replaceAll('₱', '') ?? '0') ?? 0;
  }

  double get _totalPrice => _itemPrice * _quantity;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final itemTitle = widget.foodItem['title']!;
    final itemReviews = mockReviews.where((r) => r.foodTitle == itemTitle).toList();
    final filteredReviews = itemReviews.where((r) => r.stars == _selectedReviewStar).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.45,
            child: Image.network(
              widget.foodItem['image']!,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFloatingButton(
                  icon: Icons.arrow_back_ios_new,
                  onTap: () => Navigator.pop(context),
                ),
                _buildFloatingButton(
                  icon: _isFavorite ? Icons.favorite : Icons.favorite_border,
                  iconColor: _isFavorite ? Colors.red : Colors.black,
                  onTap: () {
                    FavoriteManager().toggleFavorite(widget.foodItem);
                    setState(() => _isFavorite = !_isFavorite);
                  },
                ),
              ],
            ),
          ),
          Positioned.fill(
            top: size.height * 0.4,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 140),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 48,
                        width: 130,
                        decoration: BoxDecoration(
                          color: brandColor,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: brandColor.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildQtyBtn(Icons.remove, () {
                              if (_quantity > 1) setState(() => _quantity--);
                            }),
                            Text(
                              _quantity.toString().padLeft(2, '0'),
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            _buildQtyBtn(Icons.add, () {
                              setState(() => _quantity++);
                            }),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.foodItem['title']!,
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              widget.foodItem['rating']!,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[400],
                              ),
                            ),
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isDescriptionExpanded
                              ? (widget.foodItem['longDescription'] ?? '')
                              : ((widget.foodItem['longDescription']?.length ?? 0) > 100
                                  ? '${widget.foodItem['longDescription']?.substring(0, 100)}...'
                                  : (widget.foodItem['longDescription'] ?? '')),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[500],
                            height: 1.6,
                          ),
                        ),
                        if ((widget.foodItem['longDescription']?.length ?? 0) > 100)
                          GestureDetector(
                            onTap: () => setState(() => _isDescriptionExpanded = !_isDescriptionExpanded),
                            child: Text(
                              _isDescriptionExpanded ? ' Show Less' : ' Read More',
                              style: GoogleFonts.poppins(
                                color: brandColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildNutriInfo(Icons.access_time, widget.foodItem['time'] ?? '10-15 Min', Colors.redAccent),
                        _buildNutriInfo(
                          Icons.whatshot,
                          widget.foodItem['spice'] ?? 'Mild',
                          (widget.foodItem['spice'] == 'Spicy') ? Colors.red : Colors.orangeAccent,
                        ),
                        _buildNutriInfo(Icons.local_fire_department, widget.foodItem['kcal'] ?? '150 Kcal', Colors.red),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Toppings',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: (widget.foodItem['ingredients'] ?? '').split(',').map((emoji) {
                          return _buildToppingIcon(emoji);
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reviews',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '(${itemReviews.length})',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [5, 4, 3, 2, 1].map((star) {
                          final isSelected = _selectedReviewStar == star;
                          return Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: InkWell(
                              onTap: () => setState(() => _selectedReviewStar = star),
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected ? brandColor : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: isSelected ? brandColor : Colors.grey[200]!),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.star, color: isSelected ? Colors.white : Colors.amber, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      star.toString(),
                                      style: GoogleFonts.poppins(
                                        color: isSelected ? Colors.white : Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (filteredReviews.isEmpty)
                      Center(
                        child: Text(
                          'No reviews for this rating yet.',
                          style: GoogleFonts.poppins(color: Colors.grey[500]),
                        ),
                      )
                    else
                      ...filteredReviews.map((review) => _buildReviewItem(review)).toList(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total Price',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[400],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '₱${_totalPrice.toInt()}',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '₱${(_totalPrice * 1.2).toInt()}',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[400],
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => _handleOrder(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: brandColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                            const SizedBox(width: 12),
                            Text(
                              'Add to Bag',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(Review review) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(review.userImage),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      review.date,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < review.stars ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 14,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review.comment,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          if (review.reviewImage != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                review.reviewImage!,
                height: 100,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFloatingButton({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = Colors.black,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: iconColor),
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }

  Widget _buildNutriInfo(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildToppingIcon(String emoji) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Center(
        child: Text(emoji, style: const TextStyle(fontSize: 24)),
      ),
    );
  }

  void _handleOrder(BuildContext context) {
    CartManager().addItem(widget.foodItem, _quantity);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainNavWrapper(initialIndex: 2)),
      (route) => false,
    );
  }
}
