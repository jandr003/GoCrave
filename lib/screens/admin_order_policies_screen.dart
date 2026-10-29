import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminOrderPoliciesScreen extends StatefulWidget {
  final Map<String, dynamic>? initialPolicyData;
  final Function(Map<String, dynamic> updatedPolicies)? onSave;

  const AdminOrderPoliciesScreen({
    super.key,
    this.initialPolicyData,
    this.onSave,
  });

  @override
  State<AdminOrderPoliciesScreen> createState() => _AdminOrderPoliciesScreenState();
}

class _AdminOrderPoliciesScreenState extends State<AdminOrderPoliciesScreen> {
  final Color brandColor = const Color(0xFFFF5622);

  late bool _allowCustomerCancellation;
  late String _cancellationGracePeriod;
  late String _cancellationAfterAcceptance;

  late bool _autoAcceptOrders;
  late String _merchantResponseLimit;
  late String _unresponsiveMerchantAction;

  late bool _allowRefundRequests;
  late String _refundReviewType;
  late String _refundWindow;

  bool _isSaving = false;
  bool _hasUnsavedChanges = false;

  final List<String> _gracePeriods = ['5 minutes', '10 minutes', '15 minutes'];
  final List<String> _afterAcceptanceOptions = ['Request cancellation review', 'Require admin approval', 'Disallow cancellation'];

  final List<String> _merchantTimeLimits = ['5 minutes', '10 minutes', '15 minutes'];
  final List<String> _unresponsiveActions = ['Notify admin', 'Auto-cancel order', 'Re-route to backup'];

  final List<String> _refundReviewTypes = ['Admin review required', 'Automatic refund under ₱100', 'Merchant review'];
  final List<String> _refundWindows = ['Within 24 hours', 'Within 48 hours', 'Within 7 days'];

  @override
  void initState() {
    super.initState();
    final data = widget.initialPolicyData ?? {};
    _allowCustomerCancellation = data['allowCustomerCancellation'] ?? true;
    _cancellationGracePeriod = data['cancellationGracePeriod'] ?? '5 minutes';
    _cancellationAfterAcceptance = data['cancellationAfterAcceptance'] ?? 'Request cancellation review';

    _autoAcceptOrders = data['autoAcceptOrders'] ?? false;
    _merchantResponseLimit = data['merchantResponseLimit'] ?? '10 minutes';
    _unresponsiveMerchantAction = data['unresponsiveMerchantAction'] ?? 'Notify admin';

    _allowRefundRequests = data['allowRefundRequests'] ?? true;
    _refundReviewType = data['refundReviewType'] ?? 'Admin review required';
    _refundWindow = data['refundWindow'] ?? 'Within 24 hours';
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
          'Reset Order Policies?',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: const Color(0xFF0F172A)),
        ),
        content: Text(
          'Are you sure you want to restore all order cancellation, merchant acceptance, and refund rules back to platform defaults?',
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
                _allowCustomerCancellation = true;
                _cancellationGracePeriod = '5 minutes';
                _cancellationAfterAcceptance = 'Request cancellation review';
                _autoAcceptOrders = false;
                _merchantResponseLimit = '10 minutes';
                _unresponsiveMerchantAction = 'Notify admin';
                _allowRefundRequests = true;
                _refundReviewType = 'Admin review required';
                _refundWindow = 'Within 24 hours';
                _hasUnsavedChanges = false;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Order policies reset to platform defaults.', style: GoogleFonts.poppins()),
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
      'allowCustomerCancellation': _allowCustomerCancellation,
      'cancellationGracePeriod': _cancellationGracePeriod,
      'cancellationAfterAcceptance': _cancellationAfterAcceptance,
      'autoAcceptOrders': _autoAcceptOrders,
      'merchantResponseLimit': _merchantResponseLimit,
      'unresponsiveMerchantAction': _unresponsiveMerchantAction,
      'allowRefundRequests': _allowRefundRequests,
      'refundReviewType': _refundReviewType,
      'refundWindow': _refundWindow,
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
                          'Order Policies Saved & Applied',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                        ),
                        Text(
                          'Cancellation, acceptance, and refund rules updated.',
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
                    _buildSummaryRow('Customer Cancellation', _allowCustomerCancellation ? 'Allowed ($_cancellationGracePeriod)' : 'Disabled'),
                    const Divider(height: 12, color: Color(0xFFE2E8F0)),
                    _buildSummaryRow('Auto-Accept Orders', _autoAcceptOrders ? 'Enabled' : 'Disabled'),
                    const Divider(height: 12, color: Color(0xFFE2E8F0)),
                    _buildSummaryRow('Merchant Response Limit', _merchantResponseLimit),
                    const Divider(height: 12, color: Color(0xFFE2E8F0)),
                    _buildSummaryRow('Refund Requests', _allowRefundRequests ? 'Allowed ($_refundWindow)' : 'Disabled'),
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
        Text(value, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
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
          'Order Policies',
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
              'Manage order cancellation rules, acceptance settings, and refund procedures.',
              style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF64748B)),
            ),
            const SizedBox(height: 20),

            Text(
              '1. Order Cancellation',
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Allow Customer Cancellation', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                            Text('Allow customers to cancel eligible orders.', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                          ],
                        ),
                      ),
                      Switch(
                        value: _allowCustomerCancellation,
                        activeColor: brandColor,
                        onChanged: (val) {
                          setState(() => _allowCustomerCancellation = val);
                          _markChanged();
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Text('Cancellation Grace Period', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  _buildDropdown(_cancellationGracePeriod, _gracePeriods, (val) {
                    setState(() => _cancellationGracePeriod = val);
                    _markChanged();
                  }),
                  const SizedBox(height: 4),
                  Text('Time after order placement when eligible customers can cancel without further review.', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8), height: 1.4)),

                  const SizedBox(height: 16),

                  Text('Cancellation After Merchant Acceptance', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  _buildDropdown(_cancellationAfterAcceptance, _afterAcceptanceOptions, (val) {
                    setState(() => _cancellationAfterAcceptance = val);
                    _markChanged();
                  }),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              '2. Merchant Order Acceptance',
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Automatically Accept Orders', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                            Text('Accept incoming orders automatically instead of waiting for merchant confirmation.', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                          ],
                        ),
                      ),
                      Switch(
                        value: _autoAcceptOrders,
                        activeColor: brandColor,
                        onChanged: (val) {
                          setState(() => _autoAcceptOrders = val);
                          _markChanged();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('Keep this off unless GoCrave supports automatic acceptance and the relevant restaurants have agreed to it.', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8), height: 1.4)),

                  const SizedBox(height: 16),

                  Text('Merchant Response Time Limit', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  _buildDropdown(_merchantResponseLimit, _merchantTimeLimits, (val) {
                    setState(() => _merchantResponseLimit = val);
                    _markChanged();
                  }),

                  const SizedBox(height: 16),

                  Text('If the Merchant Does Not Respond', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  _buildDropdown(_unresponsiveMerchantAction, _unresponsiveActions, (val) {
                    setState(() => _unresponsiveMerchantAction = val);
                    _markChanged();
                  }),
                  const SizedBox(height: 4),
                  Text('Automatic cancellation should be enabled only if the order workflow handles customer notification and payment consequences.', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8), height: 1.4)),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              '3. Refund & Dispute Policy',
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Allow Refund Requests', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                            Text('Allow eligible orders to be submitted for refund review.', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                          ],
                        ),
                      ),
                      Switch(
                        value: _allowRefundRequests,
                        activeColor: brandColor,
                        onChanged: (val) {
                          setState(() => _allowRefundRequests = val);
                          _markChanged();
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Text('Refund Request Review', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  _buildDropdown(_refundReviewType, _refundReviewTypes, (val) {
                    setState(() => _refundReviewType = val);
                    _markChanged();
                  }),

                  const SizedBox(height: 16),

                  Text('Refund Request Window After Completion', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  _buildDropdown(_refundWindow, _refundWindows, (val) {
                    setState(() => _refundWindow = val);
                    _markChanged();
                  }),
                  const SizedBox(height: 4),
                  Text('Example policy options. Set the actual timeframe based on GoCrave\'s approved refund policy.', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8), height: 1.4)),

                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFFFE0B2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info_outline_rounded, color: brandColor, size: 18),
                            const SizedBox(width: 8),
                            Text('Refund Review', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Review the order, payment record, and reason for the request before approving or rejecting a refund. Payment status alone does not confirm that money has been returned.',
                          style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF475569), height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              '4. Policy Changes',
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(height: 8),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Text(
                'Apply approved policy changes to eligible orders according to GoCrave\'s implementation. Existing orders should not be changed silently when a policy is updated.',
                style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF475569), height: 1.5),
              ),
            ),

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

  Widget _buildDropdown(String currentVal, List<String> options, Function(String) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentVal,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: brandColor),
          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
          onChanged: (val) {
            if (val != null) onChanged(val);
          },
          items: options.map<DropdownMenuItem<String>>((opt) => DropdownMenuItem(value: opt, child: Text(opt))).toList(),
        ),
      ),
    );
  }
}
