import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPaymentFeesScreen extends StatefulWidget {
  final Map<String, dynamic>? initialPaymentFeeData;
  final Function(Map<String, dynamic> updatedData)? onSave;

  const AdminPaymentFeesScreen({
    super.key,
    this.initialPaymentFeeData,
    this.onSave,
  });

  @override
  State<AdminPaymentFeesScreen> createState() => _AdminPaymentFeesScreenState();
}

class _AdminPaymentFeesScreenState extends State<AdminPaymentFeesScreen> {
  final Color brandColor = const Color(0xFFFF5622);

  late bool _allowCOD;
  late bool _allowGCash;
  late bool _allowMaya;
  late bool _allowBankTransfer;

  late TextEditingController _commissionCtrl;
  late TextEditingController _serviceFeeCtrl;
  late TextEditingController _baseDeliveryFeeCtrl;
  late TextEditingController _freeDeliveryMinCtrl;
  late TextEditingController _maxCodCtrl;

  bool _isSaving = false;
  bool _hasUnsavedChanges = false;

  @override
  void initState() {
    super.initState();
    final data = widget.initialPaymentFeeData ?? {};
    _allowCOD = data['allowCOD'] ?? true;
    _allowGCash = data['allowGCash'] ?? true;
    _allowMaya = data['allowMaya'] ?? true;
    _allowBankTransfer = data['allowBankTransfer'] ?? true;

    _commissionCtrl = TextEditingController(text: (data['commissionRate'] ?? '15.0').toString());
    _serviceFeeCtrl = TextEditingController(text: (data['serviceFee'] ?? '15.00').toString());
    _baseDeliveryFeeCtrl = TextEditingController(text: (data['baseDeliveryFee'] ?? '49.00').toString());
    _freeDeliveryMinCtrl = TextEditingController(text: (data['freeDeliveryMin'] ?? '1000.00').toString());
    _maxCodCtrl = TextEditingController(text: (data['maxCodAmount'] ?? '3000.00').toString());
  }

  @override
  void dispose() {
    _commissionCtrl.dispose();
    _serviceFeeCtrl.dispose();
    _baseDeliveryFeeCtrl.dispose();
    _freeDeliveryMinCtrl.dispose();
    _maxCodCtrl.dispose();
    super.dispose();
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
          'Reset Payment & Fee Rules?',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: const Color(0xFF0F172A)),
        ),
        content: Text(
          'Are you sure you want to restore all payment gateway toggles, commission rates, and delivery fee thresholds back to platform defaults?',
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
                _allowCOD = true;
                _allowGCash = true;
                _allowMaya = true;
                _allowBankTransfer = true;
                _commissionCtrl.text = '15.0';
                _serviceFeeCtrl.text = '15.00';
                _baseDeliveryFeeCtrl.text = '49.00';
                _freeDeliveryMinCtrl.text = '1000.00';
                _maxCodCtrl.text = '3000.00';
                _hasUnsavedChanges = false;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Payment and fee rules reset to platform defaults.', style: GoogleFonts.poppins()),
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
      'allowCOD': _allowCOD,
      'allowGCash': _allowGCash,
      'allowMaya': _allowMaya,
      'allowBankTransfer': _allowBankTransfer,
      'commissionRate': _commissionCtrl.text.trim(),
      'serviceFee': _serviceFeeCtrl.text.trim(),
      'baseDeliveryFee': _baseDeliveryFeeCtrl.text.trim(),
      'freeDeliveryMin': _freeDeliveryMinCtrl.text.trim(),
      'maxCodAmount': _maxCodCtrl.text.trim(),
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
                          'Payment & Fees Saved',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                        ),
                        Text(
                          'Commission rates, payment gateways, and delivery fees updated.',
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
                    _buildSummaryRow('Restaurant Commission', '${_commissionCtrl.text.trim()}%'),
                    const Divider(height: 12, color: Color(0xFFE2E8F0)),
                    _buildSummaryRow('Base Delivery Fee', '₱${_baseDeliveryFeeCtrl.text.trim()}'),
                    const Divider(height: 12, color: Color(0xFFE2E8F0)),
                    _buildSummaryRow('Customer Service Fee', '₱${_serviceFeeCtrl.text.trim()}'),
                    const Divider(height: 12, color: Color(0xFFE2E8F0)),
                    _buildSummaryRow('Max COD Limit', '₱${_maxCodCtrl.text.trim()}'),
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
        backgroundColor: Colors.white,
        elevation: 0.5,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0F172A), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Payment & Fees',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F172A),
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
              'Manage payment methods, platform fees, and cash-on-delivery rules.',
              style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF64748B)),
            ),
            const SizedBox(height: 20),

            Text(
              '1. Payment Methods',
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(height: 4),
            Text(
              'Enable or disable the payment options available to customers.',
              style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
            ),
            const SizedBox(height: 12),

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
                  _buildPaymentSwitchTile('Cash on Delivery (COD)', _allowCOD, (val) => setState(() { _allowCOD = val; _markChanged(); })),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  _buildPaymentSwitchTile('GCash', _allowGCash, (val) => setState(() { _allowGCash = val; _markChanged(); })),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  _buildPaymentSwitchTile('Maya', _allowMaya, (val) => setState(() { _allowMaya = val; _markChanged(); })),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  _buildPaymentSwitchTile('Bank Transfer', _allowBankTransfer, (val) => setState(() { _allowBankTransfer = val; _markChanged(); })),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Select which payment channels are active for customer checkout.',
              style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8), height: 1.4),
            ),

            const SizedBox(height: 24),

            Text(
              '2. Platform Fees',
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
                  Text('Restaurant Commission (%)', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  _buildInputField(_commissionCtrl, 'e.g. 15.0'),
                  const SizedBox(height: 4),
                  Text('Standard platform commission rate applied to restaurant order subtotal.', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8), height: 1.4)),

                  const SizedBox(height: 16),

                  Text('Customer Service Fee (₱)', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  _buildInputField(_serviceFeeCtrl, 'e.g. 15.00'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              '3. Delivery Charges',
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
                  Text('Base Delivery Fee (₱)', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  _buildInputField(_baseDeliveryFeeCtrl, 'e.g. 49.00'),
                  const SizedBox(height: 4),
                  Text('Base fare applied to all deliveries within standard distance coverage.', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8), height: 1.4)),

                  const SizedBox(height: 16),

                  Text('Free Delivery Minimum Spend (₱)', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  _buildInputField(_freeDeliveryMinCtrl, 'e.g. 1000.00'),
                  const SizedBox(height: 4),
                  Text('Minimum order subtotal required to qualify for zero delivery fee.', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8), height: 1.4)),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              '4. Cash on Delivery Rules',
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
                  Text('Maximum COD Order Amount (₱)', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  _buildInputField(_maxCodCtrl, 'e.g. 3000.00'),
                  const SizedBox(height: 4),
                  Text('Maximum allowable cart total for Cash on Delivery orders.', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8), height: 1.4)),
                ],
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

  Widget _buildPaymentSwitchTile(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
          Switch(
            value: value,
            activeColor: brandColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
        onChanged: (val) => _markChanged(),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF94A3B8)),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
