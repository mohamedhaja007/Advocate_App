import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AdvocateConsultationFeesScreen extends StatefulWidget {
  final String consultationType;
  final String initialFee;
  final String initialDuration;

  const AdvocateConsultationFeesScreen({
    super.key,
    this.consultationType = 'Video Call Consultation',
    this.initialFee = '499',
    this.initialDuration = '15 mins',
  });

  @override
  State<AdvocateConsultationFeesScreen> createState() =>
      _AdvocateConsultationFeesScreenState();
}

class _AdvocateConsultationFeesScreenState
    extends State<AdvocateConsultationFeesScreen> {
  late bool _isEnabled;
  late TextEditingController _feeController;
  late String _selectedDuration;
  late String _currentType;

  final List<String> _durations = [
    '15 mins',
    '30 mins',
    '45 mins',
    '60 mins',
  ];

  @override
  void initState() {
    super.initState();
    _currentType = widget.consultationType;
    _isEnabled = true;
    _feeController = TextEditingController(text: widget.initialFee);
    _selectedDuration = widget.initialDuration;
  }

  @override
  void dispose() {
    _feeController.dispose();
    super.dispose();
  }

  IconData _getConsultationIcon(String type) {
    final lower = type.toLowerCase();
    if (lower.contains('video')) {
      return Icons.videocam_rounded;
    } else if (lower.contains('audio') || lower.contains('call')) {
      return Icons.call_rounded;
    } else {
      return Icons.business_rounded;
    }
  }

  void _onSaveConsultation() {
    final fee = _feeController.text.trim();
    if (fee.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid consultation fee'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$_currentType settings updated (₹$fee • $_selectedDuration)!',
        ),
        backgroundColor: const Color(0xFF16805B),
        duration: const Duration(seconds: 2),
      ),
    );

    // Pop back or navigate to calendar
    if (context.canPop()) {
      context.pop();
      if (context.canPop()) {
        context.pop(); // Pop back past working schedule to calendar
      }
    } else {
      context.go('/advocate/calendar');
    }
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
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => context.pop(),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B1720),
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF28232F)),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Text(
                      'Consultation & Fees',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Main Card
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF16131A),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF28232F)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row: Icon circle + Title + Switch
                        Row(
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: const BoxDecoration(
                                color: Color(0xFFECEFF8),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _getConsultationIcon(_currentType),
                                color: const Color(0xFF5244E9),
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _currentType,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Switch(
                              value: _isEnabled,
                              activeThumbColor: Colors.white,
                              activeTrackColor: const Color(0xFF5244E9),
                              inactiveThumbColor: const Color(0xFF94A3B8),
                              inactiveTrackColor: const Color(0xFF1E1A24),
                              onChanged: (val) {
                                setState(() {
                                  _isEnabled = val;
                                });
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Section label: Consultation fees
                        const Text(
                          'Consultation fees',
                          style: TextStyle(
                            color: Color(0xFFE2E8F0),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Fee input box with ₹ prefix
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B1720),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFF2E2938)),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Row(
                            children: [
                              const Text(
                                '₹ ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _feeController,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter amount',
                                    hintStyle: TextStyle(
                                      color: Color(0xFF64748B),
                                      fontSize: 14,
                                    ),
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Duration Chips Row
                        Row(
                          children: _durations.map((duration) {
                            final isSelected = _selectedDuration == duration;
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedDuration = duration;
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFF242038)
                                          : const Color(0xFF1B1720),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFF5244E9)
                                            : const Color(0xFF2E2938),
                                        width: isSelected ? 1.5 : 1.0,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        duration,
                                        style: TextStyle(
                                          color: isSelected
                                              ? const Color(0xFF819DFF)
                                              : const Color(0xFF94A3B8),
                                          fontSize: 12,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom Action Button: Save working Schedule
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFF141118),
                  border: Border(top: BorderSide(color: Color(0xFF231F2A))),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _onSaveConsultation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5244E9),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Save working Schedule',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
