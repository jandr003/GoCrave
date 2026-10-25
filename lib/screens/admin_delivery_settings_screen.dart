import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminDeliverySettingsScreen extends StatefulWidget {
  final Map<String, dynamic>? initialDeliveryData;
  final List<Map<String, String>>? initialServiceableZones;
  final Function(Map<String, dynamic> updatedData)? onSave;

  const AdminDeliverySettingsScreen({
    super.key,
    this.initialDeliveryData,
    this.initialServiceableZones,
    this.onSave,
  });

  @override
  State<AdminDeliverySettingsScreen> createState() => _AdminDeliverySettingsScreenState();
}

class _AdminDeliverySettingsScreenState extends State<AdminDeliverySettingsScreen> {
  final Color brandColor = const Color(0xFFFF5622);

  late String _maxDistance;
  late String _assignmentMethod;
  late String _unassignedAction;
  late bool _operationsEnabled;
  late String _openingTime;
  late String _closingTime;
  late List<Map<String, String>> _serviceableZones;

  bool _isSaving = false;
  bool _hasUnsavedChanges = false;

  final List<String> _maxDistances = ['10 km', '15 km', '20 km', '25 km'];
  final List<String> _assignmentMethods = ['Manual Assignment', 'Auto Dispatch to Nearest Rider'];
  final List<String> _unassignedActions = ['Keep Order Unassigned', 'Notify Admin', 'Auto-Cancel After 15 Mins'];

  @override
  void initState() {
    super.initState();
    final data = widget.initialDeliveryData ?? {};
    _maxDistance = data['maxDistance'] ?? '15 km';
    _assignmentMethod = data['assignmentMethod'] ?? 'Manual Assignment';
    _unassignedAction = data['unassignedAction'] ?? 'Keep Order Unassigned';
    _operationsEnabled = data['operationsEnabled'] ?? true;
    _openingTime = data['openingTime'] ?? '8:00 AM';
    _closingTime = data['closingTime'] ?? '5:00 PM';

    _serviceableZones = widget.initialServiceableZones ?? [
      {'name': 'Metro Manila Central', 'status': 'Active', 'radius': '15 km'},
      {'name': 'Cavite North Coverage', 'status': 'Active', 'radius': '12 km'},
      {'name': 'Laguna West Operations', 'status': 'Active', 'radius': '10 km'},
      {'name': 'Bulacan South Expansion', 'status': 'Pending', 'radius': '15 km'},
    ];
  }

  void _markChanged() {
    if (!_hasUnsavedChanges) {
      setState(() => _hasUnsavedChanges = true);
    }
  }

  void _showServiceableAreasModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(24, 20, 24, MediaQuery.of(context).viewInsets.bottom + 24),
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
              Text('Configured Delivery Zones', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
              Text('Serviceable areas currently configured for GoCrave fleet dispatch.', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: List.generate(_serviceableZones.length, (idx) {
                    final zone = _serviceableZones[idx];
                    return Column(
                      children: [
                        ListTile(
                          dense: true,
                          title: Text(zone['name']!, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                          subtitle: Text('Coverage radius: ${zone['radius']}', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: zone['status'] == 'Active' ? const Color(0xFFECFDF5) : const Color(0xFFFEF3C7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              zone['status']!,
                              style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: zone['status'] == 'Active' ? const Color(0xFF10B981) : const Color(0xFFD97706)),
                            ),
                          ),
                        ),
                        if (idx < _serviceableZones.length - 1) const Divider(height: 1, color: Color(0xFFE2E8F0)),
                      ],
                    );
                  }),
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
                  child: Text('Close Zones View', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showResetConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Reset Delivery Settings?',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: const Color(0xFF0F172A)),
        ),
        content: Text(
          'Are you sure you want to restore all delivery distances, assignment rules, and operating schedules back to platform defaults?',
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
                _maxDistance = '15 km';
                _assignmentMethod = 'Manual Assignment';
                _unassignedAction = 'Keep Order Unassigned';
                _operationsEnabled = true;
                _openingTime = '8:00 AM';
                _closingTime = '5:00 PM';
                _hasUnsavedChanges = false;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Delivery settings reset to platform defaults.', style: GoogleFonts.poppins()),
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
      'maxDistance': _maxDistance,
      'assignmentMethod': _assignmentMethod,
      'unassignedAction': _unassignedAction,
      'operationsEnabled': _operationsEnabled,
      'openingTime': _openingTime,
      'closingTime': _closingTime,
      'serviceableZones': _serviceableZones,
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
                          'Delivery Settings Saved',
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
                        ),
                        Text(
                          'Distance coverage and rider dispatch rules updated.',
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
                    _buildSummaryRow('Max Distance', _maxDistance),
                    const Divider(height: 12, color: Color(0xFFE2E8F0)),
                    _buildSummaryRow('Assignment Method', _assignmentMethod),
                    const Divider(height: 12, color: Color(0xFFE2E8F0)),
                    _buildSummaryRow('Unassigned Action', _unassignedAction),
                    const Divider(height: 12, color: Color(0xFFE2E8F0)),
                    _buildSummaryRow('Delivery Operations', _operationsEnabled ? 'Active ($_openingTime - $_closingTime)' : 'Disabled'),
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
          'Delivery Settings',
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
              'Configure delivery coverage, rider assignment, and operating rules.',
              style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF64748B)),
            ),
            const SizedBox(height: 20),

            Text(
              'Service Area & Distance',
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
                  Text('Maximum Delivery Distance', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  _buildDropdown(_maxDistance, _maxDistances, (val) {
                    setState(() => _maxDistance = val);
                    _markChanged();
                  }),
                  const SizedBox(height: 4),
                  Text('Maximum distance from an eligible pickup location, according to your configured coverage rules.', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8), height: 1.4)),

                  const SizedBox(height: 18),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  const SizedBox(height: 12),

                  InkWell(
                    onTap: _showServiceableAreasModal,
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Serviceable Areas', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                              Text('View configured delivery zones', style: GoogleFonts.poppins(fontSize: 11, color: brandColor, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Color(0xFF94A3B8)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Rider Assignment',
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
                  Text('Assignment Method', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  _buildDropdown(_assignmentMethod, _assignmentMethods, (val) {
                    setState(() => _assignmentMethod = val);
                    _markChanged();
                  }),
                  const SizedBox(height: 4),
                  Text('Admin or coordinator assigns the rider.', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8), height: 1.4)),

                  const SizedBox(height: 18),

                  Text('When No Rider Is Available', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  _buildDropdown(_unassignedAction, _unassignedActions, (val) {
                    setState(() => _unassignedAction = val);
                    _markChanged();
                  }),
                  const SizedBox(height: 4),
                  Text('Notify the admin for follow-up.', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8), height: 1.4)),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Delivery Operating Hours',
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
                            Text('Delivery Operations', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                            Text('Enable or disable delivery availability.', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                          ],
                        ),
                      ),
                      Switch(
                        value: _operationsEnabled,
                        activeColor: brandColor,
                        onChanged: (val) {
                          setState(() => _operationsEnabled = val);
                          _markChanged();
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Opening Time', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                            const SizedBox(height: 6),
                            InkWell(
                              onTap: () async {
                                final picked = await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 8, minute: 0));
                                if (picked != null) {
                                  setState(() => _openingTime = picked.format(context));
                                  _markChanged();
                                }
                              },
                              borderRadius: BorderRadius.circular(14),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8FAFC),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: const Color(0xFFE2E8F0)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_openingTime, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                                    Icon(Icons.access_time_rounded, size: 16, color: brandColor),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Closing Time', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                            const SizedBox(height: 6),
                            InkWell(
                              onTap: () async {
                                final picked = await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 17, minute: 0));
                                if (picked != null) {
                                  setState(() => _closingTime = picked.format(context));
                                  _markChanged();
                                }
                              },
                              borderRadius: BorderRadius.circular(14),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8FAFC),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: const Color(0xFFE2E8F0)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_closingTime, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A))),
                                    Icon(Icons.access_time_rounded, size: 16, color: brandColor),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text('Standard operating window during which customer delivery orders are accepted.', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8))),
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
