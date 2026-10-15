import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AdvocateDoorstepScreen extends StatefulWidget {
  final String clientName;
  final String caseId;
  final String date;
  final String timeSlot;
  final String fee;
  final String address;
  final String landmark;
  final String pincode;

  const AdvocateDoorstepScreen({
    super.key,
    this.clientName = 'Rajesh Mehra',
    this.caseId = '1265-9014',
    this.date = '17 Sep 2026',
    this.timeSlot = '11:00 AM - 12:30 PM',
    this.fee = '₹1,499',
    this.address = 'Flat 402, Tower B, Palm Meadows, Anna Nagar West',
    this.landmark = 'Near Roundtana Metro Station',
    this.pincode = '600040',
  });

  @override
  State<AdvocateDoorstepScreen> createState() => _AdvocateDoorstepScreenState();
}

class _AdvocateDoorstepScreenState extends State<AdvocateDoorstepScreen> {
  // Status progression: 0: Confirmed/Scheduled, 1: En Route, 2: Arrived at Chamber/Premises, 3: Completed
  int _currentStep = 1;

  final TextEditingController _summaryController = TextEditingController(
    text:
        'In-person property deed inspection and physical verification of ancestral encumbrance certificates.',
  );

  @override
  void dispose() {
    _summaryController.dispose();
    super.dispose();
  }

  void _onAdvanceStatus() {
    if (_currentStep == 1) {
      // Mark Arrived
      setState(() => _currentStep = 2);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Marked Arrived at Client Premises. Timer started.'),
          backgroundColor: Color(0xFF16805B),
        ),
      );
    } else if (_currentStep == 2) {
      // Complete Consultation
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: const Color(0xFF1B1720),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Complete Doorstep Visit?',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          content: const Text(
            'Confirm physical doorstep consultation is finished? Once confirmed, fee payout of ₹1,499 will be transferred to your settlement wallet.',
            style:
                TextStyle(color: Color(0xFF94A3B8), fontSize: 13, height: 1.4),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel',
                  style: TextStyle(color: Color(0xFF94A3B8))),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16805B),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(ctx);
                setState(() => _currentStep = 3);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Doorstep consultation completed & fee credited!'),
                    backgroundColor: Color(0xFF16805B),
                  ),
                );
              },
              child: const Text('Confirm Completion'),
            ),
          ],
        ),
      );
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
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.white, size: 20),
                      onPressed: () => context.pop(),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Doorstep Consultation',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B284C),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.location_city_rounded,
                              color: Color(0xFFC084FC), size: 14),
                          const SizedBox(width: 4),
                          Text(
                            widget.fee,
                            style: const TextStyle(
                              color: Color(0xFFC084FC),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  children: [
                    // Status Progress Stepper Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B1720),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFF28232F)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Visit Tracking Status',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                _currentStep == 1
                                    ? 'Advocate En Route'
                                    : _currentStep == 2
                                        ? 'At Premises'
                                        : 'Concluded',
                                style: TextStyle(
                                  color: _currentStep == 3
                                      ? const Color(0xFF10B981)
                                      : const Color(0xFF819DFF),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _buildStepBadge(1, 'En Route', _currentStep >= 1),
                              Expanded(
                                child: Container(
                                  height: 2,
                                  color: _currentStep >= 2
                                      ? const Color(0xFF4349ED)
                                      : const Color(0xFF332F3D),
                                ),
                              ),
                              _buildStepBadge(2, 'Arrived', _currentStep >= 2),
                              Expanded(
                                child: Container(
                                  height: 2,
                                  color: _currentStep >= 3
                                      ? const Color(0xFF10B981)
                                      : const Color(0xFF332F3D),
                                ),
                              ),
                              _buildStepBadge(
                                  3, 'Completed', _currentStep >= 3),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Client & Case Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B1720),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFF28232F)),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: const Color(0xFF2E2733),
                            child: Text(
                              widget.clientName
                                  .split(' ')
                                  .map((e) => e[0])
                                  .take(2)
                                  .join(),
                              style: const TextStyle(
                                color: Color(0xFF819DFF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.clientName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Case ID #${widget.caseId} • Property Law',
                                  style: const TextStyle(
                                    color: Color(0xFF94A3B8),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF16805B).withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Escrow Paid',
                              style: TextStyle(
                                color: Color(0xFF10B981),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Approved Address Card with Maps Intent
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B1720),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFF28232F)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.location_on_rounded,
                                  color: Color(0xFFEF4444), size: 18),
                              SizedBox(width: 8),
                              Text(
                                'Approved Consultation Address',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            widget.address,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Landmark: ${widget.landmark}',
                            style: const TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'Pincode: ${widget.pincode}',
                            style: const TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    Clipboard.setData(
                                        ClipboardData(text: widget.address));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Address copied to clipboard!'),
                                        backgroundColor: Color(0xFF4349ED),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.copy_rounded,
                                      size: 14, color: Colors.white),
                                  label: const Text('Copy Address',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12)),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Color(0xFF332F3D)),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Launching Navigation in Google Maps...'),
                                        backgroundColor: Color(0xFF4349ED),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.directions_rounded,
                                      size: 16, color: Colors.white),
                                  label: const Text('Get Directions',
                                      style: TextStyle(fontSize: 12)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF4349ED),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Schedule Info
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B1720),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFF28232F)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today_rounded,
                              color: Color(0xFF819DFF), size: 16),
                          const SizedBox(width: 10),
                          Text(
                            widget.date,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.access_time_rounded,
                              color: Color(0xFF819DFF), size: 16),
                          const SizedBox(width: 8),
                          Text(
                            widget.timeSlot,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Visit Summary & Notes
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B1720),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFF28232F)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Consultation Memorandum',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _summaryController,
                            maxLines: 3,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFF28232F),
                              hintText: 'Record brief points discussed...',
                              hintStyle: const TextStyle(
                                  color: Color(0xFF64748B), fontSize: 13),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Color(0xFF3B3346)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),

              // Bottom Action Button
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFF141118),
                  border: Border(top: BorderSide(color: Color(0xFF28232F))),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _currentStep == 3 ? null : _onAdvanceStatus,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentStep == 1
                          ? const Color(0xFF4349ED)
                          : _currentStep == 2
                              ? const Color(0xFF16805B)
                              : const Color(0xFF332F3D),
                      foregroundColor: Colors.white,
                      disabledForegroundColor: Colors.white54,
                      disabledBackgroundColor: const Color(0xFF28232F),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    child: Text(
                      _currentStep == 1
                          ? 'Mark Arrived at Location'
                          : _currentStep == 2
                              ? 'Complete Doorstep Consultation'
                              : 'Consultation Completed',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
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

  Widget _buildStepBadge(int stepIndex, String title, bool isReached) {
    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isReached
                ? const Color(0xFF4349ED)
                : const Color(0xFF28232F),
          ),
          child: Center(
            child: isReached && _currentStep > stepIndex
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : Text(
                    '$stepIndex',
                    style: TextStyle(
                      color: isReached ? Colors.white : const Color(0xFF94A3B8),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: isReached ? Colors.white : const Color(0xFF64748B),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
