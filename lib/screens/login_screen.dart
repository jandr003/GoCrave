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
    final emailInput = _emailController.text.trim();

    if (emailInput.toLowerCase() == 'admin01' || emailInput.toLowerCase() == 'admin@gocrave.app') {
      _showRoleToast('Welcome Super Admin Admin01! Entering Control Panel...');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminDashboardScreen(adminEmail: 'Admin01'),
        ),
        (route) => false,
      );
      return;
    }

    if (emailInput.toLowerCase().contains('resto') ||
        emailInput.toLowerCase().contains('merchant') ||
        emailInput.toLowerCase().contains('staff')) {
      _showRoleToast('Welcome GoCrave Central Kitchen! Entering Kitchen Merchant Portal...');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => RestaurantDashboardScreen(
            merchantEmail: emailInput.isNotEmpty ? emailInput : 'resto@gocrave.app',
          ),
        ),
        (route) => false,
      );
      return;
    }

    if (emailInput.toLowerCase().contains('rider') ||
        emailInput.toLowerCase().contains('driver')) {
      _showRoleToast('Welcome Rider Ricardo Dalisay! Entering Delivery Portal...');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => RiderDashboardScreen(
            riderEmail: emailInput.isNotEmpty ? emailInput : 'rider@gocrave.app',
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

  void _showPlatformPortalsModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Explore Platform Portals',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'Select a platform role to test its live dashboard',
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
              ),
              const SizedBox(height: 20),
              _buildPortalTile(
                icon: Icons.admin_panel_settings_rounded,
                color: const Color(0xFF1E1E2C),
                title: 'Admin Control Panel',
                subtitle: 'Super Admin Admin01 • Sales, orders & menu',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminDashboardScreen(adminEmail: 'Admin01'),
                    ),
                  );
                },
              ),
              _buildPortalTile(
                icon: Icons.store_rounded,
                color: const Color(0xFF1B2430),
                title: 'Restaurant Merchant Portal',
                subtitle: 'GoCrave Central Kitchen • Kitchen order pipeline',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RestaurantDashboardScreen(merchantEmail: 'resto@gocrave.app'),
                    ),
                  );
                },
              ),
              _buildPortalTile(
                icon: Icons.two_wheeler_rounded,
                color: brandColor,
                title: 'Rider Delivery Portal',
                subtitle: 'Ricardo Dalisay • Active delivery workflow',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RiderDashboardScreen(riderEmail: 'rider@gocrave.app'),
                    ),
                  );
                },
              ),
              _buildPortalTile(
                icon: Icons.person_rounded,
                color: Colors.blueAccent,
                title: 'Customer Mobile App',
                subtitle: 'Browse food menu, place orders & rewards',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainNavWrapper(initialIndex: 0),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPortalTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FC),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFEEEEEE)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
            ],
          ),
        ),
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
                color: Colors.white,
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
                        color: Colors.black,
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
                        color: Colors.black,
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
                                color: _isAgreed ? brandColor : Colors.grey[300]!,
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
                                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
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
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

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
                            style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[600]),
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
        color: const Color(0xFFFBFBFB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!, width: 1.5),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscure,
        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 14),
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
