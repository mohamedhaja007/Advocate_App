import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AdvocateEditSlotScreen extends StatefulWidget {
  final String dateTitle;
  final String initialStartTime;
  final String initialEndTime;

  const AdvocateEditSlotScreen({
    super.key,
    this.dateTitle = 'Monday, 21 Sep',
    this.initialStartTime = '09:30 AM',
    this.initialEndTime = '10:30 AM',
  });

  @override
  State<AdvocateEditSlotScreen> createState() => _AdvocateEditSlotScreenState();
}

class _AdvocateEditSlotScreenState extends State<AdvocateEditSlotScreen> {
  late String _startTime;
  late String _endTime;
  bool _isAvailable = true; // true = Available, false = Blocked
  bool _repeatWeekly = true;

  final List<String> _daysOfWeek = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  final Set<int> _selectedDays = {0, 1, 2, 3, 4}; // Monday to Friday default

  final List<String> _times = [
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '12:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
    '06:00 PM',
    '07:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    _startTime = widget.initialStartTime;
    _endTime = widget.initialEndTime;
  }

  void _onSave() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Time Slot updated successfully!'),
        backgroundColor: Color(0xFF16805B),
      ),
    );
    context.pop();
  }

  void _onRemove() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1B1720),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Remove Time Slot?',
            style: TextStyle(color: Colors.white)),
        content: const Text(
          'Are you sure you want to remove this slot from your schedule?',
          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel',
                style: TextStyle(color: Color(0xFF94A3B8))),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC2626)),
            onPressed: () {
              Navigator.pop(ctx);
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Time slot removed.'),
                  backgroundColor: Color(0xFFDC2626),
                ),
              );
            },
            child: const Text('Remove', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
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
        appBar: AppBar(
          backgroundColor: bgDark,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white, size: 18),
            onPressed: () => context.pop(),
          ),
          title: Column(
            children: [
              const Text(
                'Edit Time Slot',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(
                widget.dateTitle,
                style: const TextStyle(
                    color: Color(0xFF94A3B8), fontSize: 11),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Period header: Morning (9:00 AM - 12:00 PM)
              Row(
                children: [
                  const Icon(Icons.wb_sunny_outlined,
                      color: Color(0xFFFBBF24), size: 16),
                  const SizedBox(width: 8),
                  const Text(
                    'Morning',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    '9:00 AM - 12:00 PM',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Start Time & End Time Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Start Time',
                          style: TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        _buildTimeDropdown(_startTime, (val) {
                          if (val != null) setState(() => _startTime = val);
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'End Time',
                          style: TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        _buildTimeDropdown(_endTime, (val) {
                          if (val != null) setState(() => _endTime = val);
                        }),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Slot Status
              const Text(
                'Slot Status',
                style: TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _isAvailable = true),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                        decoration: BoxDecoration(
                          color: _isAvailable
                              ? const Color(0xFF16253B)
                              : const Color(0xFF1B1720),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _isAvailable
                                ? const Color(0xFF4349ED)
                                : const Color(0xFF28232F),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.circle,
                                    color: Color(0xFF10B981), size: 8),
                                const SizedBox(width: 6),
                                Text(
                                  'Available',
                                  style: TextStyle(
                                    color: _isAvailable
                                        ? Colors.white
                                        : const Color(0xFF94A3B8),
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Show slot for client',
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _isAvailable = false),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                        decoration: BoxDecoration(
                          color: !_isAvailable
                              ? const Color(0xFF2D1E24)
                              : const Color(0xFF1B1720),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: !_isAvailable
                                ? const Color(0xFFEF4444)
                                : const Color(0xFF28232F),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.circle,
                                    color: Color(0xFFEF4444), size: 8),
                                const SizedBox(width: 6),
                                Text(
                                  'Blocked',
                                  style: TextStyle(
                                    color: !_isAvailable
                                        ? Colors.white
                                        : const Color(0xFF94A3B8),
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Hide slot for client',
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Repeat weekly
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Repeat the slot for every week',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Switch(
                    value: _repeatWeekly,
                    activeThumbColor: const Color(0xFF4349ED),
                    activeTrackColor:
                        const Color(0xFF6B8AFF).withValues(alpha: 0.5),
                    inactiveThumbColor: const Color(0xFF64748B),
                    inactiveTrackColor: const Color(0xFF1E293B),
                    onChanged: (val) => setState(() => _repeatWeekly = val),
                  ),
                ],
              ),
              if (_repeatWeekly) ...[
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(_daysOfWeek.length, (idx) {
                    final isSelected = _selectedDays.contains(idx);
                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            if (_selectedDays.length > 1) {
                              _selectedDays.remove(idx);
                            }
                          } else {
                            _selectedDays.add(idx);
                          }
                        });
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? const Color(0xFF4349ED)
                              : const Color(0xFF1B1720),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF4349ED)
                                : const Color(0xFF28232F),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _daysOfWeek[idx],
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF94A3B8),
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
              const SizedBox(height: 32),

              // Remove Slot
              OutlinedButton.icon(
                onPressed: _onRemove,
                icon: const Icon(Icons.delete_outline_rounded,
                    color: Color(0xFFEF4444), size: 16),
                label: const Text(
                  'Remove Slot',
                  style: TextStyle(
                    color: Color(0xFFEF4444),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF4B2329)),
                  backgroundColor: const Color(0xFF231518),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Bottom Cancel & Save Slot buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => context.pop(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Color(0xFF332F3D)),
                        backgroundColor: const Color(0xFF1E1A24),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Cancel',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _onSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4349ED),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Save Slot',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeDropdown(String value, ValueChanged<String?> onChanged) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1720),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF28232F)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: const Color(0xFF1B1720),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: Color(0xFF94A3B8), size: 18),
          isExpanded: true,
          style: const TextStyle(
              color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
          items: _times.map((time) {
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
