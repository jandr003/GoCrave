import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/branch_manager.dart';

class AdminBranchManagerScreen extends StatefulWidget {
  final Color brandColor;

  const AdminBranchManagerScreen({
    super.key,
    this.brandColor = const Color(0xFFFF5622),
  });

  @override
  State<AdminBranchManagerScreen> createState() => _AdminBranchManagerScreenState();
}

class _AdminBranchManagerScreenState extends State<AdminBranchManagerScreen> {
  final BranchManager _branchManager = BranchManager();

  @override
  void initState() {
    super.initState();
    _branchManager.addListener(_onBranchChanged);
  }

  @override
  void dispose() {
    _branchManager.removeListener(_onBranchChanged);
    super.dispose();
  }

  void _onBranchChanged() {
    if (mounted) {
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final branches = _branchManager.branches;

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
          'Multi-Store Franchise & Branch Manager',
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
        itemCount: branches.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 14);
        },
        itemBuilder: (context, index) {
          final branch = branches[index];
          final bool isActive = branch['status'] == 'Active';

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
                        branch['branchName'],
                        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                      ),
                      Text(
                        'Store: ${branch['storeName']} • City: ${branch['city']}',
                        style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Manager: ${branch['manager']} • Sales: ${branch['sales']}',
                        style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF334155)),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Switch.adaptive(
                      value: isActive,
                      activeColor: widget.brandColor,
                      onChanged: (val) {
                        _branchManager.toggleBranchStatus(branch['id']);
                      },
                    ),
                    Text(
                      branch['status'],
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isActive ? const Color(0xFF10B981) : Colors.grey,
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
