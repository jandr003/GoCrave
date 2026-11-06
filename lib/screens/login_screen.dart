import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'verification_method_screen.dart';
import 'phone_entry_screen.dart';
import 'sign_up_screen.dart';
import 'forgot_password_screen.dart';
import 'admin_dashboard_screen.dart';
import 'rider_dashboard_screen.dart';
import 'restaurant_dashboard_screen.dart';
import 'main_nav_wrapper.dart';
import '../widgets/agreement_modal.dart';
import '../widgets/whatsapp_icon.dart';
import '../widgets/google_logo_icon.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  bool _isAgreed = false;
  final Color brandColor = const Color(0xFFFF5622);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocus.addListener(() => setState(() {}));
    _passwordFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    final emailInput = _emailController.text.trim().toLowerCase();

    if (emailInput.contains('@gocraveadmin.') ||
        emailInput == 'admin01' ||
        emailInput.startsWith('admin')) {
      _showRoleToast('Welcome GoCrave Admin! Entering Control Panel...');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => AdminDashboardScreen(
            adminEmail: _emailController.text.trim().isNotEmpty ? _emailController.text.trim() : 'Admin01',
          ),
        ),
        (route) => false,
      );
      return;
    }

    if (emailInput.contains('@gocraverider.') ||
        emailInput == 'rider01' ||
        emailInput.contains('rider') ||
        emailInput.contains('driver')) {
      _showRoleToast('Welcome Rider! Entering Delivery Portal...');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => RiderDashboardScreen(
            riderEmail: _emailController.text.trim().isNotEmpty ? _emailController.text.trim() : 'rider@gocraverider.ph',
          ),
        ),
        (route) => false,
      );
      return;
    }

    if (emailInput.contains('@gocravestaff.') ||
        emailInput.contains('@gocravepartner.') ||
        emailInput == 'merchant01' ||
        emailInput.contains('resto') ||
        emailInput.contains('merchant') ||
        emailInput.contains('staff')) {
      _showRoleToast('Welcome GoCrave Merchant/Staff! Entering Kitchen Portal...');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => RestaurantDashboardScreen(
            merchantEmail: _emailController.text.trim().isNotEmpty ? _emailController.text.trim() : 'resto@gocravestaff.ph',
          ),
        ),
        (route) => false,
      );
      return;
    }

    if (!_isAgreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please read and agree to the terms first."),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PhoneEntryScreen(isNewUser: false),
      ),
    );
  }

  void _showRoleToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF1E1E2C),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: brandColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.36,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: Hero(
                  tag: 'official_logo',
                  child: Image.asset(
                    'assets/images/gocrave_official_logo.png',
                    width: double.infinity,
                    height: 240,
                    fit: BoxFit.contain,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          Positioned.fill(
            top: size.height * 0.32,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF0F172A),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email Address',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      hint: 'Enter your email address',
                      controller: _emailController,
                      focusNode: _emailFocus,
                    ),
                    const SizedBox(height: 24),

                    Text(
                      'Password',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      hint: 'Enter your password',
                      controller: _passwordController,
                      obscure: _obscurePassword,
                      isPassword: true,
                      focusNode: _passwordFocus,
                      onToggle: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPasswordScreen(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                        ),
                        child: Text(
                          'Forgot password?',
                          style: GoogleFonts.poppins(
                            color: brandColor,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    GestureDetector(
                      onTap: () async {
                        if (_isAgreed) {
                          setState(() => _isAgreed = false);
                        } else {
                          final result = await showModalBottomSheet<bool>(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const AgreementModal(),
                          );
                          if (result == true) {
                            setState(() => _isAgreed = true);
                          }
                        }
                      },
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _isAgreed ? brandColor : Colors.transparent,
                              border: Border.all(
                                color: _isAgreed ? brandColor : Colors.grey[600]!,
                                width: 2,
                              ),
                            ),
                            child: _isAgreed
                                ? const Icon(Icons.check, size: 16, color: Colors.white)
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[400]),
                                children: [
                                  const TextSpan(text: "I've read and agreed to "),
                                  TextSpan(
                                    text: 'User Agreement',
                                    style: TextStyle(
                                      color: brandColor,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  const TextSpan(text: ' & '),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                      color: brandColor,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 36),

                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        onPressed: _handleSignIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: brandColor,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: brandColor.withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Sign in',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    Center(
                      child: Text(
                        'other ways to sign in',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(customChild: const GoogleLogoIcon(size: 26)),
                        const SizedBox(width: 20),
                        _buildSocialButton(icon: Icons.facebook, iconColor: const Color(0xFF1877F2)),
                        const SizedBox(width: 20),
                        _buildSocialButton(customChild: const WhatsAppIcon(size: 26)),
                      ],
                    ),

                    const SizedBox(height: 32),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUpScreen()),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[400]),
                            children: [
                              const TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                text: 'Sign Up',
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
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required FocusNode focusNode,
    TextEditingController? controller,
    bool obscure = false,
    bool isPassword = false,
    VoidCallback? onToggle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF334155), width: 1.5),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscure,
        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(color: Colors.grey[500], fontSize: 14),
          border: InputBorder.none,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: Colors.grey[500],
                    size: 20,
                  ),
                  onPressed: onToggle,
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildSocialButton({IconData? icon, Color? iconColor, Widget? customChild}) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Center(
        child: customChild ?? Icon(icon, size: 28, color: iconColor ?? Colors.white70),
      ),
    );
  }
}
