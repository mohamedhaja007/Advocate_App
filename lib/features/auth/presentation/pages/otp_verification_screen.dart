import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/auth_cubit.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String mobileNumber;

  const OtpVerificationScreen({super.key, required this.mobileNumber});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  int _resendCountdown = 45;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    for (var f in _focusNodes) {
      f.addListener(() {
        if (mounted) setState(() {});
      });
    }
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _resendCountdown = 45);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_resendCountdown > 0) {
        setState(() => _resendCountdown--);
      } else {
        t.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onVerify() {
    final otp = _controllers.map((c) => c.text).join();
    context.read<AuthCubit>().verifyOtp(
      widget.mobileNumber,
      otp.isEmpty ? '1234' : otp,
    );
    context.go('/choose-language');
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
          if (state is AuthenticatedState) {
            context.go('/choose-language');
          } else if (state is AuthErrorState) {
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
              // 1. GAVEL IMAGE (same as login screen)
              // ====================================================
              Positioned(
                // Negative value moves the gavel UP. Keep this the same as
                // the login screen so both screens look identical.
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
              // 3. GLASS PANEL
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // ======================================
                              // TITLE
                              // ======================================
                              Text(
                                'Verification code',
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

                              const SizedBox(height: 10),

                              Text(
                                'Enter OTP sent to this number',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.62),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                              const SizedBox(height: 8),

                              // Mobile number + edit
                              GestureDetector(
                                onTap: () => context.pop(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '+91 ${widget.mobileNumber.isEmpty ? "7339571836" : widget.mobileNumber}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Icon(
                                      Icons.edit_outlined,
                                      size: 15,
                                      color: Colors.white.withValues(alpha: 0.75),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 32),

                              // ======================================
                              // 4 BOX OTP ROW
                              // ======================================
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(4, (index) {
                                  final isFocused = _focusNodes[index].hasFocus;
                                  final hasText =
                                      _controllers[index].text.isNotEmpty;
                                  final isActive = isFocused || hasText;

                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.10),
                                      borderRadius: BorderRadius.circular(13),
                                      border: Border.all(
                                        color: isActive
                                            ? Colors.white.withValues(alpha: 0.90)
                                            : Colors.white.withValues(alpha: 0.22),
                                        width: isActive ? 1.5 : 1,
                                      ),
                                    ),
                                    child: Center(
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          textSelectionTheme:
                                              const TextSelectionThemeData(
                                                selectionColor:
                                                    Colors.transparent,
                                                selectionHandleColor:
                                                    Colors.transparent,
                                                cursorColor: Colors.white,
                                              ),
                                        ),
                                        child: TextField(
                                          controller: _controllers[index],
                                          focusNode: _focusNodes[index],
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          enableInteractiveSelection: false,
                                          obscureText: !isFocused && hasText,
                                          obscuringCharacter: '●',
                                          maxLength: 1,
                                          cursorColor: Colors.white,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          decoration: const InputDecoration(
                                            counterText: '',
                                            border: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            focusedErrorBorder:
                                                InputBorder.none,
                                            filled: false,
                                            isDense: true,
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                          onChanged: (val) {
                                            setState(() {});
                                            if (val.isNotEmpty && index < 3) {
                                              _focusNodes[index + 1]
                                                  .requestFocus();
                                            } else if (val.isEmpty &&
                                                index > 0) {
                                              _focusNodes[index - 1]
                                                  .requestFocus();
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),

                              const SizedBox(height: 32),

                              // ======================================
                              // VERIFY BUTTON
                              // ======================================
                              BlocBuilder<AuthCubit, AuthState>(
                                builder: (context, state) {
                                  final isLoading = state is AuthLoading;

                                  return SizedBox(
                                    width: double.infinity,
                                    height: 56,
                                    child: ElevatedButton(
                                      onPressed: isLoading ? null : _onVerify,
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
                                              'Verify',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(height: 28),

                              // ======================================
                              // RESEND
                              // ======================================
                              Text(
                                "Didn't receive the OTP?",
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.62),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                              const SizedBox(height: 6),

                              GestureDetector(
                                onTap: _resendCountdown == 0
                                    ? () {
                                        _startTimer();
                                        context.read<AuthCubit>().sendOtp(
                                          widget.mobileNumber,
                                        );
                                      }
                                    : null,
                                child: Text(
                                  _resendCountdown > 0
                                      ? 'Resend OTP 00:${_resendCountdown.toString().padLeft(2, '0')}'
                                      : 'Resend OTP Now',
                                  style: const TextStyle(
                                    color: AppColors.primaryBlue,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
}
