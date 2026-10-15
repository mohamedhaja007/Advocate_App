import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AdvocateBookingsScreen extends StatefulWidget {
  final int initialTabIndex;

  const AdvocateBookingsScreen({
    super.key,
    this.initialTabIndex = 0,
  });

  @override
  State<AdvocateBookingsScreen> createState() => _AdvocateBookingsScreenState();
}

class _AdvocateBookingsScreenState extends State<AdvocateBookingsScreen> {
  late int _selectedTab; // 0: Confirmed, 1: Pending, 2: Cancelled

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTabIndex;
  }

  void _openBookingDetails({
    required String clientName,
    required String caseId,
    required String consultationType,
    required String date,
    required String timeSlot,
    required String fee,
    required String status,
  }) {
    context.push(
      '/advocate/booking-details',
      extra: {
        'clientName': clientName,
        'caseId': caseId,
        'consultationType': consultationType,
        'date': date,
        'timeSlot': timeSlot,
        'fee': fee,
        'status': status,
      },
    );
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
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'My Booking',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(Icons.location_on_rounded,
                                color: Color(0xFF94A3B8), size: 14),
                            const SizedBox(width: 4),
                            InkWell(
                              onTap: () => context.push('/choose-location'),
                              child: const Row(
                                children: [
                                  Text(
                                    'Chennai ▾',
                                    style: TextStyle(
                                      color: Color(0xFF94A3B8),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Notification Bell
                    InkWell(
                      onTap: () => context.push('/advocate/notifications'),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B1720),
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF28232F)),
                        ),
                        child: const Icon(Icons.notifications_none_rounded,
                            color: Colors.white, size: 18),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Chat Bubble
                    InkWell(
                      onTap: () => context.push(
                        '/advocate-chat',
                        extra: {
                          'lawyerName': 'Client Jhon Vick',
                          'lawyerImage': 'assets/images/Png/Man.png',
                        },
                      ),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B1720),
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF28232F)),
                        ),
                        child: const Icon(Icons.chat_bubble_outline_rounded,
                            color: Colors.white, size: 18),
                      ),
                    ),
                  ],
                ),
              ),

              // Segmented Tabs
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  children: [
                    _buildTabPill(title: 'Confirmed', count: 2, index: 0),
                    const SizedBox(width: 10),
                    _buildTabPill(title: 'Pending', count: 1, index: 1),
                    const SizedBox(width: 10),
                    _buildTabPill(title: 'Cancelled', count: 1, index: 2),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Booking List
              Expanded(
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  children: [
                    if (_selectedTab == 0) ..._buildConfirmedList(),
                    if (_selectedTab == 1) ..._buildPendingList(),
                    if (_selectedTab == 2) ..._buildCancelledList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabPill({
    required String title,
    required int count,
    required int index,
  }) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedTab = index),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF4349ED)
                : const Color(0xFF1B1720),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF4349ED)
                  : const Color(0xFF28232F),
            ),
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF94A3B8),
                    fontSize: 12,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.25)
                        : const Color(0xFF28232F),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$count',
                    style: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF94A3B8),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildConfirmedList() {
    return [
      _buildBookingCard(
        title: 'Video Consultation',
        statusText: 'Confirmed',
        statusColor: const Color(0xFF10B981),
        statusBg: const Color(0xFF142D23),
        initials: 'PS',
        clientName: 'Jhon Vick',
        caseId: '1265-8262',
        timeText: 'Today, 10:30 - 10:45 AM (15 mins)',
        timeRemainingText: 'Starts in 45 mins',
        feeText: '₹499 (incl. taxes)',
        buttonText: 'Join Video Consultation',
        onButtonPressed: () => context.push('/video-call'),
        onCardTap: () => _openBookingDetails(
          clientName: 'Jhon Vick',
          caseId: '1265-8262',
          consultationType: 'Video consultation',
          date: 'Today',
          timeSlot: '10:30 - 10:45 AM',
          fee: '499',
          status: 'confirmed',
        ),
      ),
      const SizedBox(height: 14),
      _buildBookingCard(
        title: 'Video Consultation',
        statusText: 'Confirmed',
        statusColor: const Color(0xFF10B981),
        statusBg: const Color(0xFF142D23),
        initials: 'A',
        clientName: 'Alena',
        caseId: '1285-8272',
        timeText: 'Today, 11:45 - 12:00 AM (15 mins)',
        timeRemainingText: 'Starts in 1 hrs 30 mins',
        feeText: '₹499 (incl. taxes)',
        buttonText: 'Join Video Consultation',
        onButtonPressed: () => context.push('/video-call'),
        onCardTap: () => _openBookingDetails(
          clientName: 'Alena',
          caseId: '1285-8272',
          consultationType: 'Video consultation',
          date: 'Today',
          timeSlot: '11:45 - 12:00 AM',
          fee: '499',
          status: 'confirmed',
        ),
      ),
    ];
  }

  List<Widget> _buildPendingList() {
    return [
      _buildBookingCard(
        title: 'Video Consultation',
        statusText: 'Pending',
        statusColor: const Color(0xFFFBBF24),
        statusBg: const Color(0xFF332912),
        initials: 'PS',
        clientName: 'Jhon',
        caseId: '1265-8262',
        timeText: 'Today, 10:30 - 10:45 AM (15 mins)',
        timeRemainingText: 'Starts in 45 mins',
        feeText: '₹499 (incl. taxes)',
        customActions: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Reschedule proposal sent to client.'),
                      backgroundColor: Color(0xFF4349ED),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF332F3D)),
                  backgroundColor: const Color(0xFF1E1A24),
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 14),
                    SizedBox(width: 6),
                    Text('Reschedule',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Booking Accepted!'),
                      backgroundColor: Color(0xFF16805B),
                    ),
                  );
                  setState(() => _selectedTab = 0);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4349ED),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Accept',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        onCardTap: () => _openBookingDetails(
          clientName: 'Jhon',
          caseId: '1265-8262',
          consultationType: 'Video consultation',
          date: 'Today',
          timeSlot: '10:30 - 10:45 AM',
          fee: '499',
          status: 'pending',
        ),
      ),
    ];
  }

  List<Widget> _buildCancelledList() {
    return [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF16131A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF28232F)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: Type & Canceled Badge
            Row(
              children: [
                const Icon(Icons.video_camera_front_outlined,
                    color: Color(0xFF819DFF), size: 16),
                const SizedBox(width: 6),
                const Text(
                  'Video Consultation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF331616),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFF752424)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.cancel_outlined,
                          color: Color(0xFFEF4444), size: 12),
                      SizedBox(width: 4),
                      Text(
                        'Canceled',
                        style: TextStyle(
                          color: Color(0xFFEF4444),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Client row
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFF232A44),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      'PS',
                      style: TextStyle(
                        color: Color(0xFF819DFF),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jhon Vick',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Case id #1265-8262',
                      style: TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Time Row
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF1B1720),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.calendar_today_outlined,
                      color: Color(0xFF94A3B8), size: 14),
                  SizedBox(width: 8),
                  Text(
                    'Today, 10:30 - 10:45 AM (15 mins)',
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            const Text(
              'Canceled on 15 Sep 2026 by client',
              style: TextStyle(color: Color(0xFF64748B), fontSize: 11),
            ),
            const SizedBox(height: 10),

            // Refund Processing Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF151921),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF1E293B)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.sync_rounded,
                          color: Color(0xFF6B8AFF), size: 15),
                      SizedBox(width: 6),
                      Text(
                        'Processing',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '₹499',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Reason: Medical contingency. Full statutory refund of ₹499 credited back to bank handle.',
                    style: TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 11,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget _buildBookingCard({
    required String title,
    required String statusText,
    required Color statusColor,
    required Color statusBg,
    required String initials,
    required String clientName,
    required String caseId,
    required String timeText,
    required String timeRemainingText,
    required String feeText,
    String? buttonText,
    VoidCallback? onButtonPressed,
    Widget? customActions,
    required VoidCallback onCardTap,
  }) {
    return InkWell(
      onTap: onCardTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF16131A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF28232F)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: Type & Status
            Row(
              children: [
                const Icon(Icons.video_camera_front_outlined,
                    color: Color(0xFF819DFF), size: 16),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.circle, color: statusColor, size: 7),
                      const SizedBox(width: 5),
                      Text(
                        statusText,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Client row
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFF232A44),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      initials,
                      style: const TextStyle(
                        color: Color(0xFF819DFF),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clientName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          'Case id #$caseId',
                          style: const TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.copy_rounded,
                            color: Color(0xFF94A3B8), size: 11),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Time container
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF1B1720),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_outlined,
                      color: Color(0xFF94A3B8), size: 14),
                  const SizedBox(width: 8),
                  Text(
                    timeText,
                    style:
                        const TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Starts in X mins & Fee
            Row(
              children: [
                const Icon(Icons.circle, color: Color(0xFF10B981), size: 7),
                const SizedBox(width: 6),
                Text(
                  timeRemainingText,
                  style: const TextStyle(
                    color: Color(0xFF10B981),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  feeText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Actions
            if (customActions != null)
              customActions
            else if (buttonText != null)
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: onButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4349ED),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.videocam_rounded, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        buttonText,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
