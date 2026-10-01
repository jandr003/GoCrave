import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderEditProfileModal extends StatefulWidget {
  final String currentName;
  final String currentPhone;
  final String currentVehicle;
  final String currentAvatar;
  final List<String> avatars;
  final Color brandColor;
  final Function(String name, String phone, String vehicle, String avatar) onSave;

  const RiderEditProfileModal({
    super.key,
    required this.currentName,
    required this.currentPhone,
    required this.currentVehicle,
    required this.currentAvatar,
    required this.avatars,
    required this.brandColor,
    required this.onSave,
  });

  @override
  State<RiderEditProfileModal> createState() => _RiderEditProfileModalState();
}

class _RiderEditProfileModalState extends State<RiderEditProfileModal> {
  late TextEditingController _nameCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _vehicleCtrl;
  late String _selectedAvatar;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.currentName);
    _phoneCtrl = TextEditingController(text: widget.currentPhone);
    _vehicleCtrl = TextEditingController(text: widget.currentVehicle);
    _selectedAvatar = widget.currentAvatar;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _vehicleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        top: 24,
        left: 24,
        right: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Edit Rider Profile',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // Avatar Selector
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(_selectedAvatar),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: widget.brandColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 56,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.avatars.length,
                itemBuilder: (context, idx) {
                  final img = widget.avatars[idx];
                  final isSelected = img == _selectedAvatar;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatar = img;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? widget.brandColor : Colors.grey[300]!,
                          width: 2.5,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(img),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
            _buildModalTextField('Rider Name', _nameCtrl, Icons.person_outline),
            const SizedBox(height: 14),
            _buildModalTextField('Phone Number', _phoneCtrl, Icons.phone_outlined, keyboardType: TextInputType.phone),
            const SizedBox(height: 14),
            _buildModalTextField('Vehicle & Plate Number', _vehicleCtrl, Icons.two_wheeler_rounded),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  widget.onSave(_nameCtrl.text, _phoneCtrl.text, _vehicleCtrl.text, _selectedAvatar);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.brandColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: Text(
                  'Save Changes',
                  style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModalTextField(String label, TextEditingController ctrl, IconData icon, {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9FB),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: TextField(
            controller: ctrl,
            keyboardType: keyboardType,
            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(icon, size: 20, color: widget.brandColor),
            ),
          ),
        ),
      ],
    );
  }
}
