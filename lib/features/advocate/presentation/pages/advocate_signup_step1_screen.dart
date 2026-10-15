import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class AdvocateSignupStep1Screen extends StatefulWidget {
  const AdvocateSignupStep1Screen({super.key});

  @override
  State<AdvocateSignupStep1Screen> createState() =>
      _AdvocateSignupStep1ScreenState();
}

class _AdvocateSignupStep1ScreenState extends State<AdvocateSignupStep1Screen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final TextEditingController _enrolmentController = TextEditingController(text: 'D/1842/2011');
  final TextEditingController _yearController = TextEditingController(text: '2015');

  final TextEditingController _chamberController = TextEditingController(text: 'Chamber 412, Lawyers Chambers Block');
  final TextEditingController _courtComplexController = TextEditingController(text: 'High Court of Delhi, Sher Shah Road');
  final TextEditingController _cityController = TextEditingController(text: 'New Delhi');
  final TextEditingController _pincodeController = TextEditingController(text: '110503');

  String? _selectedStateBarCouncil = 'Bar Council of Delhi';
  String _selectedForum = 'High Court';
  bool _affirmationChecked = true;
  bool _obscurePass1 = true;
  bool _obscurePass2 = true;

  final List<String> _stateBarCouncils = [
    'Bar Council of Delhi',
    'Bar Council of Tamil Nadu & Puducherry',
    'Bar Council of Maharashtra & Goa',
    'Bar Council of Karnataka',
    'Bar Council of Kerala',
    'Bar Council of Uttar Pradesh',
  ];

  final List<String> _forums = [
    'Supreme Court of India',
    'High Court',
    'District & Sessions',
    'Tribunals (NCLT / DRT)',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _enrolmentController.dispose();
    _yearController.dispose();
    _chamberController.dispose();
    _courtComplexController.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const bgDark = Color(0xFF0F0D11);
    const cardBg = Color(0xFF16131A);
    const borderDark = Color(0xFF28232F);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: bgDark,
      ),
      child: Scaffold(
        backgroundColor: bgDark,
        body: Column(
          children: [
            // Top Gradient Title Container
            Container(
              height: 140,
              width: double.infinity,
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

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row: Back button, STEP 1 OF 2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: cardBg,
                              shape: BoxShape.circle,
                              border: Border.all(color: borderDark),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        Text(
                          'STEP 1 OF 2',
                          style: AppTextStyles.caption(
                            color: const Color(0xFF94A3B8),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ).copyWith(letterSpacing: 1.2),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                      // Screen Title & Subtitle
                      Text(
                        'Join AvvocatAI as an Advocate',
                        style: AppTextStyles.headingLarge(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Verify your credentials to activate your digital chambers and consultation desk.',
                        style: AppTextStyles.bodySmall(
                          color: const Color(0xFF94A3B8),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ==========================================
                      // CARD 1: Basic account information
                      // ==========================================
                      _buildSectionCard(
                        icon: Icons.badge_outlined,
                        title: 'Basic account information',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Name *'),
                            _buildInputField(
                              controller: _nameController,
                              hint: 'Enter the Name',
                              icon: Icons.person_outline_rounded,
                            ),
                            const SizedBox(height: 14),

                            _buildFieldLabel('Mobile number *'),
                            _buildInputField(
                              controller: _mobileController,
                              hint: 'Enter the Mobile number',
                              icon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(height: 14),

                            _buildFieldLabel('Email *'),
                            _buildInputField(
                              controller: _emailController,
                              hint: 'Enter the Email',
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 14),

                            _buildFieldLabel('Create new password *'),
                            _buildInputField(
                              controller: _passwordController,
                              hint: 'New Password',
                              icon: Icons.lock_outline_rounded,
                              obscureText: _obscurePass1,
                              suffixIcon: GestureDetector(
                                onTap: () => setState(() => _obscurePass1 = !_obscurePass1),
                                child: Icon(
                                  _obscurePass1 ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                  color: const Color(0xFF94A3B8),
                                  size: 18,
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),

                            _buildFieldLabel('Confirm Password'),
                            _buildInputField(
                              controller: _confirmPasswordController,
                              hint: 'Confirm Password',
                              icon: Icons.lock_outline_rounded,
                              obscureText: _obscurePass2,
                              suffixIcon: GestureDetector(
                                onTap: () => setState(() => _obscurePass2 = !_obscurePass2),
                                child: Icon(
                                  _obscurePass2 ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                  color: const Color(0xFF94A3B8),
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),

                      // ==========================================
                      // CARD 2: Bar Council Credentials
                      // ==========================================
                      _buildSectionCard(
                        icon: Icons.account_balance_rounded,
                        title: 'Bar Council Credentials',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('State bar council *'),
                            Container(
                              height: 52,
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1B1720),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: borderDark),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _selectedStateBarCouncil,
                                  dropdownColor: const Color(0xFF1B1720),
                                  isExpanded: true,
                                  icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF94A3B8)),
                                  items: _stateBarCouncils.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item, style: const TextStyle(color: Colors.white, fontSize: 14)),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _selectedStateBarCouncil = val;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),

                            // Enrolment No & Year Row
                            Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildFieldLabel('Enrolment No. *'),
                                      _buildInputField(
                                        controller: _enrolmentController,
                                        hint: 'e.g. D/1842/2011',
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildFieldLabel('Year of Enrolment *'),
                                      _buildInputField(
                                        controller: _yearController,
                                        hint: '2015',
                                        keyboardType: TextInputType.number,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),

                            _buildFieldLabel('Certificate of Practice / Sanad Card *'),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1B1720),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(0xFF2E2733),
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryBlue.withValues(alpha: 0.15),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.cloud_upload_outlined,
                                      color: AppColors.primaryBlue,
                                      size: 26,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Tap to upload Sanad PDF or Card photo',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Supported: PDF, JPG, PNG (Max 10MB)',
                                    style: TextStyle(
                                      color: Color(0xFF94A3B8),
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),

                      // ==========================================
                      // CARD 3: Court Jurisdiction & Practice
                      // ==========================================
                      _buildSectionCard(
                        icon: Icons.gavel_rounded,
                        title: 'Court Jurisdiction & Practice',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Primary Appearing Forum *'),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _forums.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2.2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) {
                                final forum = _forums[index];
                                final isSelected = _selectedForum == forum;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedForum = forum;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: isSelected ? const Color(0xFF4349ED) : const Color(0xFF1B1720),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected ? const Color(0xFF4349ED) : borderDark,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            forum,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        if (isSelected)
                                          const Icon(Icons.check_circle_rounded, color: Colors.white, size: 16),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 14),

                            _buildFieldLabel('Chamber Number / Room'),
                            _buildInputField(
                              controller: _chamberController,
                              hint: 'Chamber 412, Lawyers Chambers Block',
                            ),
                            const SizedBox(height: 14),

                            _buildFieldLabel('Court Complex / Attached Court'),
                            _buildInputField(
                              controller: _courtComplexController,
                              hint: 'High Court of Delhi, Sher Shah Road',
                            ),
                            const SizedBox(height: 14),

                            Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildFieldLabel('City & State'),
                                      _buildInputField(
                                        controller: _cityController,
                                        hint: 'New Delhi',
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildFieldLabel('Pincode'),
                                      _buildInputField(
                                        controller: _pincodeController,
                                        hint: '110503',
                                        keyboardType: TextInputType.number,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Checkbox Affirmation
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: _affirmationChecked,
                            activeColor: const Color(0xFF4349ED),
                            checkColor: Colors.white,
                            side: const BorderSide(color: Color(0xFF475569)),
                            onChanged: (val) {
                              setState(() {
                                _affirmationChecked = val ?? false;
                              });
                            },
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: RichText(
                                text: const TextSpan(
                                  style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12, height: 1.4),
                                  children: [
                                    TextSpan(
                                      text:
                                          'I solemnly affirm that I am an enrolled Advocate in good standing with the State Bar Council, governed by the Advocates Act, 1961, and hold an unrevoked authority to practice law.\n',
                                    ),
                                    TextSpan(text: 'Subject to AvvocatAI '),
                                    TextSpan(
                                      text: 'Terms of Counsel Engagement',
                                      style: TextStyle(color: Color(0xFF4F75FF), fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(text: ' and '),
                                    TextSpan(
                                      text: 'Privacy Protocol',
                                      style: TextStyle(color: Color(0xFF4F75FF), fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(text: '.'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Continue CTA
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            context.push('/advocate/signup-step-2');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4349ED),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Continue to Practice Setup',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 6),
                              Icon(Icons.arrow_forward_rounded, size: 18),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Already have account
                      Center(
                        child: GestureDetector(
                          onTap: () => context.pop(),
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                              children: [
                                TextSpan(text: 'Already have a registered account? '),
                                TextSpan(
                                  text: 'Sign In',
                                  style: TextStyle(color: Color(0xFF4F75FF), fontWeight: FontWeight.bold),
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
            ],
          ),
        ),
      );
  }




  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF16131A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF28232F)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primaryBlue, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF94A3B8),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    Widget? suffixIcon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1720),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF28232F)),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: const Color(0xFF94A3B8), size: 18),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              cursorColor: AppColors.primaryBlue,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 13),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                filled: false,
              ),
            ),
          ),
          ?suffixIcon,
        ],
      ),
    );
  }
}
