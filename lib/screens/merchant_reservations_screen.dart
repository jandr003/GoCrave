import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/table_reservation_manager.dart';

class MerchantReservationsScreen extends StatefulWidget {
  final Color brandColor;

  const MerchantReservationsScreen({
    super.key,
    this.brandColor = const Color(0xFFFF5622),
  });

  @override
  State<MerchantReservationsScreen> createState() {
    return _MerchantReservationsScreenState();
  }
}

class _MerchantReservationsScreenState extends State<MerchantReservationsScreen> {
  final TableReservationManager _manager = TableReservationManager();

  @override
  void initState() {
    super.initState();
    _manager.addListener(_updateState);
  }

  @override
  void dispose() {
    _manager.removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    if (mounted) {
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final reservations = _manager.reservations;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF0F172A),
            size: 18,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Dine-In Table Reservations',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F172A),
          ),
        ),
        centerTitle: false,
      ),
      body: reservations.isEmpty
          ? Center(
              child: Text(
                'No table reservations found',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF64748B),
                ),
              ),
            )
          : ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: reservations.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 14);
              },
              itemBuilder: (context, index) {
                final item = reservations[index];
                final isConfirmed = item.status.contains('Confirmed');

                return Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                    ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.customerName,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isConfirmed
                                  ? const Color(0xFFE8F5E9)
                                  : const Color(0xFFFFF3E0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              item.status,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: isConfirmed
                                    ? const Color(0xFF2E7D32)
                                    : const Color(0xFFE65100),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Booking ID: ${item.id} • Guests: ${item.guests} Persons • Time: ${item.timeSlot}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Divider(height: 1, color: Color(0xFFF1F5F9)),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (!isConfirmed) ...[
                            SizedBox(
                              height: 38,
                              child: OutlinedButton(
                                onPressed: () {
                                  _manager.declineReservation(item.id);
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Colors.red,
                                    width: 1.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  'Decline',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                          if (!isConfirmed)
                            SizedBox(
                              height: 38,
                              child: ElevatedButton(
                                onPressed: () {
                                  _manager.acceptReservation(item.id);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: widget.brandColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Accept & Reserve',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
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
