import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AdvocateBookingDetailsScreen extends StatefulWidget {
  final String clientName;
  final String caseId;
  final String consultationType;
  final String date;
  final String timeSlot;
  final String fee;
  final String status; // 'confirmed', 'pending', 'cancelled'

  const AdvocateBookingDetailsScreen({
    super.key,
    this.clientName = 'Jhon Vick',
    this.caseId = '1265-8262',
    this.consultationType = 'Video consultation',
    this.date = '16 Sep 2026',
    this.timeSlot = '10:30-10:45 AM',
    this.fee = '499',
    this.status = 'confirmed',
  });

  @override
  State<AdvocateBookingDetailsScreen> createState() =>
      _AdvocateBookingDetailsScreenState();
}

class _AdvocateBookingDetailsScreenState
    extends State<AdvocateBookingDetailsScreen> {
  late String _currentStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.status.toLowerCase();
  }

  void _onAcceptBooking() {
    setState(() {
      _currentStatus = 'confirmed';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Booking Accepted Successfully!'),
        backgroundColor: Color(0xFF16805B),
      ),
    );
  }

  void _onJoinVideo() {
    context.push('/video-call');
  }

  void _onReschedule() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1B1720),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reschedule Consultation',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Select a new slot to propose to the client:',
              style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                'Today, 2:00 PM',
                'Today, 4:30 PM',
                'Tomorrow, 10:30 AM',
                'Tomorrow, 3:00 PM'
              ].map((slot) {
                return ActionChip(
                  label: Text(slot,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 12)),
                  backgroundColor: const Color(0xFF242B42),
                  side: const BorderSide(color: Color(0xFF3B4874)),
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Reschedule proposal sent for $slot'),
                        backgroundColor: const Color(0xFF4349ED),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _onCancel() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1B1720),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Cancel Consultation?',
            style: TextStyle(color: Colors.white)),
        content: const Text(
          'Are you sure you want to cancel this booking? A refund will be initiated to the client.',
          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Keep',
                style: TextStyle(color: Color(0xFF94A3B8))),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC2626)),
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                _currentStatus = 'cancelled';
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Booking cancelled.'),
                  backgroundColor: Color(0xFFDC2626),
                ),
              );
            },
            child: const Text('Confirm Cancel', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bgDark = Color(0xFF0F0D11);
    final isConfirmed = _currentStatus == 'confirmed';
    final isPending = _currentStatus == 'pending';

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
          title: const Text(
            'Booking Details',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Client Header Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF16131A),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF28232F)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
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
                            fontSize: 16,
                          ),
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              Text(
                                'Case id #${widget.caseId}',
                                style: const TextStyle(
                                  color: Color(0xFF94A3B8),
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 6),
                              GestureDetector(
                                onTap: () {
                                  Clipboard.setData(
                                      ClipboardData(text: widget.caseId));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Case ID copied!'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.copy_rounded,
                                  color: Color(0xFF94A3B8),
                                  size: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Status Badge
                    if (isConfirmed)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF142D23),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF1D5A42)),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle_rounded,
                                color: Color(0xFF10B981), size: 13),
                            SizedBox(width: 4),
                            Text(
                              'Confirmed',
                              style: TextStyle(
                                color: Color(0xFF10B981),
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    else if (isPending)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF332912),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF6E5620)),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.access_time_rounded,
                                color: Color(0xFFFBBF24), size: 13),
                            SizedBox(width: 4),
                            Text(
                              'Pending',
                              style: TextStyle(
                                color: Color(0xFFFBBF24),
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF331616),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF752424)),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.cancel_rounded,
                                color: Color(0xFFEF4444), size: 13),
                            SizedBox(width: 4),
                            Text(
                              'Canceled',
                              style: TextStyle(
                                color: Color(0xFFEF4444),
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Section: Consultation Details
              _buildDetailSection(
                title: 'Consultation Details',
                children: [
                  _buildDetailRow(
                    icon: Icons.video_camera_front_outlined,
                    label: 'Consultation type',
                    value: widget.consultationType,
                  ),
                  const Divider(color: Color(0xFF262130), height: 20),
                  _buildDetailRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Date',
                    value: widget.date,
                  ),
                  const Divider(color: Color(0xFF262130), height: 20),
                  _buildDetailRow(
                    icon: Icons.access_time_rounded,
                    label: 'Time slot',
                    value: widget.timeSlot,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Section: Client's Concern
              _buildDetailSection(
                title: "Client's Concern",
                children: [
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Opening attached case documents...'),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.folder_open_rounded,
                            color: Color(0xFF819DFF), size: 18),
                        const SizedBox(width: 10),
                        const Text(
                          'Documents',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          '2 items',
                          style: TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.chevron_right_rounded,
                            color: Color(0xFF94A3B8), size: 18),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Section: Consultation Fees
              _buildDetailSection(
                title: 'Consultation Fees',
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${widget.fee}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF142D23),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle_rounded,
                                color: Color(0xFF10B981), size: 12),
                            SizedBox(width: 4),
                            Text(
                              'Paid',
                              style: TextStyle(
                                color: Color(0xFF10B981),
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Section: Booking Activity (Timeline)
              _buildDetailSection(
                title: 'Booking Activity',
                children: [
                  _buildTimelineItem(
                    title: 'Booking Received',
                    subtitle: 'Today 09:22 AM',
                    isDone: true,
                    isLast: false,
                  ),
                  _buildTimelineItem(
                    title: 'Booking Confirmed',
                    subtitle: isConfirmed ? 'Today 10:00 AM' : 'Pending',
                    isDone: isConfirmed,
                    isLast: false,
                  ),
                  _buildTimelineItem(
                    title: 'Consultation Completed',
                    subtitle: 'Pending',
                    isDone: false,
                    isLast: true,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Actions
              if (isConfirmed) ...[
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _onJoinVideo,
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
                        Icon(Icons.videocam_rounded, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Join Video Consultation',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _onCancel,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFF87171),
                          side: const BorderSide(color: Color(0xFF4A2528)),
                          backgroundColor: const Color(0xFF26181B),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Cancel',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _onReschedule,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Color(0xFF332F3D)),
                          backgroundColor: const Color(0xFF1E1A24),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Reschedule',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ] else if (isPending) ...[
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _onAcceptBooking,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4349ED),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Accept',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _onCancel,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFF87171),
                          side: const BorderSide(color: Color(0xFF4A2528)),
                          backgroundColor: const Color(0xFF26181B),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Cancel',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _onReschedule,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Color(0xFF332F3D)),
                          backgroundColor: const Color(0xFF1E1A24),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Reschedule',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF16131A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF28232F)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF819DFF), size: 17),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 13,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String subtitle,
    required bool isDone,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDone ? const Color(0xFF4349ED) : Colors.transparent,
                border: Border.all(
                  color: isDone
                      ? const Color(0xFF4349ED)
                      : const Color(0xFF475569),
                  width: 2,
                ),
              ),
              child: isDone
                  ? const Center(
                      child: Icon(Icons.circle, color: Colors.white, size: 6))
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 32,
                color: isDone
                    ? const Color(0xFF4349ED).withValues(alpha: 0.5)
                    : const Color(0xFF334155),
              ),
          ],
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isDone ? Colors.white : const Color(0xFF94A3B8),
                fontSize: 13,
                fontWeight: isDone ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 11,
              ),
            ),
            if (!isLast) const SizedBox(height: 14),
          ],
        ),
      ],
    );
  }
}
