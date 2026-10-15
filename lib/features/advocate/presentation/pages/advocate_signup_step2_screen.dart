import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class AdvocateSignupStep2Screen extends StatefulWidget {
  const AdvocateSignupStep2Screen({super.key});

  @override
  State<AdvocateSignupStep2Screen> createState() =>
      _AdvocateSignupStep2ScreenState();
}

class _AdvocateSignupStep2ScreenState extends State<AdvocateSignupStep2Screen> {
  // Practice Specializations
  final List<String> _specializations = [
    'Corporate Law',
    'Commercial Contracts',
    'Civil Litigation',
    'Arbitration & Dispute Resolution',
    'Family & Estate Planning',
  ];

  // Consultation toggles & fees
  bool _videoCallEnabled = true;
  final TextEditingController _videoFeeController =
      TextEditingController(text: '499');
  int _videoDuration = 15;

  bool _audioCallEnabled = true;
  final TextEditingController _audioFeeController =
      TextEditingController(text: '299');
  int _audioDuration = 15;

  bool _officeConsultationEnabled = true;
  final TextEditingController _officeFeeController =
      TextEditingController(text: '299');
  int _officeDuration = 15;

  // Office address
  final TextEditingController _officeRoomController =
      TextEditingController(text: 'Office 412, Lawyers Chambers Block');
  final TextEditingController _officeComplexController =
      TextEditingController(text: 'High Court of Delhi, Sher Shah Road');
  final TextEditingController _cityController =
      TextEditingController(text: 'New Delhi');
  final TextEditingController _pincodeController =
      TextEditingController(text: '110503');

  // Chamber Retainer Payout Account
  final TextEditingController _accountNameController =
      TextEditingController(text: 'Rajeshwari Sharma');
  final TextEditingController _bankAccountController =
      TextEditingController(text: '•••• •••• 9812');
  final TextEditingController _ifscController =
      TextEditingController(text: 'HDFC0001234');

  @override
  void dispose() {
    _videoFeeController.dispose();
    _audioFeeController.dispose();
    _officeFeeController.dispose();
    _officeRoomController.dispose();
    _officeComplexController.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    _accountNameController.dispose();
    _bankAccountController.dispose();
    _ifscController.dispose();
    super.dispose();
  }

  void _removeSpecialization(int index) {
    setState(() {
      _specializations.removeAt(index);
    });
  }

  void _showAddSpecializationDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1B1720),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Add Practice Area',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'e.g. Constitutional Law, IPR, Criminal Law',
            hintStyle: TextStyle(color: Color(0xFF64748B), fontSize: 13),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF334155)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryBlue),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF94A3B8))),
          ),
          ElevatedButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                setState(() {
                  _specializations.add(text);
                });
              }
              Navigator.of(ctx).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4349ED),
              foregroundColor: Colors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _completeRegistration() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text('Advocate Profile Registered Successfully!'),
          ],
        ),
        backgroundColor: const Color(0xFF16805B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    // Navigate to Advocate Dashboard
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
                height: 140,
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step bar and Back
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => context.pop(),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1A24),
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFF2E2938)),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1722),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFF2E2938)),
                          ),
                          child: const Text(
                            'STEP 2 OF 2',
                            style: TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // SECTION 1: PRACTICE SPECIALIZATIONS
                    _buildSectionCard(
                      icon: Icons.workspace_premium_outlined,
                      title: 'Practice Specializations',
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF252A4A),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${_specializations.length} Selected',
                          style: const TextStyle(
                            color: Color(0xFF6B8AFF),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Clients and corporate counsel discover your profile matching these validated niches.',
                            style: TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            runSpacing: 10,
                            children: [
                              ..._specializations.asMap().entries.map((entry) {
                                final idx = entry.key;
                                final item = entry.value;
                                return Container(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 6, top: 7, bottom: 7),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E1A24),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: const Color(0xFF2C2735)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        item,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      GestureDetector(
                                        onTap: () => _removeSpecialization(idx),
                                        child: const Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Icon(
                                            Icons.close,
                                            size: 15,
                                            color: Color(0xFF94A3B8),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                          const SizedBox(height: 14),
                          InkWell(
                            onTap: _showAddSpecializationDialog,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 9),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A1F36),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: const Color(0xFF2D3B68)),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.add,
                                      size: 16, color: Color(0xFF6B8AFF)),
                                  SizedBox(width: 6),
                                  Text(
                                    'Add Practice Area',
                                    style: TextStyle(
                                      color: Color(0xFF6B8AFF),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // SECTION 2: CONSULTATION & RETAINER FEES
                    _buildSectionCard(
                      icon: Icons.payments_outlined,
                      title: 'Consultation & Retainer Fees',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Video Call Consultation
                          _buildConsultationServiceItem(
                            icon: Icons.videocam_rounded,
                            title: 'Video Call Consultation',
                            isEnabled: _videoCallEnabled,
                            onToggle: (v) =>
                                setState(() => _videoCallEnabled = v),
                            feeController: _videoFeeController,
                            selectedDuration: _videoDuration,
                            onDurationChanged: (d) =>
                                setState(() => _videoDuration = d),
                          ),
                          const Divider(
                              color: Color(0xFF262130), height: 32),

                          // Audio Call Consultation
                          _buildConsultationServiceItem(
                            icon: Icons.call_rounded,
                            title: 'Audio Call Consultation',
                            isEnabled: _audioCallEnabled,
                            onToggle: (v) =>
                                setState(() => _audioCallEnabled = v),
                            feeController: _audioFeeController,
                            selectedDuration: _audioDuration,
                            onDurationChanged: (d) =>
                                setState(() => _audioDuration = d),
                          ),
                          const Divider(
                              color: Color(0xFF262130), height: 32),

                          // Office Consultation
                          _buildConsultationServiceItem(
                            icon: Icons.business_rounded,
                            title: 'Office Consultation',
                            isEnabled: _officeConsultationEnabled,
                            onToggle: (v) =>
                                setState(() => _officeConsultationEnabled = v),
                            feeController: _officeFeeController,
                            selectedDuration: _officeDuration,
                            onDurationChanged: (d) =>
                                setState(() => _officeDuration = d),
                            extraFields: _officeConsultationEnabled
                                ? [
                                    const SizedBox(height: 14),
                                    _buildFieldLabel('Office Number / Room'),
                                    _buildInputField(
                                      controller: _officeRoomController,
                                      hint: 'Office Number / Room',
                                    ),
                                    const SizedBox(height: 12),
                                    _buildFieldLabel(
                                        'Office Complex / Attached Office'),
                                    _buildInputField(
                                      controller: _officeComplexController,
                                      hint: 'Office Complex',
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _buildFieldLabel('City & State'),
                                              _buildInputField(
                                                controller: _cityController,
                                                hint: 'City',
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _buildFieldLabel('Pincode'),
                                              _buildInputField(
                                                controller: _pincodeController,
                                                hint: '110001',
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]
                                : null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // SECTION 3: CHAMBER RETAINER PAYOUT ACCOUNT
                    _buildSectionCard(
                      icon: Icons.account_balance_outlined,
                      title: 'Chamber Retainer Payout Account',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel('Account Name'),
                          _buildInputField(
                            controller: _accountNameController,
                            hint: 'Full name on bank account',
                          ),
                          const SizedBox(height: 14),

                          _buildFieldLabel('Bank Account'),
                          _buildInputField(
                            controller: _bankAccountController,
                            hint: 'Account number',
                          ),
                          const SizedBox(height: 14),

                          _buildFieldLabel('IFSC CODE'),
                          _buildInputField(
                            controller: _ifscController,
                            hint: 'e.g. HDFC0001234',
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(right: 4.0),
                              child: Icon(
                                Icons.check_circle_rounded,
                                color: Color(0xFF10B981),
                                size: 18,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Nodal Banking note
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF151921),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: const Color(0xFF1E293B)),
                            ),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.shield_outlined,
                                  color: Color(0xFF10B981),
                                  size: 18,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Daily settlement via NPCI & RBI authenticated direct nodal banking rails. Retainer balances are audited per Bar Council benchmarks.',
                                    style: TextStyle(
                                      color: Color(0xFF94A3B8),
                                      fontSize: 11,
                                      height: 1.45,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // SUBMIT BUTTON: Complete Registration
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _completeRegistration,
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
                              'Complete Registration',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward_rounded, size: 18),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Save as Draft
                    Center(
                      child: TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Registration draft saved!'),
                              backgroundColor: Color(0xFF334155),
                            ),
                          );
                          context.go('/advocate/home');
                        },
                        child: const Text(
                          'Save as Draft & Finish Later',
                          style: TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    Widget? trailing,
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
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ?trailing,
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildConsultationServiceItem({
    required IconData icon,
    required String title,
    required bool isEnabled,
    required ValueChanged<bool> onToggle,
    required TextEditingController feeController,
    required int selectedDuration,
    required ValueChanged<int> onDurationChanged,
    List<Widget>? extraFields,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row with Icon, Title, and Switch
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFF1E293B),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Switch(
              value: isEnabled,
              activeThumbColor: const Color(0xFF4349ED),
              activeTrackColor: const Color(0xFF6B8AFF).withValues(alpha: 0.5),
              inactiveThumbColor: const Color(0xFF64748B),
              inactiveTrackColor: const Color(0xFF1E293B),
              onChanged: onToggle,
            ),
          ],
        ),

        if (isEnabled) ...[
          const SizedBox(height: 12),
          _buildFieldLabel('Consultation fees'),
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF1B1720),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF28232F)),
            ),
            child: Row(
              children: [
                const Text(
                  '₹ ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: feeController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    cursorColor: AppColors.primaryBlue,
                    decoration: const InputDecoration(
                      hintText: 'Enter fee',
                      hintStyle:
                          TextStyle(color: Color(0xFF64748B), fontSize: 13),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Duration Pills (15 mins, 30 mins, 45 mins, 60 mins)
          Row(
            children: [15, 30, 45, 60].map((mins) {
              final isSelected = selectedDuration == mins;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: InkWell(
                    onTap: () => onDurationChanged(mins),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF1E2C60)
                            : const Color(0xFF1B1720),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF4349ED)
                              : const Color(0xFF28232F),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '$mins mins',
                          style: TextStyle(
                            color: isSelected
                                ? const Color(0xFF6B8AFF)
                                : const Color(0xFF94A3B8),
                            fontSize: 11,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          ...?extraFields,
        ],
      ],
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
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1720),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF28232F)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              cursorColor: AppColors.primaryBlue,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle:
                    const TextStyle(color: Color(0xFF64748B), fontSize: 13),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          ?suffixIcon,
        ],
      ),
    );
  }
}
