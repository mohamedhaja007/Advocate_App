import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class AdvocateLoginScreen extends StatefulWidget {
  const AdvocateLoginScreen({super.key});

  @override
  State<AdvocateLoginScreen> createState() => _AdvocateLoginScreenState();
}

class _AdvocateLoginScreenState extends State<AdvocateLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignIn() {
    // Navigate to Advocate Main Dashboard
    context.go('/advocate/home');
  }

  @override
  Widget build(BuildContext context) {
    const bgDark = Color(0xFF0F0D11);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: bgDark,
      ),
      child: Scaffold(
        backgroundColor: bgDark,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Gradient Logo Header
              Container(
                height: 155,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF5244E9),
                      Color(0xFF2E2683),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                  border: Border.all(
                    color: const Color(0xFF6554F8).withValues(alpha: 0.6),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5244E9).withValues(alpha: 0.35),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: SafeArea(
                  bottom: false,
                  child: Center(
                    child: Text(
                      'AVVOCATAI',
                      style: AppTextStyles.brandHeadline(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ).copyWith(letterSpacing: 2.5),
                    ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome !',
                      style: AppTextStyles.headingLarge(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Sign in to your practice',
                      style: AppTextStyles.bodyMedium(
                        color: const Color(0xFF94A3B8),
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Email Input Field
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B181E),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFF2E2733)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(Icons.email_outlined, color: Color(0xFF94A3B8), size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _emailController,
                              style: const TextStyle(color: Colors.white, fontSize: 15),
                              cursorColor: AppColors.primaryBlue,
                              decoration: const InputDecoration(
                                hintText: 'Enter the email',
                                hintStyle: TextStyle(color: Color(0xFF64748B), fontSize: 15),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                isDense: true,
                                filled: false,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Password Input Field
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B181E),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFF2E2733)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(Icons.lock_outline_rounded, color: Color(0xFF94A3B8), size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              style: const TextStyle(color: Colors.white, fontSize: 15),
                              cursorColor: AppColors.primaryBlue,
                              decoration: const InputDecoration(
                                hintText: 'Enter password',
                                hintStyle: TextStyle(color: Color(0xFF64748B), fontSize: 15),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                isDense: true,
                                filled: false,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            child: Icon(
                              _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: const Color(0xFF94A3B8),
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Forgot Password
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Forgot Password ?',
                          style: TextStyle(
                            color: Color(0xFF4F75FF),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Sign In CTA Button
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _onSignIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4349ED),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Sign in',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Divider: New to AvvocatAI
                    Row(
                      children: [
                        const Expanded(child: Divider(color: Color(0xFF2E2733))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            'New to AvvocatAI',
                            style: AppTextStyles.caption(
                              color: const Color(0xFF94A3B8),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const Expanded(child: Divider(color: Color(0xFF2E2733))),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Create New Account Button
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: OutlinedButton(
                        onPressed: () => context.push('/advocate/signup-step-1'),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B181E),
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Color(0xFF2E2733)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Create new account',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
