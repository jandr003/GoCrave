import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AgreementModal extends StatefulWidget {
  const AgreementModal({super.key});

  @override
  State<AgreementModal> createState() => _AgreementModalState();
}

class _AgreementModalState extends State<AgreementModal> {
  final ScrollController _scrollController = ScrollController();
  bool _hasReachedBottom = false;
  final Color brandColor = const Color(0xFFFF5622);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (!_hasReachedBottom) {
        setState(() {
          _hasReachedBottom = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'User Agreement & Privacy Policy',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.grey),
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.all(24.0),
              children: [
                _buildSection('1. Introduction', 
                  'Welcome to GoCrave. By using our app, you agree to these terms. Please read them carefully to understand your rights and obligations while using our food delivery platform.'),
                _buildSection('2. Your Account', 
                  'You are responsible for maintaining the confidentiality of your account and password. You agree to accept responsibility for all activities that occur under your account. GoCrave reserves the right to refuse service or terminate accounts at its discretion.'),
                _buildSection('3. Delivery Services', 
                  'We strive to provide estimated delivery times as accurately as possible. However, factors like traffic, weather, and restaurant preparation times may affect actual delivery. We are not liable for delays outside our reasonable control.'),
                _buildSection('4. Payment & Refunds', 
                  'All transactions are processed securely. Refunds are handled on a case-by-case basis through our support team. Promotional codes must be used according to their specific terms and conditions.'),
                _buildSection('5. Privacy Policy', 
                  'Your privacy is important to us. We collect data such as your location, order history, and contact information to provide and improve our services. We do not sell your personal data to third parties.'),
                _buildSection('6. Liability', 
                  'GoCrave is a platform connecting users with restaurants and independent couriers. While we ensure high standards, the restaurants are responsible for food quality, and couriers are responsible for safe transit.'),
                _buildSection('7. Governing Law', 
                  'These terms are governed by the laws of the Republic of the Philippines. Any disputes arising from these terms will be settled in the appropriate courts of competent jurisdiction.'),
                
                const SizedBox(height: 20),
                if (!_hasReachedBottom)
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.arrow_downward, size: 16, color: Colors.deepOrangeAccent),
                        const SizedBox(width: 8),
                        Text(
                          'Scroll to the bottom to agree',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.deepOrangeAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _hasReachedBottom 
                  ? () => Navigator.pop(context, true) 
                  : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandColor,
                  disabledBackgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Agree and Continue',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _hasReachedBottom ? Colors.white : Colors.grey[400],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.grey[600],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
