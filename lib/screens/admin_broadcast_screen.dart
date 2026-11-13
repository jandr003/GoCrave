import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/broadcast_manager.dart';

class AdminBroadcastScreen extends StatefulWidget {
  final Color brandColor;

  const AdminBroadcastScreen({
    super.key,
    this.brandColor = const Color(0xFFFF5622),
  });

  @override
  State<AdminBroadcastScreen> createState() {
    return _AdminBroadcastScreenState();
  }
}

class _AdminBroadcastScreenState extends State<AdminBroadcastScreen> {
  final BroadcastManager _broadcastManager = BroadcastManager();
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _messageCtrl = TextEditingController();
  String _selectedTarget = 'All Users';

  final List<String> _targets = ['All Users', 'Customers Only', 'Active Riders', 'Restaurant Merchants'];

  @override
  void initState() {
    super.initState();
    _broadcastManager.addListener(_onBroadcastChanged);
  }

  @override
  void dispose() {
    _broadcastManager.removeListener(_onBroadcastChanged);
    _titleCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  void _onBroadcastChanged() {
    if (mounted) {
      setState(() {
        
      });
    }
  }

  void _sendBroadcast() {
    if (_titleCtrl.text.trim().isEmpty || _messageCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter both notification title and message.', style: GoogleFonts.poppins()),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    _broadcastManager.sendBroadcast(_selectedTarget, _titleCtrl.text.trim(), _messageCtrl.text.trim());
    _titleCtrl.clear();
    _messageCtrl.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Broadcast push notification successfully sent!', style: GoogleFonts.poppins()),
        backgroundColor: widget.brandColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final broadcasts = _broadcastManager.broadcasts;

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
          'Broadcast Push Notification Center',
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
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
            Text('Target Audience', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _targets.map((target) {
                final isSelected = _selectedTarget == target;
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedTarget = target;
                    });
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? widget.brandColor : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: isSelected ? widget.brandColor : const Color(0xFFE2E8F0)),
                      boxShadow: isSelected
                          ? [BoxShadow(color: widget.brandColor.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 3))]
                          : [],
                    ),
                    child: Text(
                      target,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                        color: isSelected ? Colors.white : const Color(0xFF64748B),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            Text('Notification Title', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
            const SizedBox(height: 6),
            TextField(
              controller: _titleCtrl,
              style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF0F172A)),
              decoration: InputDecoration(
                hintText: 'Enter broadcast headline...',
                hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 13),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: widget.brandColor, width: 1.5)),
              ),
            ),

            const SizedBox(height: 16),

            Text('Message Body', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
            const SizedBox(height: 6),
            TextField(
              controller: _messageCtrl,
              maxLines: 4,
              style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF0F172A)),
              decoration: InputDecoration(
                hintText: 'Write your announcement message here...',
                hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 13),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: widget.brandColor, width: 1.5)),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _sendBroadcast,
                icon: const Icon(Icons.send_rounded, size: 18, color: Colors.white),
                label: Text('Send Broadcast Push', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.brandColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
              ),
            ),

            const SizedBox(height: 28),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Broadcast History Log', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                Text('${broadcasts.length} Sent', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B), fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 12),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: broadcasts.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
              itemBuilder: (context, index) {
                final broadcast = broadcasts[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 3)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: widget.brandColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              broadcast['target'],
                              style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: widget.brandColor),
                            ),
                          ),
                          Text(broadcast['timestamp'], style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF94A3B8))),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        broadcast['title'],
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        broadcast['message'],
                        style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF475569)),
                      ),
                      const SizedBox(height: 10),
                      const Divider(height: 1, color: Color(0xFFF1F5F9)),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 14),
                              const SizedBox(width: 4),
                              Text(broadcast['status'], style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF10B981))),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline_rounded, color: Colors.grey, size: 18),
                            onPressed: () {
                              _broadcastManager.deleteBroadcast(broadcast['id']);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
