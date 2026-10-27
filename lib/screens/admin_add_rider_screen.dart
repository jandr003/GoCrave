import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/admin/admin_riders_tab.dart';

class AdminAddRiderScreen extends StatefulWidget {
  final Function(RiderModel newRider)? onRiderAdded;

  const AdminAddRiderScreen({
    super.key,
    this.onRiderAdded,
  });

  @override
  State<AdminAddRiderScreen> createState() => _AdminAddRiderScreenState();
}

class _AdminAddRiderScreenState extends State<AdminAddRiderScreen> {
  final Color brandColor = const Color(0xFFFF5622);

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _plateCtrl = TextEditingController();
  final TextEditingController _vehicleModelCtrl = TextEditingController();

  String _selectedVehicleType = 'Motorcycle';
  bool _isRegistering = false;

  final List<String> _vehicleTypes = ['Motorcycle', 'Bicycle', 'E-Bike', 'Car / Van'];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _plateCtrl.dispose();
    _vehicleModelCtrl.dispose();
    super.dispose();
  }

  void _submitRiderRegistration() async {
    if (_nameCtrl.text.trim().isEmpty || _phoneCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in rider full name and mobile phone number.', style: GoogleFonts.poppins()),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isRegistering = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    final riderId = 'R${(DateTime.now().millisecondsSinceEpoch % 1000).toString().padLeft(3, '0')}';
    final emailVal = _emailCtrl.text.trim().isNotEmpty
        ? _emailCtrl.text.trim()
        : '${_nameCtrl.text.trim().toLowerCase().replaceAll(' ', '.')}@gocrave.app';

    final plateVal = _plateCtrl.text.trim().isNotEmpty
        ? _plateCtrl.text.trim()
        : 'N/A';

    final newRider = RiderModel(
      id: riderId,
      name: _nameCtrl.text.trim(),
      email: emailVal,
      phone: _phoneCtrl.text.trim(),
      plate: plateVal,
      status: 'Pending Review',
      subtitle: 'Account verification required',
      rating: '5.0 ⭐',
      totalDeliveries: '0 orders',
      avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=200&auto=format&fit=crop',
    );

    widget.onRiderAdded?.call(newRider);

    setState(() => _isRegistering = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Fleet rider ${newRider.name} (#${newRider.id}) registered successfully!', style: GoogleFonts.poppins()),
        backgroundColor: brandColor,
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.pop(context, newRider);
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
          'Register Fleet Rider',
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
              'Add a rider to the GoCrave delivery fleet.',
              style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF64748B)),
            ),
            const SizedBox(height: 20),

            Text(
              'Personal Information',
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(height: 10),

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
                  Text('Full Name *', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  _buildInputField(_nameCtrl, 'Enter rider\'s full name', TextInputType.name),

                  const SizedBox(height: 16),

                  Text('Mobile Phone Number *', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  _buildInputField(_phoneCtrl, '09XX XXX XXXX', TextInputType.phone),

                  const SizedBox(height: 16),

                  Text('Email Address', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  _buildInputField(_emailCtrl, 'Enter email address', TextInputType.emailAddress),
                ],
              ),
            ),

            const SizedBox(height: 22),

            Text(
              'Vehicle Information',
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(height: 10),

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
                  Text('Vehicle Type *', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  _buildDropdown(_selectedVehicleType, _vehicleTypes, (val) {
                    setState(() => _selectedVehicleType = val);
                  }),

                  const SizedBox(height: 16),

                  Text('Vehicle Plate Number', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  _buildInputField(_plateCtrl, 'Enter plate number', TextInputType.text),

                  const SizedBox(height: 16),

                  Text('Vehicle Model (Optional)', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color(0xFF334155))),
                  const SizedBox(height: 6),
                  _buildInputField(_vehicleModelCtrl, 'e.g. Honda Click 125', TextInputType.text),
                ],
              ),
            ),

            const SizedBox(height: 22),

            Text(
              'Account Status',
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(height: 10),

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
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFD97706).withOpacity(0.3)),
                        ),
                        child: Text(
                          'Pending Verification',
                          style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFFD97706)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'The rider must complete the required verification before becoming eligible for assignments.',
                    style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B), height: 1.4),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isRegistering ? null : _submitRiderRegistration,
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                child: _isRegistering
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text('Register Fleet Rider', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hint, TextInputType keyboardType) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF94A3B8)),
          border: InputBorder.none,
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
