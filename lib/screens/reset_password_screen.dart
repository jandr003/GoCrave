import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final Color brandColor = const Color(0xFFFF5622);
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _newPassController.addListener(_onPasswordChanged);
    _confirmPassController.addListener(_onPasswordChanged);
  }

  void _onPasswordChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _newPassController.removeListener(_onPasswordChanged);
    _confirmPassController.removeListener(_onPasswordChanged);
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  String get _newPass => _newPassController.text;
  String get _confirmPass => _confirmPassController.text;

  bool get _hasMinLength => _newPass.length >= 8;
  bool get _hasUppercase => RegExp(r'[A-Z]').hasMatch(_newPass);
  bool get _hasLowercase => RegExp(r'[a-z]').hasMatch(_newPass);
  bool get _hasDigit => RegExp(r'[0-9]').hasMatch(_newPass);
  bool get _hasSpecialChar => RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(_newPass);
  bool get _passwordsMatch => _newPass.isNotEmpty && _newPass == _confirmPass;

  bool get _isAllRequirementsMet =>
      _hasMinLength &&
      _hasUppercase &&
      _hasLowercase &&
      _hasDigit &&
      _hasSpecialChar &&
      _passwordsMatch;

  int get _metCount {
    int count = 0;
    if (_hasMinLength) count++;
    if (_hasUppercase) count++;
    if (_hasLowercase) count++;
    if (_hasDigit) count++;
    if (_hasSpecialChar) count++;
    return count;
  }

  double get _strengthProgress => _metCount / 5.0;

  Color get _strengthColor {
    if (_newPass.isEmpty) return Colors.grey[300]!;
    if (_metCount <= 2) return Colors.redAccent;
    if (_metCount <= 4) return Colors.orangeAccent;
    return Colors.green;
  }

  String get _strengthText {
    if (_newPass.isEmpty) return 'Enter Password';
    if (_metCount <= 2) return 'Weak';
    if (_metCount <= 4) return 'Medium';
    return 'Strong';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: brandColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: size.height * 0.12,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Set New Password',
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Choose a strong password to protect your account',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Password',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(
                      hint: 'Enter new password',
                      controller: _newPassController,
                      obscure: _obscureNew,
                      onToggle: () => setState(() => _obscureNew = !_obscureNew),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Confirm Password',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(
                      hint: 'Confirm new password',
                      controller: _confirmPassController,
                      obscure: _obscureConfirm,
                      onToggle: () => setState(() => _obscureConfirm = !_obscureConfirm),
                    ),
                    const SizedBox(height: 24),

                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9F9FB),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFEEEEEE)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Password Strength',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _strengthColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  _strengthText,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: _strengthColor == Colors.grey[300]!
                                        ? Colors.grey
                                        : _strengthColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: _strengthProgress,
                              backgroundColor: Colors.grey[200],
                              color: _strengthColor,
                              minHeight: 6,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            'Password Requirements:',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildCheckItem('At least 8 characters long', _hasMinLength),
                          _buildCheckItem('At least 1 uppercase letter (A-Z)', _hasUppercase),
                          _buildCheckItem('At least 1 lowercase letter (a-z)', _hasLowercase),
                          _buildCheckItem('At least 1 number (0-9)', _hasDigit),
                          _buildCheckItem('At least 1 special character (@#\$%^&*!)', _hasSpecialChar),
                          _buildCheckItem('Confirm Password matches New Password', _passwordsMatch),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    GestureDetector(
                      onTap: !_isAllRequirementsMet
                          ? () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Please fulfill all password requirements above.',
                                    style: GoogleFonts.poppins(),
                                  ),
                                  backgroundColor: Colors.redAccent,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            }
                          : null,
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _isAllRequirementsMet
                              ? () {
                                  _showSuccessDialog();
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: brandColor,
                            disabledBackgroundColor: Colors.grey[300],
                            foregroundColor: Colors.white,
                            disabledForegroundColor: Colors.grey[500],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: _isAllRequirementsMet ? 4 : 0,
                            shadowColor: brandColor.withOpacity(0.4),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _isAllRequirementsMet ? Icons.check_circle_rounded : Icons.lock_outline,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Update Password',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckItem(String label, bool isMet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isMet ? Colors.green.withOpacity(0.06) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: Icon(
                isMet ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
                key: ValueKey<bool>(isMet),
                size: 18,
                color: isMet ? Colors.green : Colors.grey[400],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: isMet ? FontWeight.w600 : FontWeight.w500,
                  color: isMet ? const Color(0xFF2E7D32) : Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required TextEditingController controller,
    bool obscure = false,
    VoidCallback? onToggle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFBFB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!, width: 1.5),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 14),
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(
              obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: Colors.grey[400],
              size: 20,
            ),
            onPressed: onToggle,
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_outline, color: Colors.green, size: 60),
            ),
            const SizedBox(height: 24),
            Text(
              'Success!',
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Your password has been reset successfully.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Back to Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
