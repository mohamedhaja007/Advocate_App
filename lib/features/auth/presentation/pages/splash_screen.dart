import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.go('/get-started');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.primaryNavy,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Official Logo representation matching Reference Image 3
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: AppColors.white.withAlpha(20),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white.withAlpha(40), width: 1.5),
              ),
              child: const Icon(
                Icons.balance_rounded,
                size: 48,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 24),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Avvocat',
                    style: AppTextStyles.brandHeadline(
                      color: AppColors.white,
                      fontSize: 32,
                    ),
                  ),
                  TextSpan(
                    text: '.ai',
                    style: AppTextStyles.brandHeadline(
                      color: AppColors.primaryBlue,
                      fontSize: 32,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "India's First AI-Powered\nLegal Help at Your Fingertips.",
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium(
                color: AppColors.white.withAlpha(200),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
