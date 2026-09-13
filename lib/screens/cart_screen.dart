import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/cart_manager.dart';
import '../data/order_manager.dart';
import 'coupon_screen.dart';
import 'main_nav_wrapper.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Color brandColor = const Color(0xFFFF5622);

  @override
  void initState() {
    super.initState();
    CartManager().addListener(_updateState);
  }

  @override
  void dispose() {
    CartManager().removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartManager();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainNavWrapper(initialIndex: 0)),
              (route) => false,
            );
          },
        ),
        title: Text(
          'My Cart',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: cart.items.isEmpty
          ? _buildEmptyState()
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  // Cart Items
                  ...cart.items.map((item) => _buildCartItemCard(item)).toList(),

                  const SizedBox(height: 8),

                  // Promo Code
                  _buildSectionCard(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CouponScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.percent,
                              size: 20,
                              color: cart.appliedCouponCode != null ? brandColor : Colors.black,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            cart.appliedCouponCode ?? 'Promo Code',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: cart.appliedCouponCode != null ? brandColor : Colors.black,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            cart.appliedCouponCode != null ? 'Change' : 'Add code',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: brandColor,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),

                  // Delivery Address
                  _buildSectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery Address',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Change',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: brandColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: brandColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.location_on, size: 20, color: brandColor),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Metro Manila, Philippines',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '1230 España Blvd, Sampaloc, Manila',
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Delivery Note
                  _buildSectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery Note (Optional)',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFBFBFB),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: TextField(
                            maxLines: 2,
                            decoration: InputDecoration(
                              hintText: 'e.g. Please leave the food at the door...',
                              hintStyle: GoogleFonts.poppins(color: Colors.grey[300], fontSize: 14),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
      bottomSheet: cart.items.isEmpty ? null : _buildCheckoutBar(cart),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'Your cart is empty.',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemCard(CartItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              item.foodItem['image']!,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.foodItem['title']!,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  item.foodItem['subtitle']!,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      item.foodItem['rating']!,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: brandColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '20% Off',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: brandColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              _buildSmallQtyBtn(Icons.add, () => CartManager().updateQuantity(item.foodItem['title']!, 1)),
              const SizedBox(height: 8),
              Text(
                item.quantity.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildSmallQtyBtn(Icons.remove, () => CartManager().updateQuantity(item.foodItem['title']!, -1)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallQtyBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: brandColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 14, color: Colors.white),
      ),
    );
  }

  Widget _buildSectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: child,
    );
  }

  Widget _buildCheckoutBar(CartManager cart) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (cart.discountAmount > 0)
                Text(
                  '- ₱${cart.discountAmount.toStringAsFixed(2)} discount',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              Text(
                'Total Amount',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[400],
                ),
              ),
              Text(
                '₱${cart.totalAmount.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: brandColor,
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: _SwipeToCheckoutButton(
              onCompleted: () {
                // Place orders and clear cart
                for (var item in cart.items) {
                  for (int i = 0; i < item.quantity; i++) {
                    OrderManager().placeOrder(item.foodItem);
                  }
                }
                cart.clearCart();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MainNavWrapper(initialIndex: 2)),
                  (route) => false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SwipeToCheckoutButton extends StatefulWidget {
  final VoidCallback onCompleted;
  const _SwipeToCheckoutButton({required this.onCompleted});

  @override
  State<_SwipeToCheckoutButton> createState() => __SwipeToCheckoutButtonState();
}

class __SwipeToCheckoutButtonState extends State<_SwipeToCheckoutButton> {
  double _position = 0;
  final double _buttonWidth = 240;
  final double _thumbSize = 50;

  @override
  Widget build(BuildContext context) {
    final double maxPosition = _buttonWidth - _thumbSize - 8;

    return Container(
      height: 60,
      width: _buttonWidth,
      decoration: BoxDecoration(
        color: const Color(0xFFFF5622),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Center(
            child: Text(
              'Swipe to Checkout',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: 4 + _position,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _position += details.delta.dx;
                  if (_position < 0) _position = 0;
                  if (_position > maxPosition) _position = maxPosition;
                });
              },
              onHorizontalDragEnd: (details) {
                if (_position >= maxPosition * 0.8) {
                  widget.onCompleted();
                } else {
                  setState(() {
                    _position = 0;
                  });
                }
              },
              child: Container(
                width: _thumbSize,
                height: _thumbSize,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.double_arrow, color: Color(0xFFFF5622)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
