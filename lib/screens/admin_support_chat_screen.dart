import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/support_manager.dart';

class AdminSupportChatScreen extends StatefulWidget {
  final Color brandColor;

  const AdminSupportChatScreen({
    super.key,
    this.brandColor = const Color(0xFFFF5622),
  });

  @override
  State<AdminSupportChatScreen> createState() => _AdminSupportChatScreenState();
}

class _AdminSupportChatScreenState extends State<AdminSupportChatScreen> {
  final SupportManager _supportManager = SupportManager();
  String? _activeThreadId;
  final TextEditingController _messageCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _supportManager.addListener(_onSupportChanged);
    if (_supportManager.threads.isNotEmpty) {
      _activeThreadId = _supportManager.threads.first['id'];
    }
  }

  @override
  void dispose() {
    _supportManager.removeListener(_onSupportChanged);
    _messageCtrl.dispose();
    super.dispose();
  }

  void _onSupportChanged() {
    if (mounted) {
      setState(() {
        
      });
    }
  }

  void _sendMessage() {
    if (_activeThreadId == null || _messageCtrl.text.trim().isEmpty) {
      return;
    }
    _supportManager.sendMessage(_activeThreadId!, _messageCtrl.text.trim(), 'Admin');
    _messageCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    final threads = _supportManager.threads;
    final activeThread = threads.firstWhere(
      (t) {
        return t['id'] == _activeThreadId;
      },
      orElse: () {
        return threads.isNotEmpty ? threads.first : {};
      },
    );

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
          'Omnichannel Support Live Chat Desk',
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
      ),
      body: Row(
        children: [
          Container(
            width: 320,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(right: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Support Tickets', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: widget.brandColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text('${threads.length} Active', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: widget.brandColor)),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    itemCount: threads.length,
                    separatorBuilder: (context, index) {
                      return const Divider(height: 1, color: Color(0xFFF1F5F9));
                    },
                    itemBuilder: (context, index) {
                      final thread = threads[index];
                      final bool isSelected = thread['id'] == _activeThreadId;
                      final bool isResolved = thread['status'] == 'Resolved';

                      return InkWell(
                        onTap: () {
                          setState(() {
                            _activeThreadId = thread['id'];
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          color: isSelected ? widget.brandColor.withOpacity(0.06) : Colors.transparent,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundImage: NetworkImage(thread['avatar']),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(thread['userName'], style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                                        Text(thread['time'], style: GoogleFonts.poppins(fontSize: 9, color: const Color(0xFF94A3B8))),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                          decoration: BoxDecoration(
                                            color: thread['role'] == 'Customer' ? Colors.blue[50] : (thread['role'] == 'Rider' ? Colors.orange[50] : Colors.green[50]),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            thread['role'],
                                            style: GoogleFonts.poppins(
                                              fontSize: 8.5,
                                              fontWeight: FontWeight.bold,
                                              color: thread['role'] == 'Customer' ? Colors.blue[700] : (thread['role'] == 'Rider' ? Colors.orange[800] : Colors.green[700]),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            thread['lastMessage'],
                                            style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: activeThread.isEmpty
                ? Center(child: Text('Select a support conversation', style: GoogleFonts.poppins(color: const Color(0xFF64748B))))
                : Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(activeThread['avatar']),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(activeThread['userName'], style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                                    Text('Role: ${activeThread['role']} • Ticket ID: ${activeThread['id']}', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                                  ],
                                ),
                              ],
                            ),
                            if (activeThread['status'] != 'Resolved')
                              SizedBox(
                                height: 38,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    _supportManager.resolveThread(activeThread['id']);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Support ticket ${activeThread['id']} marked as resolved.', style: GoogleFonts.poppins()),
                                        backgroundColor: const Color(0xFF10B981),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.check_circle_rounded, size: 16, color: Colors.white),
                                  label: Text('Mark Resolved', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF10B981),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    elevation: 0,
                                  ),
                                ),
                              )
                            else
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFECFDF5),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text('Resolved', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF10B981))),
                              ),
                          ],
                        ),
                      ),
                      const Divider(height: 1, color: Color(0xFFE2E8F0)),

                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(20),
                          itemCount: (activeThread['messages'] as List).length,
                          itemBuilder: (context, index) {
                            final msg = activeThread['messages'][index];
                            final bool isAdmin = msg['sender'] == 'Admin';

                            return Align(
                              alignment: isAdmin ? Alignment.centerRight : Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                constraints: const BoxConstraints(maxWidth: 400),
                                decoration: BoxDecoration(
                                  color: isAdmin ? widget.brandColor : Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: isAdmin ? widget.brandColor : const Color(0xFFE2E8F0)),
                                  boxShadow: [
                                    BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6, offset: const Offset(0, 2)),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      msg['text'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: isAdmin ? Colors.white : const Color(0xFF0F172A),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${msg['sender']} • ${msg['time']}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 9.5,
                                        color: isAdmin ? Colors.white70 : const Color(0xFF94A3B8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.all(16),
                        color: Colors.white,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _messageCtrl,
                                style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF0F172A)),
                                decoration: InputDecoration(
                                  hintText: 'Type your reply...',
                                  hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 13),
                                  filled: true,
                                  fillColor: const Color(0xFFF8FAFC),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: widget.brandColor, width: 1.5)),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                ),
                                onSubmitted: (val) {
                                  _sendMessage();
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              height: 48,
                              width: 48,
                              child: ElevatedButton(
                                onPressed: _sendMessage,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: widget.brandColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                  padding: EdgeInsets.zero,
                                  elevation: 0,
                                ),
                                child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
