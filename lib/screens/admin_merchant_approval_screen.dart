import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/merchant_manager.dart';

class AdminMerchantApprovalScreen extends StatefulWidget {
  final Color brandColor;

  const AdminMerchantApprovalScreen({
    super.key,
    this.brandColor = const Color(0xFFFF5622),
  });

  @override
  State<AdminMerchantApprovalScreen> createState() => _AdminMerchantApprovalScreenState();
}

class _AdminMerchantApprovalScreenState extends State<AdminMerchantApprovalScreen> {
  final MerchantManager _merchantManager = MerchantManager();
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['All Applications', 'Pending', 'Approved', 'Rejected'];

  @override
  void initState() {
    super.initState();
    _merchantManager.addListener(_onMerchantChanged);
  }

  @override
  void dispose() {
    _merchantManager.removeListener(_onMerchantChanged);
    super.dispose();
  }

  void _onMerchantChanged() {
    if (mounted) {
      setState(() {
        
      });
    }
  }

  List<Map<String, dynamic>> get _filteredMerchants {
    final merchants = _merchantManager.merchants;
    if (_selectedFilterIndex == 0) {
      return merchants;
    }
    final filter = _filters[_selectedFilterIndex];
    return merchants.where((m) {
      return m['status'] == filter;
    }).toList();
  }

  void _showApprovalDialog(Map<String, dynamic> merchant) {
    double commissionRate = (merchant['commission'] as num?)?.toDouble() ?? 15.0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Approve Partner Merchant', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                  const SizedBox(height: 8),
                  Text('Configure platform commission rate for ${merchant['storeName']}.', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Platform Commission Rate', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: widget.brandColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${commissionRate.toStringAsFixed(1)}%',
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: widget.brandColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Slider.adaptive(
                    value: commissionRate,
                    min: 5.0,
                    max: 30.0,
                    divisions: 50,
                    activeColor: widget.brandColor,
                    onChanged: (val) {
                      setModalState(() {
                        commissionRate = val;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        _merchantManager.approveMerchant(merchant['id'], commissionRate);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${merchant['storeName']} approved with ${commissionRate.toStringAsFixed(1)}% commission!', style: GoogleFonts.poppins()),
                            backgroundColor: widget.brandColor,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.brandColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                      child: Text('Confirm & Approve Store', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredMerchants;

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
          'Merchant Approval Pipeline',
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
                      onTap: () {
                        setState(() {
                          _selectedFilterIndex = idx;
                        });
                      },
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
              separatorBuilder: (context, index) {
                return const SizedBox(height: 14);
              },
              itemBuilder: (context, index) {
                final merchant = filtered[index];
                final status = merchant['status'];

                Color statusColor = const Color(0xFFF59E0B);
                if (status == 'Approved') {
                  statusColor = const Color(0xFF10B981);
                }
                if (status == 'Rejected') {
                  statusColor = const Color(0xFFEF4444);
                }

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
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(merchant['logo']),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  merchant['storeName'],
                                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                                ),
                                Text(
                                  'Owner: ${merchant['ownerName']} • ${merchant['cuisine']}',
                                  style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                                ),
                              ],
                            ),
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

                      const SizedBox(height: 14),
                      const Divider(height: 1, color: Color(0xFFF1F5F9)),
                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Permit: ${merchant['permitId']}', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                              Text('Applied: ${merchant['appliedDate']} • Commission: ${merchant['commission']}%', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF334155))),
                            ],
                          ),
                        ],
                      ),

                      if (status == 'Pending') ...[
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 42,
                                child: OutlinedButton(
                                  onPressed: () {
                                    _merchantManager.rejectMerchant(merchant['id']);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('${merchant['storeName']} application rejected.', style: GoogleFonts.poppins()),
                                        backgroundColor: const Color(0xFFEF4444),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Color(0xFFEF4444), width: 1.5),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  child: Text('Reject', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFFEF4444))),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: SizedBox(
                                height: 42,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _showApprovalDialog(merchant);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF10B981),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    elevation: 0,
                                  ),
                                  child: Text('Approve', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
