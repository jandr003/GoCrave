import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminOrderManagementGuideScreen extends StatelessWidget {
  const AdminOrderManagementGuideScreen({super.key});

  final Color brandColor = const Color(0xFFFF5622);

  final List<Map<String, String>> _steps = const [
    {
      'number': '1',
      'title': 'Viewing Orders',
      'body': 'Open the Orders screen to view incoming and existing customer orders. Review the available order information and identify orders that require administrative action.'
    },
    {
      'number': '2',
      'title': 'Filtering Orders by Status',
      'body': 'Use the available status filters to locate specific orders:'
    },
    {
      'number': '3',
      'title': 'Reviewing Order Details',
      'body': 'Select an order to view its information, including Order ID, Customer details & delivery address, Restaurant & ordered items, Order total, Payment method & status, and Current order status.'
    },
    {
      'number': '4',
      'title': 'Assigning a Rider',
      'body': 'Select an eligible rider for an order that requires assignment. Confirm the assignment and check that the order reflects the updated rider information.'
    },
    {
      'number': '5',
      'title': 'Monitoring Delivery Progress',
      'body': 'Monitor the order as it moves through the fulfillment process. Check available rider updates and tracking information to determine whether an order is being processed, picked up, or delivered.'
    },
    {
      'number': '6',
      'title': 'Handling Order Issues',
      'body': 'Review delayed, cancelled, or problematic orders using the available order information and administrative actions. Contact the assigned rider or relevant personnel when further clarification is needed.'
    },
  ];

  final List<String> _reminders = const [
    'Verify customer details and delivery addresses before proceeding with an order.',
    'Confirm rider assignments and review delivery updates regularly.',
    'Check payment records before changing payment statuses.',
    'Follow the platform\'s procedures when handling cancellations, delays, and other order concerns.',
    'Protect customer, restaurant, and rider information at all times.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0F172A), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Order Management Guide',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F172A),
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/gocrave_app_logo.png',
                          width: 44,
                          height: 44,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Managing Customer Orders',
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              'Help Center / Order Management',
                              style: GoogleFonts.poppins(fontSize: 11, color: brandColor, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'The GoCrave Admin Control Panel allows authorized administrators to review incoming customer orders, check order details, assign riders, and monitor order progress until completion.',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF475569),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            Text(
              'Order Management Steps',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: List.generate(_steps.length, (idx) {
                  final step = _steps[idx];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: brandColor.withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  step['number']!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: brandColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    step['title']!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF0F172A),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  _buildStepBody(idx, step['body']!),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (idx < _steps.length - 1)
                        const Divider(height: 1, color: Color(0xFFF1F5F9)),
                    ],
                  );
                }),
              ),
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFFFE0B2), width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_circle_outline_rounded, color: brandColor, size: 22),
                      const SizedBox(width: 10),
                      Text(
                        'Important Reminders',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: _reminders.map((reminder) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• ',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: brandColor,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                reminder,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF334155),
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStepBody(int idx, String defaultBody) {
    if (idx == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            defaultBody,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF475569),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          _buildStatusTagPill('Pending', 'Orders awaiting review or rider assignment.', const Color(0xFF64748B), const Color(0xFFF1F5F9)),
          const SizedBox(height: 8),
          _buildStatusTagPill('Assigned', 'Orders with a rider assigned.', brandColor, const Color(0xFFFFF3E0)),
          const SizedBox(height: 8),
          _buildStatusTagPill('In Progress', 'Orders currently being processed.', const Color(0xFFD97706), const Color(0xFFFEF3C7)),
          const SizedBox(height: 8),
          _buildStatusTagPill('On Delivery', 'Orders currently being delivered to customers.', const Color(0xFF7C3AED), const Color(0xFFF3E8FF)),
          const SizedBox(height: 8),
          _buildStatusTagPill('Completed', 'Orders that have been successfully delivered and completed.', const Color(0xFF10B981), const Color(0xFFECFDF5)),
        ],
      );
    }
    return Text(
      defaultBody,
      style: GoogleFonts.poppins(
        fontSize: 12,
        color: const Color(0xFF475569),
        height: 1.5,
      ),
    );
  }

  Widget _buildStatusTagPill(String status, String description, Color textColor, Color bgColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: textColor.withOpacity(0.3)),
          ),
          child: Text(
            status,
            style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(
              description,
              style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF475569), height: 1.4),
            ),
          ),
        ),
      ],
    );
  }
}
