import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/dispute_manager.dart';

class AdminDisputeCenterScreen extends StatefulWidget {
  final Color brandColor;

  const AdminDisputeCenterScreen({
    super.key,
    this.brandColor = const Color(0xFFFF5622),
  });

  @override
  State<AdminDisputeCenterScreen> createState() => _AdminDisputeCenterScreenState();
}

class _AdminDisputeCenterScreenState extends State<AdminDisputeCenterScreen> {
  final DisputeManager _disputeManager = DisputeManager();
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['All Tickets', 'Open', 'Resolved', 'Refunded'];

  @override
  void initState() {
    super.initState();
    _disputeManager.addListener(_onDisputeChanged);
  }

  @override
  void dispose() {
    _disputeManager.removeListener(_onDisputeChanged);
    super.dispose();
  }

  void _onDisputeChanged() {
    if (mounted) setState(() {});
  }

  List<Map<String, dynamic>> get _filteredDisputes {
    final disputes = _disputeManager.disputes;
    if (_selectedFilterIndex == 0) return disputes;
    final filter = _filters[_selectedFilterIndex];
    return disputes.where((d) => d['status'] == filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredDisputes;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: widget.brandColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Dispute & Refund Resolution Center',
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(_filters.length, (idx) {
                  final isSelected = _selectedFilterIndex == idx;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      onTap: () => setState(() => _selectedFilterIndex = idx),
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? widget.brandColor : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: isSelected ? widget.brandColor : const Color(0xFFE2E8F0)),
                        ),
                        child: Text(
                          _filters[idx],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                            color: isSelected ? Colors.white : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final dispute = filtered[index];
                final status = dispute['status'];

                Color statusColor = const Color(0xFFEF4444);
                if (status == 'Resolved') statusColor = const Color(0xFF10B981);
                if (status == 'Refunded') statusColor = const Color(0xFF2563EB);

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
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: widget.brandColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  dispute['id'],
                                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: widget.brandColor),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                dispute['orderId'],
                                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              status,
                              style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: statusColor),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Text(
                        dispute['issue'],
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Customer: ${dispute['customerName']} • Merchant: ${dispute['storeName']} • Amount: ${dispute['amount']}',
                        style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                      ),

                      const SizedBox(height: 14),
                      const Divider(height: 1, color: Color(0xFFF1F5F9)),
                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Logged: ${dispute['timestamp']}', style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF94A3B8))),
                          if (status == 'Open') ...[
                            Row(
                              children: [
                                SizedBox(
                                  height: 36,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      _disputeManager.issueRefund(dispute['id']);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Refund of ${dispute['amount']} issued for ${dispute['id']}', style: GoogleFonts.poppins()),
                                          backgroundColor: const Color(0xFF2563EB),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(color: Color(0xFF2563EB), width: 1.5),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                    child: Text('Refund', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF2563EB))),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                SizedBox(
                                  height: 36,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _disputeManager.resolveDispute(dispute['id']);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Dispute ${dispute['id']} marked as resolved.', style: GoogleFonts.poppins()),
                                          backgroundColor: const Color(0xFF10B981),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF10B981),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      elevation: 0,
                                    ),
                                    child: Text('Resolve', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
