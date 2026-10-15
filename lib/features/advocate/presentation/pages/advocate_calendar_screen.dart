import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../widgets/block_slot_modal.dart';

class AdvocateCalendarScreen extends StatefulWidget {
  final int initialSubTabIndex;

  const AdvocateCalendarScreen({
    super.key,
    this.initialSubTabIndex = 0,
  });

  @override
  State<AdvocateCalendarScreen> createState() => _AdvocateCalendarScreenState();
}

class _AdvocateCalendarScreenState extends State<AdvocateCalendarScreen> {
  late int _selectedSubTab; // 0: Calendar, 1: Availability, 2: Consultation
  bool _availableForConsults = true;

  // Selected date in calendar view
  int _selectedDay = 9;

  // Selected date in availability view
  int _selectedAvailabilityDay = 21; // Monday 21

  // Set of blocked slot IDs for live demonstration
  final Set<String> _blockedSlotIds = {};

  @override
  void initState() {
    super.initState();
    _selectedSubTab = widget.initialSubTabIndex;
  }

  void _onSlotTap(String slotId, String time, String duration) {
    if (_blockedSlotIds.contains(slotId)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Slot $time is currently blocked.'),
          action: SnackBarAction(
            label: 'Unblock',
            textColor: Colors.amber,
            onPressed: () {
              setState(() {
                _blockedSlotIds.remove(slotId);
              });
            },
          ),
        ),
      );
      return;
    }

    BlockSlotModal.show(
      context,
      dateTitle: 'Monday, 21 Sep',
      slotTime: time,
      durationText: duration,
      onBlocked: () {
        setState(() {
          _blockedSlotIds.add(slotId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Time Slot $time has been blocked.'),
            backgroundColor: const Color(0xFFEF4444),
          ),
        );
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
                          'Calendar',
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
                              child: const Text(
                                'Chennai ▾',
                                style: TextStyle(
                                  color: Color(0xFF94A3B8),
                                  fontSize: 12,
                                ),
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

              // Sub-Tabs Header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                child: Row(
                  children: [
                    _buildSubTabHeaderItem(title: 'Calendar', index: 0),
                    _buildSubTabHeaderItem(title: 'Availability', index: 1),
                    _buildSubTabHeaderItem(title: 'Consultation', index: 2),
                  ],
                ),
              ),
              const Divider(color: Color(0xFF231F2A), height: 1),

              // Body content based on selected tab
              Expanded(
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  children: [
                    if (_selectedSubTab == 0) ..._buildCalendarSubTab(),
                    if (_selectedSubTab == 1) ..._buildAvailabilitySubTab(),
                    if (_selectedSubTab == 2) ..._buildConsultationSubTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubTabHeaderItem({required String title, required int index}) {
    final isSelected = _selectedSubTab == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedSubTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? const Color(0xFF4349ED)
                    : Colors.transparent,
                width: 2.5,
              ),
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF94A3B8),
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // SUB-TAB 1: CALENDAR
  // -------------------------------------------------------------
  List<Widget> _buildCalendarSubTab() {
    return [
      // Today Schedule (8, Sep 2026) Card
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
            const Text(
              'Today Schedule',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            const Text(
              '8, Sep 2026',
              style: TextStyle(color: Color(0xFF64748B), fontSize: 11),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                _buildScheduleMetricCol('05', 'Bookings', Colors.white),
                Container(width: 1, height: 32, color: const Color(0xFF28232F)),
                _buildScheduleMetricCol(
                    '03', 'Confirmed', const Color(0xFF10B981)),
                Container(width: 1, height: 32, color: const Color(0xFF28232F)),
                _buildScheduleMetricCol(
                    '02', 'Pending', const Color(0xFFFBBF24)),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 14),

      // Available for Consults Switch Card
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF16131A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF28232F)),
        ),
        child: Row(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Available for Consults',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Accepting Virtual & Chambery',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Switch(
              value: _availableForConsults,
              activeThumbColor: const Color(0xFF4349ED),
              activeTrackColor: const Color(0xFF6B8AFF).withValues(alpha: 0.5),
              inactiveThumbColor: const Color(0xFF64748B),
              inactiveTrackColor: const Color(0xFF1E293B),
              onChanged: (val) => setState(() => _availableForConsults = val),
            ),
          ],
        ),
      ),
      const SizedBox(height: 14),

      // Month Calendar Card
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF16131A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF28232F)),
        ),
        child: Column(
          children: [
            // Month Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.chevron_left_rounded,
                    color: Color(0xFF94A3B8), size: 22),
                const Text(
                  'Sep        2026',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.chevron_right_rounded,
                    color: Color(0xFF94A3B8), size: 22),
              ],
            ),
            const SizedBox(height: 14),

            // Days of week row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                  .map((day) => SizedBox(
                        width: 36,
                        child: Center(
                          child: Text(
                            day,
                            style: const TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 10),

            // Calendar dates grid (simplified demo for September 2026)
            _buildMonthGrid(),
          ],
        ),
      ),
      const SizedBox(height: 16),

      // Selected Day Schedule Items
      _buildCalendarScheduleItem(
        title: 'Video Consultation',
        status: 'Confirmed',
        initials: 'PS',
        name: 'Jhon Vick',
        caseId: '1265-8262',
        timeText: 'Today, 10:30 - 10:45 AM (15 mins)',
        onJoin: () => context.push('/video-call'),
      ),
      const SizedBox(height: 12),
      _buildCalendarScheduleItem(
        title: 'Video Consultation',
        status: 'Confirmed',
        initials: 'A',
        name: 'Alena',
        caseId: '1265-8272',
        timeText: 'Today, 11:45 - 12:00 AM (15 mins)',
        extraInfo: 'Starts in 1 hrs 30 mins   •   ₹499 (incl. taxes)',
        onJoin: () => context.push('/video-call'),
      ),
      const SizedBox(height: 20),
    ];
  }

  Widget _buildScheduleMetricCol(String value, String label, Color valColor) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: valColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthGrid() {
    // 5 rows of 7 days
    final days = [
      [null, 1, 2, 3, 4, 5, 6],
      [7, 8, 9, 10, 11, 12, 13],
      [14, 15, 16, 17, 18, 19, 20],
      [21, 22, 23, 24, 25, 26, 27],
      [28, 29, 30, 1, 2, 3, 4],
    ];

    return Column(
      children: days.map((week) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: week.map((d) {
              if (d == null) {
                return const SizedBox(width: 36, height: 36);
              }
              final isSelected = d == _selectedDay;
              final isPastOrOtherMonth = d > 27 && week == days.last;

              return InkWell(
                onTap: () {
                  setState(() => _selectedDay = d);
                },
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF4349ED)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$d',
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : isPastOrOtherMonth
                                ? const Color(0xFF475569)
                                : Colors.white,
                        fontSize: 12,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCalendarScheduleItem({
    required String title,
    required String status,
    required String initials,
    required String name,
    required String caseId,
    required String timeText,
    String? extraInfo,
    required VoidCallback onJoin,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF16131A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF28232F)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF142D23),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.circle,
                        color: Color(0xFF10B981), size: 7),
                    const SizedBox(width: 4),
                    Text(
                      status,
                      style: const TextStyle(
                          color: Color(0xFF10B981),
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
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
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Case id #$caseId',
                    style:
                        const TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF1B1720),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today_outlined,
                    color: Color(0xFF94A3B8), size: 13),
                const SizedBox(width: 6),
                Text(
                  timeText,
                  style:
                      const TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
                ),
              ],
            ),
          ),
          if (extraInfo != null) ...[
            const SizedBox(height: 8),
            Text(
              extraInfo,
              style: const TextStyle(
                  color: Color(0xFF10B981),
                  fontSize: 11,
                  fontWeight: FontWeight.w600),
            ),
          ],
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: ElevatedButton.icon(
              onPressed: onJoin,
              icon: const Icon(Icons.videocam_rounded, size: 16),
              label: const Text('Join Video Consultation',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4349ED),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // SUB-TAB 2: AVAILABILITY
  // -------------------------------------------------------------
  List<Widget> _buildAvailabilitySubTab() {
    return [
      // Working days Schedule card
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF16131A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF28232F)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Working days Schedule',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.push('/working-schedule');
                  },
                  child: const Text(
                    'Manage',
                    style: TextStyle(
                      color: Color(0xFF6B8AFF),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _buildWorkingDayRow(
              days: 'Monday - Friday',
              time: '09:30 AM - 7:30 PM',
              isAvailable: true,
            ),
            const Divider(color: Color(0xFF262130), height: 20),
            _buildWorkingDayRow(
              days: 'Saturday',
              time: '09:30 AM - 2:00 PM',
              isAvailable: true,
            ),
            const Divider(color: Color(0xFF262130), height: 20),
            _buildWorkingDayRow(
              days: 'Sunday',
              time: 'Unavailable',
              isAvailable: false,
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),

      // Available Slots Header
      const Text(
        'Available Slots',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 10),

      // Month name
      const Row(
        children: [
          Icon(Icons.calendar_month_outlined,
              color: Color(0xFF819DFF), size: 16),
          SizedBox(width: 6),
          Text(
            'September 2026',
            style: TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),

      // Weekday horizontal selector row
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDayPill('Mon', 21),
          _buildDayPill('Tue', 22),
          _buildDayPill('Wed', 23),
          _buildDayPill('Thu', 24),
          _buildDayPill('Fri', 25),
          _buildDayPill('Sat', 26),
        ],
      ),
      const SizedBox(height: 20),

      // Morning band
      _buildTimeBandCard(
        icon: Icons.wb_sunny_outlined,
        title: 'Morning',
        timeRange: '9:00 AM - 12:00 PM',
        slots: [
          _buildSlotChip(
            id: 'm1',
            time: '09:30 AM',
            range: '09:45 AM',
            isBooked: true,
          ),
          _buildSlotChip(
            id: 'm2',
            time: '10:30 AM',
            range: '11:15 AM',
            duration: '(30 mins)',
          ),
          _buildSlotChip(
            id: 'm3',
            time: '11:15 AM',
            range: '11:45 AM',
            duration: '(30 mins)',
          ),
          _buildSlotChip(
            id: 'm4',
            time: '11:45 AM',
            range: '12:00 PM',
            duration: '(15 mins)',
          ),
        ],
      ),
      const SizedBox(height: 16),

      // Afternoon band
      _buildTimeBandCard(
        icon: Icons.brightness_medium_outlined,
        title: 'Afternoon',
        timeRange: '12:00 PM - 5:00 PM',
        slots: [
          _buildSlotChip(
            id: 'a1',
            time: '04:00 PM',
            range: '04:15 PM',
            duration: '(15 mins)',
          ),
        ],
      ),
      const SizedBox(height: 16),

      // Evening band
      _buildTimeBandCard(
        icon: Icons.nights_stay_outlined,
        title: 'Evening',
        timeRange: '5:00 PM - 8:00 PM',
        slots: [
          _buildSlotChip(
            id: 'e1',
            time: '05:30 PM',
            range: '05:45 PM',
            duration: '(15 mins)',
          ),
          _buildSlotChip(
            id: 'e2',
            time: '06:00 PM',
            range: '06:15 PM',
            duration: '(15 mins)',
          ),
          _buildSlotChip(
            id: 'e3',
            time: '06:30 PM',
            range: '06:45 PM',
            duration: '(15 mins)',
          ),
        ],
      ),
      const SizedBox(height: 24),
    ];
  }

  Widget _buildWorkingDayRow({
    required String days,
    required String time,
    required bool isAvailable,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          days,
          style: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 13,
          ),
        ),
        Text(
          time,
          style: TextStyle(
            color: isAvailable ? Colors.white : const Color(0xFF64748B),
            fontSize: 13,
            fontWeight: isAvailable ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildDayPill(String dayName, int dateNum) {
    final isSelected = _selectedAvailabilityDay == dateNum;
    return InkWell(
      onTap: () => setState(() => _selectedAvailabilityDay = dateNum),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 50,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4349ED) : const Color(0xFF1B1720),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF4349ED) : const Color(0xFF28232F),
          ),
        ),
        child: Column(
          children: [
            Text(
              dayName,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF94A3B8),
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$dateNum',
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF94A3B8),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeBandCard({
    required IconData icon,
    required String title,
    required String timeRange,
    required List<Widget> slots,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: const Color(0xFFFBBF24), size: 15),
            const SizedBox(width: 6),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '• $timeRange',
              style: const TextStyle(color: Color(0xFF64748B), fontSize: 11),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                context.push(
                  '/advocate/edit-slot',
                  extra: {
                    'dateTitle': 'Monday, $_selectedAvailabilityDay Sep',
                  },
                );
              },
              child: const Text(
                '+Add',
                style: TextStyle(
                  color: Color(0xFF6B8AFF),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: slots,
        ),
      ],
    );
  }

  Widget _buildSlotChip({
    required String id,
    required String time,
    required String range,
    String duration = '(15 mins)',
    bool isBooked = false,
  }) {
    final isBlocked = _blockedSlotIds.contains(id);

    return InkWell(
      onTap: () {
        if (!isBooked) {
          _onSlotTap(id, '$time - $range', duration);
        }
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isBooked
              ? const Color(0xFF1E1A24)
              : isBlocked
                  ? const Color(0xFF2D1E24)
                  : const Color(0xFF161F36),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isBooked
                ? const Color(0xFF2E2938)
                : isBlocked
                    ? const Color(0xFFEF4444)
                    : const Color(0xFF293B6E),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: TextStyle(
                color: isBooked
                    ? const Color(0xFF64748B)
                    : isBlocked
                        ? const Color(0xFFF87171)
                        : Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  range,
                  style: TextStyle(
                    color: isBooked
                        ? const Color(0xFF475569)
                        : const Color(0xFF94A3B8),
                    fontSize: 10,
                  ),
                ),
                const SizedBox(width: 6),
                if (isBooked)
                  const Text(
                    'Booked',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                else if (isBlocked)
                  const Text(
                    'Blocked',
                    style: TextStyle(
                      color: Color(0xFFEF4444),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                else ...[
                  const Icon(Icons.circle,
                      color: Color(0xFF10B981), size: 6),
                  const SizedBox(width: 4),
                  const Text(
                    'Available',
                    style: TextStyle(
                      color: Color(0xFF10B981),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // SUB-TAB 3: CONSULTATION
  // -------------------------------------------------------------
  List<Widget> _buildConsultationSubTab() {
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
            const Text(
              'Working days Schedule',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Video call Consultation
            _buildConsultationRateRow(
              icon: Icons.videocam_rounded,
              title: 'Video call Consultation',
              rateText: '₹499 • 15 mins',
              onTap: () {
                context.push(
                  '/working-schedule',
                  extra: {'consultationType': 'Video Call Consultation'},
                );
              },
            ),
            const Divider(color: Color(0xFF262130), height: 24),

            // Audio call Consultation
            _buildConsultationRateRow(
              icon: Icons.call_rounded,
              title: 'Audio call Consultation',
              rateText: '₹299 • 30 mins',
              onTap: () {
                context.push(
                  '/working-schedule',
                  extra: {'consultationType': 'Audio Call Consultation'},
                );
              },
            ),
            const Divider(color: Color(0xFF262130), height: 24),

            // Office Consultation
            _buildConsultationRateRow(
              icon: Icons.business_rounded,
              title: 'Office Consultation',
              rateText: '₹1299 • 30 mins',
              onTap: () {
                context.push(
                  '/working-schedule',
                  extra: {'consultationType': 'Office Consultation'},
                );
              },
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),
    ];
  }

  Widget _buildConsultationRateRow({
    required IconData icon,
    required String title,
    required String rateText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                color: Color(0xFF1E293B),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.circle,
                        color: Color(0xFF10B981), size: 6),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  rateText,
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.chevron_right_rounded,
                color: Color(0xFF94A3B8), size: 18),
          ],
        ),
      ),
    );
  }
}
