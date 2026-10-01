import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderActiveTaskTab extends StatelessWidget {
  final Map<String, dynamic>? activeTask;
  final int taskStep;
  final Color brandColor;
  final VoidCallback onAdvanceTaskStep;

  const RiderActiveTaskTab({
    super.key,
    required this.activeTask,
    required this.taskStep,
    required this.brandColor,
    required this.onAdvanceTaskStep,
  });

  @override
  Widget build(BuildContext context) {
    if (activeTask == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              Icon(Icons.near_me_disabled_rounded, size: 60, color: Colors.grey[300]),
              const SizedBox(height: 12),
              Text(
                'No Active Delivery Task',
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Accept a request from the Available tab to start a delivery workflow.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      );
    }

    String actionBtnLabel = 'Arrived at Restaurant';
    IconData actionIcon = Icons.store_rounded;

    if (taskStep == 2) {
      actionBtnLabel = 'Confirm Food Pick Up';
      actionIcon = Icons.takeout_dining_rounded;
    } else if (taskStep == 3) {
      actionBtnLabel = 'Complete Delivery & Collect ${activeTask!['payout']}';
      actionIcon = Icons.check_circle_rounded;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFEEEEEE)),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 16, offset: const Offset(0, 6)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Active Order ${activeTask!['id']}',
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: brandColor),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Payout: ${activeTask!['payout']}',
                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green[800]),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  _buildStepCircle(1, 'Resto', taskStep >= 1),
                  _buildStepLine(taskStep >= 2),
                  _buildStepCircle(2, 'Pick Up', taskStep >= 2),
                  _buildStepLine(taskStep >= 3),
                  _buildStepCircle(3, 'Deliver', taskStep >= 3),
                ],
              ),

              const SizedBox(height: 20),
              const Divider(height: 1, color: Color(0xFFEEEEEE)),
              const SizedBox(height: 16),

              Row(
                children: [
                  Icon(Icons.store_rounded, color: brandColor, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(activeTask!['restaurant'], style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold)),
                        Text(activeTask!['restoAddress'], style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500])),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  const Icon(Icons.person_pin_circle_rounded, color: Colors.blueAccent, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(activeTask!['customer'], style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold)),
                        Text(activeTask!['customerAddress'], style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500])),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Calling ${activeTask!['customer']}... (${activeTask!['phone']})'),
                            backgroundColor: Colors.blueAccent,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.phone, size: 16, color: Colors.blueAccent),
                      label: Text('Call Customer', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.blueAccent),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Opening Navigation Maps...'),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.navigation_rounded, size: 16, color: Colors.green),
                      label: Text('Open Maps', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.green),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: onAdvanceTaskStep,
                  icon: Icon(actionIcon, size: 20, color: Colors.white),
                  label: Text(
                    actionBtnLabel,
                    style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brandColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStepCircle(int step, String label, bool isDone) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: isDone ? brandColor : Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isDone
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : Text('$step', style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: GoogleFonts.poppins(fontSize: 10, fontWeight: isDone ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildStepLine(bool isDone) {
    return Expanded(
      child: Container(
        height: 3,
        color: isDone ? brandColor : Colors.grey[200],
      ),
    );
  }
}
