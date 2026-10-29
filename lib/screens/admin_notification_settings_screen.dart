import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminNotificationSettingsScreen extends StatefulWidget {
  final Map<String, bool>? initialChannelSettings;
  final Map<String, bool>? initialOrderSettings;
  final Map<String, bool>? initialRiderSettings;
  final Map<String, bool>? initialPaymentSettings;
  final Map<String, bool>? initialSecuritySettings;
  final Function(Map<String, dynamic> updatedSettings)? onSave;

  const AdminNotificationSettingsScreen({
    super.key,
    this.initialChannelSettings,
    this.initialOrderSettings,
    this.initialRiderSettings,
    this.initialPaymentSettings,
    this.initialSecuritySettings,
    this.onSave,
  });

  @override
  State<AdminNotificationSettingsScreen> createState() => _AdminNotificationSettingsScreenState();
}

class _AdminNotificationSettingsScreenState extends State<AdminNotificationSettingsScreen> {
  final Color brandColor = const Color(0xFFFF5622);

  late Map<String, bool> _channels;
  late Map<String, bool> _orderAlerts;
  late Map<String, bool> _riderAlerts;
  late Map<String, bool> _paymentAlerts;
  late Map<String, bool> _securityAlerts;

  bool _isSaving = false;
  bool _hasUnsavedChanges = false;

  @override
  void initState() {
    super.initState();
    _channels = widget.initialChannelSettings ?? {
      'Push Notifications': true,
      'Email Notifications': true,
      'SMS Notifications': false,
    };

    _orderAlerts = widget.initialOrderSettings ?? {
      'New Orders': true,
      'Order Cancellations': true,
      'Pending Actions': true,
      'Order Status Updates': true,
    };

    _riderAlerts = widget.initialRiderSettings ?? {
      'Rider Assignment': true,
      'Delivery Status Updates': true,
      'Delayed Deliveries': true,
      'Failed Deliveries': true,
    };

    _paymentAlerts = widget.initialPaymentSettings ?? {
      'Payment Verification': true,
      'Payment Status Updates': true,
      'Payment Issues': true,
    };

    _securityAlerts = widget.initialSecuritySettings ?? {
      'Account Security Alerts': true,
      'Account Changes': true,
      'System Announcements': true,
    };
  }

  void _markChanged() {
    if (!_hasUnsavedChanges) {
      setState(() => _hasUnsavedChanges = true);
    }
  }

  void _showResetConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Reset Notification Settings?',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: const Color(0xFF0F172A)),
        ),
        content: Text(
          'Are you sure you want to restore all notification channels and alert preferences to platform defaults?',
          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF475569)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _channels = {'Push Notifications': true, 'Email Notifications': true, 'SMS Notifications': false};
                _orderAlerts = {'New Orders': true, 'Order Cancellations': true, 'Pending Actions': true, 'Order Status Updates': true};
                _riderAlerts = {'Rider Assignment': true, 'Delivery Status Updates': true, 'Delayed Deliveries': true, 'Failed Deliveries': true};
                _paymentAlerts = {'Payment Verification': true, 'Payment Status Updates': true, 'Payment Issues': true};
                _securityAlerts = {'Account Security Alerts': true, 'Account Changes': true, 'System Announcements': true};
                _hasUnsavedChanges = false;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Notification settings reset to defaults.', style: GoogleFonts.poppins()),
                  backgroundColor: const Color(0xFF475569),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: brandColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Confirm Reset', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _saveChanges() async {
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    final updatedData = {
      'channels': _channels,
      'orderAlerts': _orderAlerts,
      'riderAlerts': _riderAlerts,
      'paymentAlerts': _paymentAlerts,
      'securityAlerts': _securityAlerts,
    };

    widget.onSave?.call(updatedData);

    setState(() {
      _isSaving = false;
      _hasUnsavedChanges = false;
    });

    _showSaveSuccessModal();
  }

  void _showSaveSuccessModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final activeChannelsCount = _channels.values.where((v) => v).length;
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECFDF5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notification Settings Saved',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                        ),
                        Text(
                          '$activeChannelsCount alert channels active for GoCrave Admin.',
                          style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    _buildSummaryRow('Push Notifications', _channels['Push Notifications']! ? 'Enabled' : 'Disabled'),
                    const Divider(height: 12, color: Color(0xFFE2E8F0)),
                    _buildSummaryRow('Email Notifications', _channels['Email Notifications']! ? 'Enabled' : 'Disabled'),
                    const Divider(height: 12, color: Color(0xFFE2E8F0)),
                    _buildSummaryRow('SMS Notifications', _channels['SMS Notifications']! ? 'Enabled' : 'Disabled'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brandColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: Text('Continue', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: value == 'Enabled' ? const Color(0xFF10B981) : const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: brandColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notification Settings',
          style: GoogleFonts.poppins(
            fontSize: 18,
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
            Text(
              'Manage the alerts you receive from GoCrave Admin.',
              style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF64748B)),
            ),
            const SizedBox(height: 20),

            Text(
              'Notification Channels',
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(height: 10),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                children: [
                  _buildChannelTile('Push Notifications', 'Alerts on your mobile device', Icons.notifications_active_outlined, 'Push Notifications'),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  _buildChannelTile('Email Notifications', 'Updates sent to your email', Icons.mark_email_read_outlined, 'Email Notifications'),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  _buildChannelTile('SMS Notifications', 'Urgent alerts by text message', Icons.sms_outlined, 'SMS Notifications'),
                ],
              ),
            ),

            const SizedBox(height: 22),

            Text(
              'Order Notifications',
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(height: 10),

            _buildSectionCard(_orderAlerts),

            const SizedBox(height: 22),

            Text(
              'Rider & Delivery',
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(height: 10),

            _buildSectionCard(_riderAlerts),

            const SizedBox(height: 22),

            Text(
              'Payments & Transactions',
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(height: 10),

            _buildSectionCard(_paymentAlerts),

            const SizedBox(height: 22),

            Text(
              'System & Security',
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(height: 10),

            _buildSectionCard(_securityAlerts),

            const SizedBox(height: 28),

            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      onPressed: _showResetConfirmationDialog,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF94A3B8), width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text('Reset to Defaults', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF475569))),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : _saveChanges,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: brandColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                      child: _isSaving
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                          : Text('Save Changes', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildChannelTile(String title, String subtitle, IconData icon, String key) {
    final val = _channels[key] ?? false;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 22, color: brandColor),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                Text(subtitle, style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
              ],
            ),
          ),
          Switch(
            value: val,
            activeColor: brandColor,
            onChanged: (newVal) {
              setState(() => _channels[key] = newVal);
              _markChanged();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(Map<String, bool> map) {
    final keys = map.keys.toList();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: List.generate(keys.length, (idx) {
          final k = keys[idx];
          final val = map[k]!;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        k,
                        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                      ),
                    ),
                    Switch(
                      value: val,
                      activeColor: brandColor,
                      onChanged: (newVal) {
                        setState(() => map[k] = newVal);
                        _markChanged();
                      },
                    ),
                  ],
                ),
              ),
              if (idx < keys.length - 1)
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
            ],
          );
        }),
      ),
    );
  }
}
