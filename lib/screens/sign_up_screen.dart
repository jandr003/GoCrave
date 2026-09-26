import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'verification_method_screen.dart';
import 'phone_entry_screen.dart';
import 'login_screen.dart';
import '../widgets/whatsapp_icon.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isAgreed = false;
  final Color brandColor = const Color(0xFFFF5622);

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocus.addListener(() => setState(() {}));
    _passwordFocus.addListener(() => setState(() {}));
    _confirmPasswordFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Center(
                child: Hero(
                  tag: 'official_logo',
                  child: Image.asset(
                    'assets/images/gocrave_official_logo.png',
                    height: 180,
                    width: 280,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              _buildLabel('Email Address'),
              const SizedBox(height: 8),
              _buildTextField(
                hint: 'Enter your email address',
                focusNode: _emailFocus,
              ),
              const SizedBox(height: 24),
              
              _buildLabel('Password'),
              const SizedBox(height: 8),
              _buildTextField(
                hint: 'Enter your password',
                obscure: _obscurePassword,
                isPassword: true,
                focusNode: _passwordFocus,
                onToggle: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
              const SizedBox(height: 24),

              _buildLabel('Confirm Password'),
              const SizedBox(height: 8),
              _buildTextField(
                hint: 'Enter your password',
                obscure: _obscureConfirmPassword,
                isPassword: true,
                focusNode: _confirmPasswordFocus,
                onToggle: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
              ),
              
              const SizedBox(height: 24),
              
              GestureDetector(
                onTap: () => setState(() => _isAgreed = !_isAgreed),
                child: Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isAgreed ? brandColor : Colors.transparent,
                        border: Border.all(
                          color: _isAgreed ? brandColor : Colors.grey[300]!,
                          width: 1.5,
                        ),
                      ),
                      child: _isAgreed 
                        ? const Icon(Icons.check, size: 14, color: Colors.white) 
                        : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
                          children: [
                            const TextSpan(text: "I've read and agreed to "),
                            TextSpan(
                              text: 'User Agreement',
                              style: TextStyle(color: brandColor, fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(color: brandColor, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PhoneEntryScreen(isNewUser: true),
                      ),
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
                    'Sign Up',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              Center(
                child: Text(
                  'other ways to sign up',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[400],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton(icon: Icons.g_mobiledata),
                  const SizedBox(width: 20),
                  _buildSocialButton(icon: Icons.facebook),
                  const SizedBox(width: 20),
                  _buildSocialButton(customChild: const WhatsAppIcon(size: 26)),
                ],
              ),

              const SizedBox(height: 40),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[600]),
                      children: [
                        const TextSpan(text: 'Already have an account? '),
                        TextSpan(
                          text: 'Sign in',
                          style: TextStyle(
                            color: brandColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required FocusNode focusNode,
    bool obscure = false,
    bool isPassword = false,
    VoidCallback? onToggle,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFBFB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: TextField(
        focusNode: focusNode,
        obscureText: obscure,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(color: Colors.grey[300], fontSize: 14),
          border: InputBorder.none,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                  onPressed: onToggle,
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildSocialButton({IconData? icon, Widget? customChild}) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Center(
        child: customChild ?? Icon(icon, size: 28, color: Colors.black87),
      ),
    );
  }
}
