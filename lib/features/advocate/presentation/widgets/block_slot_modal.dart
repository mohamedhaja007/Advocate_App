import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BlockSlotModal extends StatelessWidget {
  final String dateTitle;
  final String slotTime;
  final String durationText;
  final VoidCallback onBlocked;

  const BlockSlotModal({
    super.key,
    this.dateTitle = 'Monday, 21 Sep',
    this.slotTime = '10:30 AM - 11:15 AM',
    this.durationText = '(30 mins)',
    required this.onBlocked,
  });

  static Future<void> show(
    BuildContext context, {
    String dateTitle = 'Monday, 21 Sep',
    String slotTime = '10:30 AM - 11:15 AM',
    String durationText = '(30 mins)',
    required VoidCallback onBlocked,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1B1720),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => BlockSlotModal(
        dateTitle: dateTitle,
        slotTime: slotTime,
        durationText: durationText,
        onBlocked: onBlocked,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Date & Available pill + Close
            Row(
              children: [
                Text(
                  dateTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF142D23),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'AVAILABLE',
                    style: TextStyle(
                      color: Color(0xFF10B981),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close_rounded,
                      color: Color(0xFF94A3B8), size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Time & duration
            Row(
              children: [
                const Icon(Icons.access_time_rounded,
                    color: Color(0xFF819DFF), size: 16),
                const SizedBox(width: 8),
                Text(
                  '$slotTime • $durationText',
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Explanatory note
            const Text(
              'Block this slot to prevent clients from booking online during this time window.',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 12,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 24),

            // Actions row: Manage & Block slot
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      context.push(
                        '/advocate/edit-slot',
                        extra: {
                          'dateTitle': dateTitle,
                          'startTime': '10:30 AM',
                          'endTime': '11:15 AM',
                        },
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFF332F3D)),
                      backgroundColor: const Color(0xFF262130),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings_outlined, size: 16),
                        SizedBox(width: 6),
                        Text(
                          'Manage',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onBlocked();
                    },
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
                      'Block slot',
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
