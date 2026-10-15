import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../cubit/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  // ============================================================
  // SEND OTP
  // ============================================================

  void _onSendOtp() {
    final mobile = _phoneController.text.trim();

    // Keep your existing fallback behavior.
    final phoneToPass = mobile.isEmpty ? '7339571836' : mobile;

    // Only trigger the API here.
    // Navigation happens after OtpSentState in BlocListener.
    context.read<AuthCubit>().sendOtp(phoneToPass);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          // OTP SUCCESS
          if (state is OtpSentState) {
            context.push('/otp-verification', extra: state.mobileNumber);
          }
          // AUTH ERROR
          else if (state is AuthErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFF10090A),
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: [
              // ====================================================
              // 1. GAVEL IMAGE (sized by width, pinned to top)
              // ====================================================
              Positioned(
                // Negative value moves the gavel UP. Increase 0.18 to move it
                // higher, decrease it to move it lower.
                top: -size.height * 0.18,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/Png/Login_Screen_image.png',
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: size.height * 0.4,
                      color: const Color(0xFF170B0C),
                      child: const Center(
                        child: Icon(
                          Icons.gavel_rounded,
                          size: 80,
                          color: Colors.white24,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // ====================================================
              // 2. BOTTOM FADE GRADIENT
              // ====================================================
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.30, 0.45, 0.62, 1.0],
                      colors: [
                        Colors.black.withValues(alpha: 0.0),
                        Colors.black.withValues(alpha: 0.05),
                        Colors.black.withValues(alpha: 0.25),
                        const Color(0xFF10090A).withValues(alpha: 0.85),
                        const Color(0xFF10090A),
                      ],
                    ),
                  ),
                ),
              ),

              // ====================================================
              // 3. GLASS LOGIN PANEL
              // ====================================================
              Positioned(
                top: size.height * 0.325,
                left: 3,
                right: 3,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        // More see-through at the top, darker at the bottom
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFF130D0E).withValues(alpha: 0.45),
                            const Color(0xFF130D0E).withValues(alpha: 0.92),
                          ],
                          stops: const [0.0, 0.45],
                        ),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.18),
                          width: 1,
                        ),
                      ),
                      child: SafeArea(
                        top: false,
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(20, 34, 20, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ==========================================
                              // 4. WELCOME
                              // ==========================================
                              Center(
                                child: Text(
                                  'Welcome !',
                                  style:
                                      AppTextStyles.headingLarge(
                                        color: Colors.white,
                                      ).copyWith(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.6,
                                        height: 1.1,
                                      ),
                                ),
                              ),

                              const SizedBox(height: 34),

                              // ==========================================
                              // 5. MOBILE NUMBER LABEL
                              // ==========================================
                              Text(
                                'Mobile Number',
                                style:
                                    AppTextStyles.bodyMedium(
                                      color: Colors.white,
                                    ).copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),

                              const SizedBox(height: 10),

                              // ==========================================
                              // 6. MOBILE NUMBER INPUT
                              // ==========================================
                              Container(
                                height: 62,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.10),
                                  borderRadius: BorderRadius.circular(13),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.22),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    // COUNTRY CODE
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 12,
                                      ),
                                      child: Row(
                                        children: [
                                          const Text(
                                            '+91',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            size: 18,
                                            color: Colors.white.withValues(alpha: 
                                              0.65,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // VERTICAL DIVIDER
                                    Container(
                                      width: 1,
                                      height: 30,
                                      color: Colors.white.withValues(alpha: 0.18),
                                    ),

                                    const SizedBox(width: 12),

                                    // PHONE ICON
                                    Icon(
                                      Icons.phone_outlined,
                                      size: 21,
                                      color: Colors.white.withValues(alpha: 0.68),
                                    ),

                                    const SizedBox(width: 11),

                                    // PHONE TEXT FIELD
                                    Expanded(
                                      child: TextField(
                                        controller: _phoneController,
                                        keyboardType: TextInputType.phone,
                                        textInputAction: TextInputAction.done,
                                        cursorColor: Colors.white,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'Enter the mobile number',
                                          hintStyle: TextStyle(
                                            color: Colors.white.withValues(alpha: 
                                              0.38,
                                            ),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.zero,
                                          isDense: true,
                                          filled: false,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 30),

                              // ==========================================
                              // 7. GET OTP BUTTON
                              // ==========================================
                              BlocBuilder<AuthCubit, AuthState>(
                                builder: (context, state) {
                                  final isLoading = state is AuthLoading;

                                  return SizedBox(
                                    width: double.infinity,
                                    height: 56,
                                    child: ElevatedButton(
                                      onPressed: isLoading ? null : _onSendOtp,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: const Color(
                                          0xFF07152F,
                                        ),
                                        disabledBackgroundColor: Colors.white
                                            .withValues(alpha: 0.75),
                                        disabledForegroundColor: const Color(
                                          0xFF07152F,
                                        ),
                                        elevation: 0,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            13,
                                          ),
                                        ),
                                      ),
                                      child: isLoading
                                          ? const SizedBox(
                                              width: 21,
                                              height: 21,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Color(0xFF07152F),
                                              ),
                                            )
                                          : const Text(
                                              'Get OTP',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(height: 30),

                              // ==========================================
                              // 8. OR CONTINUE WITH
                              // ==========================================
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: Colors.white.withValues(alpha: 0.18),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Text(
                                      'or continue with',
                                      style: TextStyle(
                                        color: Colors.white.withValues(alpha: 0.62),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: Colors.white.withValues(alpha: 0.18),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 24),

                              // ==========================================
                              // 9. SOCIAL LOGIN BUTTONS
                              // ==========================================
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // GOOGLE
                                  _buildSocialCard(
                                    child: _buildGoogleIcon(),
                                    isDark: true,
                                  ),

                                  const SizedBox(width: 18),

                                  // FACEBOOK
                                  _buildSocialCard(
                                    child: _buildFacebookIcon(),
                                    isDark: true,
                                  ),

                                  const SizedBox(width: 18),

                                  // APPLE
                                  _buildSocialCard(
                                    child: _buildAppleIcon(true),
                                    isDark: true,
                                  ),
                                ],
                              ),

                              const SizedBox(height: 18),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================================================================
  // SOCIAL LOGIN CARD
  // ================================================================

  Widget _buildSocialCard({required Widget child, required bool isDark}) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.22), width: 1),
      ),
      child: Center(child: child),
    );
  }

  // ================================================================
  // GOOGLE ICON
  // ================================================================

  Widget _buildGoogleIcon() {
    return const SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(painter: GoogleGLogoPainter()),
    );
  }

  // ================================================================
  // FACEBOOK ICON
  // ================================================================

  Widget _buildFacebookIcon() {
    return Container(
      width: 25,
      height: 25,
      decoration: const BoxDecoration(
        color: Color(0xFF1877F2),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Text(
          'f',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
            height: 1.1,
          ),
        ),
      ),
    );
  }

  // ================================================================
  // APPLE ICON
  // ================================================================

  Widget _buildAppleIcon(bool isDark) {
    return const Icon(Icons.apple_rounded, size: 27, color: Colors.white);
  }
}

// ====================================================================
// GOOGLE G LOGO PAINTER
// ====================================================================

class GoogleGLogoPainter extends CustomPainter {
  const GoogleGLogoPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final double cx = w / 2;
    final double cy = h / 2;

    final double r = w / 2 - 2;
    final double strokeWidth = w * 0.22;

    final Rect rect = Rect.fromCircle(center: Offset(cx, cy), radius: r);

    Paint arcPaint(Color color) => Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    // Google arc segments
    canvas.drawArc(rect, -2.8, 1.4, false, arcPaint(const Color(0xFFEA4335)));
    canvas.drawArc(rect, -4.0, 1.2, false, arcPaint(const Color(0xFFFBBC05)));
    canvas.drawArc(rect, 0.7, 1.5, false, arcPaint(const Color(0xFF34A853)));
    canvas.drawArc(rect, -0.2, 0.9, false, arcPaint(const Color(0xFF4285F4)));

    // Google blue bar
    final Paint barPaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;

    final Rect barRect = Rect.fromLTRB(
      cx - 1,
      cy - strokeWidth / 2,
      cx + r + 1,
      cy + strokeWidth / 2,
    );

    canvas.drawRect(barRect, barPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
