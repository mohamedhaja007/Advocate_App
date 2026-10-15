import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AdvocateWorkingScheduleScreen extends StatefulWidget {
  final String consultationType;

  const AdvocateWorkingScheduleScreen({
    super.key,
    this.consultationType = 'Video Call Consultation',
  });

  @override
  State<AdvocateWorkingScheduleScreen> createState() =>
      _AdvocateWorkingScheduleScreenState();
}

class _AdvocateWorkingScheduleScreenState
    extends State<AdvocateWorkingScheduleScreen> {
  // Days active: 0 = Sun, 1 = Mon, ..., 6 = Sat
  final Set<int> _activeDays = {1, 2, 3, 4, 5, 6}; // Mon-Sat active, Sun off

  // Schedule map for each weekday: [startTime, endTime]
  final Map<int, List<String>> _dayTimes = {
    1: ['09:30 AM', '07:30 PM'], // Mon
    2: ['09:30 AM', '07:30 PM'], // Tue
    3: ['09:30 AM', '07:30 PM'], // Wed
    4: ['09:30 AM', '07:30 PM'], // Thu
    5: ['09:30 AM', '07:30 PM'], // Fri
    6: ['09:30 AM', '02:00 PM'], // Sat
  };

  final List<String> _timeOptions = [
    '08:00 AM',
    '08:30 AM',
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '12:00 PM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
    '06:00 PM',
    '07:00 PM',
    '07:30 PM',
    '08:00 PM',
    '08:30 PM',
    '09:00 PM',
  ];

  void _onToggleDay(int dayIndex) {
    setState(() {
      if (_activeDays.contains(dayIndex)) {
        _activeDays.remove(dayIndex);
      } else {
        _activeDays.add(dayIndex);
        if (!_dayTimes.containsKey(dayIndex)) {
          _dayTimes[dayIndex] = ['09:30 AM', '07:30 PM'];
        }
      }
    });
  }

  void _onSaveAndProceed() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Working Schedule saved successfully!'),
        backgroundColor: Color(0xFF16805B),
        duration: Duration(seconds: 1),
      ),
    );

    String fee = '499';
    String duration = '15 mins';
    if (widget.consultationType.toLowerCase().contains('audio')) {
      fee = '299';
      duration = '30 mins';
    } else if (widget.consultationType.toLowerCase().contains('office')) {
      fee = '1299';
      duration = '30 mins';
    }

    // Navigate to Consultation & Fees next
    context.push(
      '/consultation-fees',
      extra: {
        'consultationType': widget.consultationType,
        'fee': fee,
        'duration': duration,
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
                      'Working Schedule',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Main Schedule Card
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
                        // Weekday Circular Chips (S, M, T, W, T, F, S)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildDayChip('S', 0),
                            _buildDayChip('M', 1),
                            _buildDayChip('T', 2),
                            _buildDayChip('W', 3),
                            _buildDayChip('T', 4),
                            _buildDayChip('F', 5),
                            _buildDayChip('S', 6),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Day Rows
                        _buildDayRow(0, 'Sun'),
                        const SizedBox(height: 16),
                        _buildDayRow(1, 'Mon'),
                        const SizedBox(height: 16),
                        _buildDayRow(2, 'Tue'),
                        const SizedBox(height: 16),
                        _buildDayRow(3, 'Wed'),
                        const SizedBox(height: 16),
                        _buildDayRow(4, 'Thu'),
                        const SizedBox(height: 16),
                        _buildDayRow(5, 'Fri'),
                        const SizedBox(height: 16),
                        _buildDayRow(6, 'Sat'),
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
                    onPressed: _onSaveAndProceed,
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

  // Weekday circular chip (purple when active, dark grey when inactive)
  Widget _buildDayChip(String label, int dayIndex) {
    final isActive = _activeDays.contains(dayIndex);
    return InkWell(
      onTap: () => _onToggleDay(dayIndex),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF5244E9) : const Color(0xFF25202B),
          shape: BoxShape.circle,
          border: Border.all(
            color: isActive
                ? const Color(0xFF6554F8)
                : const Color(0xFF332B3D),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : const Color(0xFF64748B),
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Day Row with dropdowns for Start Time and End Time
  Widget _buildDayRow(int dayIndex, String dayName) {
    final isActive = _activeDays.contains(dayIndex);
    final times = _dayTimes[dayIndex] ?? ['09:30 AM', '07:30 PM'];

    return Row(
      children: [
        SizedBox(
          width: 44,
          child: Text(
            dayName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Spacer(),
        if (!isActive)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Day off',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        else
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Start Time Dropdown
              _buildTimeDropdown(
                value: times[0],
                onChanged: (newVal) {
                  if (newVal != null) {
                    setState(() {
                      times[0] = newVal;
                      _dayTimes[dayIndex] = times;
                    });
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'to',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 13,
                  ),
                ),
              ),
              // End Time Dropdown
              _buildTimeDropdown(
                value: times[1],
                onChanged: (newVal) {
                  if (newVal != null) {
                    setState(() {
                      times[1] = newVal;
                      _dayTimes[dayIndex] = times;
                    });
                  }
                },
              ),
            ],
          ),
      ],
    );
  }

  // Dark dropdown picker pill
  Widget _buildTimeDropdown({
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1A24),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF2E2938)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: const Color(0xFF1E1A24),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xFF64748B),
            size: 16,
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          items: _timeOptions.map((time) {
            return DropdownMenuItem<String>(
              value: time,
              child: Text(time),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
