import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/rider_performance_manager.dart';

class AdminRiderPerformanceScreen extends StatefulWidget {
  final Color brandColor;

  const AdminRiderPerformanceScreen({
    super.key,
    this.brandColor = const Color(0xFFFF5622),
  });

  @override
  State<AdminRiderPerformanceScreen> createState() => _AdminRiderPerformanceScreenState();
}

class _AdminRiderPerformanceScreenState extends State<AdminRiderPerformanceScreen> {
  final RiderPerformanceManager _perfManager = RiderPerformanceManager();

  @override
  void initState() {
    super.initState();
    _perfManager.addListener(_onPerfChanged);
  }

  @override
  void dispose() {
    _perfManager.removeListener(_onPerfChanged);
    super.dispose();
  }

  void _onPerfChanged() {
    if (mounted) {
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final performances = _perfManager.performances;

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
          'Rider Performance & Shift Tracker',
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
        itemCount: performances.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 14);
        },
        itemBuilder: (context, index) {
          final perf = performances[index];
          final bool isOnDuty = perf['status'] == 'On Duty';

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      perf['name'],
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isOnDuty ? const Color(0xFF10B981).withOpacity(0.12) : Colors.grey[100],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        perf['status'],
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isOnDuty ? const Color(0xFF10B981) : Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Shift: ${perf['shift']} • Rating: ⭐ ${perf['rating']}',
                  style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                ),
                const SizedBox(height: 4),
                Text(
                  'Acceptance: ${perf['acceptanceRate']} • Cancellation: ${perf['cancellationRate']} • Trips: ${perf['completedTrips']}',
                  style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF334155)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
