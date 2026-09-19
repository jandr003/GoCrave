import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_nav_wrapper.dart';
import '../data/user_profile.dart';

class ProfileSetupScreen extends StatefulWidget {
  final String? phoneNumber;
  const ProfileSetupScreen({super.key, this.phoneNumber});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final Color brandColor = const Color(0xFFFF5622);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  
  String _selectedGender = 'Male';
  String? _selectedAvatarUrl;

  @override
  void initState() {
    super.initState();
    if (widget.phoneNumber != null) {
      _phoneController.text = widget.phoneNumber!;
    }
  }

  final List<String> _avatars = [
    'https://api.dicebear.com/7.x/adventurer/png?seed=Felix',
    'https://api.dicebear.com/7.x/adventurer/png?seed=Jack',
    'https://api.dicebear.com/7.x/adventurer/png?seed=Oliver',
    'https://api.dicebear.com/7.x/adventurer/png?seed=Aneka',
    'https://api.dicebear.com/7.x/adventurer/png?seed=Zoe',
    'https://api.dicebear.com/7.x/adventurer/png?seed=Sara',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: brandColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.month}/${picked.day}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Set Up Profile',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[200]!, width: 2),
                    image: _selectedAvatarUrl != null
                        ? DecorationImage(
                            image: NetworkImage(_selectedAvatarUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _selectedAvatarUrl == null
                      ? Icon(
                          Icons.person_outline,
                          size: 70,
                          color: Colors.grey[400],
                        )
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: brandColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Choose your avatar',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _avatars.length,
                itemBuilder: (context, index) {
                  bool isSelected = _selectedAvatarUrl == _avatars[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatarUrl = _avatars[index];
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? brandColor : Colors.grey[200]!,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          _avatars[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            _buildInputField('Full Name', 'Enter your full name', _nameController),
            const SizedBox(height: 20),
            _buildInputField(
              'Phone Number', 
              '0912 345 6789', 
              _phoneController, 
              keyboardType: TextInputType.phone,
              readOnly: widget.phoneNumber != null,
              suffixIcon: widget.phoneNumber != null ? Icons.verified : null,
              suffixIconColor: widget.phoneNumber != null ? Colors.green : brandColor,
            ),
            const SizedBox(height: 20),
            _buildInputField(
              'Date of Birth', 
              'MM/DD/YYYY', 
              _dobController, 
              readOnly: true, 
              onTap: () => _selectDate(context),
              suffixIcon: Icons.calendar_today,
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gender',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildGenderChip('Male'),
                    const SizedBox(width: 10),
                    _buildGenderChip('Female'),
                    const SizedBox(width: 10),
                    _buildGenderChip('Other'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  UserProfile().updateProfile(
                    fullName: _nameController.text,
                    phoneNumber: _phoneController.text,
                    dateOfBirth: _dobController.text,
                    gender: _selectedGender,
                    profilePic: _selectedAvatarUrl ?? '',
                  );

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainNavWrapper(initialIndex: 0),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Get Started',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label, 
    String hint, 
    TextEditingController controller, 
    {TextInputType keyboardType = TextInputType.text, bool readOnly = false, VoidCallback? onTap, IconData? suffixIcon, Color? suffixIconColor}
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFFBFBFB),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!, width: 1.5),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            readOnly: readOnly,
            onTap: onTap,
            style: GoogleFonts.poppins(
              fontSize: 15, 
              fontWeight: FontWeight.w500,
              color: readOnly ? Colors.grey[600] : Colors.black,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 14),
              border: InputBorder.none,
              suffixIcon: suffixIcon != null ? Icon(suffixIcon, size: 20, color: suffixIconColor ?? brandColor) : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderChip(String gender) {
    bool isSelected = _selectedGender == gender;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = gender;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? brandColor : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? brandColor : Colors.grey[200]!,
            width: 1.5,
          ),
        ),
        child: Text(
          gender,
          style: GoogleFonts.poppins(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
