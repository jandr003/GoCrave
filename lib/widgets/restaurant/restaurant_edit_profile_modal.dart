import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantEditProfileModal extends StatefulWidget {
  final String currentStoreName;
  final String currentPhone;
  final String currentAddress;
  final String currentHours;
  final String currentAvatar;
  final List<String> avatars;
  final Color brandColor;
  final Function(String name, String phone, String address, String hours, String avatar) onSave;

  const RestaurantEditProfileModal({
    super.key,
    required this.currentStoreName,
    required this.currentPhone,
    required this.currentAddress,
    required this.currentHours,
    required this.currentAvatar,
    required this.avatars,
    required this.brandColor,
    required this.onSave,
  });

  @override
  State<RestaurantEditProfileModal> createState() => _RestaurantEditProfileModalState();
}

class _RestaurantEditProfileModalState extends State<RestaurantEditProfileModal> {
  late TextEditingController _nameCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _addressCtrl;
  late TextEditingController _hoursCtrl;
  late String _selectedAvatar;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.currentStoreName);
    _phoneCtrl = TextEditingController(text: widget.currentPhone);
    _addressCtrl = TextEditingController(text: widget.currentAddress);
    _hoursCtrl = TextEditingController(text: widget.currentHours);
    _selectedAvatar = widget.currentAvatar;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _hoursCtrl.dispose();
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
              'Edit Store Profile & Details',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // Store Avatar Selector
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: widget.brandColor,
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
            Text(
              'Choose Store Avatar Photo',
              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
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
            _buildModalTextField('Restaurant Store Name', _nameCtrl, Icons.store_rounded),
            const SizedBox(height: 14),
            _buildModalTextField('Contact Phone Number', _phoneCtrl, Icons.phone_outlined, keyboardType: TextInputType.phone),
            const SizedBox(height: 14),
            _buildModalTextField('Branch Address', _addressCtrl, Icons.location_on_outlined),
            const SizedBox(height: 14),
            _buildModalTextField('Operating Hours', _hoursCtrl, Icons.access_time_rounded),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  widget.onSave(_nameCtrl.text, _phoneCtrl.text, _addressCtrl.text, _hoursCtrl.text, _selectedAvatar);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.brandColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: Text(
                  'Save Store Changes',
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
