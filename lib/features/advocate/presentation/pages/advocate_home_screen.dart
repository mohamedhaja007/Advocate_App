import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../widgets/advocate_ai_chat_icon.dart';

class AdvocateHomeScreen extends StatefulWidget {
  final VoidCallback onViewAllBookings;

  const AdvocateHomeScreen({
    super.key,
    required this.onViewAllBookings,
  });

  @override
  State<AdvocateHomeScreen> createState() => _AdvocateHomeScreenState();
}

class _AdvocateHomeScreenState extends State<AdvocateHomeScreen> {
  bool _availableForConsults = true;
  bool _secondScheduleAccepted = false;

  void _onJoinVideo() {
    context.push('/video-call');
  }

  void _onAcceptPending() {
    setState(() {
      _secondScheduleAccepted = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Consultation Accepted!'),
        backgroundColor: Color(0xFF16805B),
      ),
    );
  }

  void _onReschedule() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reschedule proposal sent to client.'),
        backgroundColor: Color(0xFF5244E9),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      children: [
        // 1. Top Location & Action Buttons Bar
        Row(
          children: [
            InkWell(
              onTap: () => context.push('/choose-location'),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on_rounded,
                          color: Colors.white, size: 18),
                      SizedBox(width: 4),
                      Text(
                        'Chennai ⌵',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Tamil Nadu',
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Notification Bell
            InkWell(
              onTap: () => context.push('/notifications'),
              borderRadius: BorderRadius.circular(22),
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFF1B1720),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF28232F)),
                ),
                child: const Icon(Icons.notifications_none_rounded,
                    color: Colors.white, size: 20),
              ),
            ),
            const SizedBox(width: 10),
            // Chat Message Bubble
            InkWell(
              onTap: () => context.push(
                '/advocate-chat',
                extra: {
                  'lawyerName': 'Client Jhon Vick',
                  'lawyerImage': 'assets/images/Png/Man.png',
                },
              ),
              borderRadius: BorderRadius.circular(22),
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFF1B1720),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF28232F)),
                ),
                child: const Icon(Icons.chat_bubble_outline_rounded,
                    color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // 2. Search Bar & Floating AI Chatbot Button (matching reference image)
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF16131A),
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(color: const Color(0xFF28232F)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      color: Color(0xFF94A3B8),
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        style:
                            const TextStyle(color: Colors.white, fontSize: 13),
                        decoration: const InputDecoration(
                          hintText: 'Search attorneys or legal issues',
                          hintStyle: TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 13,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onSubmitted: (query) {
                          if (query.trim().isNotEmpty) {
                            context.push(
                              '/advocate/ai-chat',
                              extra: {'initialPrompt': query.trim()},
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            // White circular AI chat button
            InkWell(
              onTap: () => context.push('/advocate/ai-chat'),
              borderRadius: BorderRadius.circular(25),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Center(
                  child: AdvocateAiChatIcon(
                    size: 26,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // 2. Justice Matters Hero Banner with Gavel & Books Image
        ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Container(
            height: 168,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF0F1B3E),
                  Color(0xFF172957),
                  Color(0xFF1F356C),
                ],
              ),
            ),
            child: Stack(
              children: [
                // Right Half Gavel on Books Image with smooth edge fade
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  width: 190,
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.transparent, Colors.black],
                        stops: [0.0, 0.35],
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image.asset(
                      'assets/images/Png/gavel_banner.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(

                        color: const Color(0xFF1E293B),
                        child: const Center(
                          child: Icon(Icons.gavel_rounded,
                              size: 50, color: Color(0xFFE5A024)),
                        ),
                      ),
                    ),
                  ),
                ),

                // Left Content Text & View Profile Action
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Justice matters',
                        style: TextStyle(
                          color: Color(0xFFE5A024), // Golden Amber
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.4,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Your expertise build\na fairer tomorrow',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          height: 1.22,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Lorem Ipsum is simply dummy text of\nthe printing',
                        style: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 10,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () => context.push('/professional-details'),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5A024),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'View Profile',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.open_in_new_rounded,
                                  color: Colors.white, size: 13),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // 3. Available for Consults Switch Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF16131A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF28232F)),
          ),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF10B981),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available for Consults',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Accepting Virtual & Chambers',
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
                activeThumbColor: Colors.white,
                activeTrackColor: const Color(0xFF5244E9),
                inactiveThumbColor: const Color(0xFF64748B),
                inactiveTrackColor: const Color(0xFF28232F),
                onChanged: (val) => setState(() => _availableForConsults = val),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 4. 2x2 Stats Grid (Vibrant Purple & Crisp White Alternating)
        Row(
          children: [
            // Top-Left: Today Booking (Vibrant Purple Card)
            Expanded(
              child: _buildPurpleMetricCard(
                title: 'Today Booking',
                value: '05',
                badgeText: '+2 vs yest',
                badgeIcon: Icons.trending_up,
                icon: Icons.calendar_month_rounded,
              ),
            ),
            const SizedBox(width: 12),
            // Top-Right: Pending (Crisp White Card)
            Expanded(
              child: _buildWhiteMetricCard(
                title: 'Pending',
                value: '02',
                badgeText: 'Action Req.',
                badgeBgColor: const Color(0xFFFEF3C7),
                badgeTextColor: const Color(0xFFD97706),
                icon: Icons.access_time_rounded,
                iconColor: const Color(0xFF3B82F6),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            // Bottom-Left: Today Fees (Crisp White Card)
            Expanded(
              child: _buildWhiteMetricCard(
                title: 'Today Fees',
                value: '₹6,789',
                badgeText: '+2% vs yest',
                badgeIcon: Icons.trending_up,
                badgeBgColor: const Color(0xFFDCFCE7),
                badgeTextColor: const Color(0xFF16A34A),
                icon: Icons.account_balance_wallet_rounded,
                iconColor: const Color(0xFF3B82F6),
              ),
            ),
            const SizedBox(width: 12),
            // Bottom-Right: Rating (Vibrant Purple Card)
            Expanded(
              child: _buildRatingPurpleCard(
                title: 'Rating',
                rating: '4.1',
                maxRating: '/5.0',
                subtitle: 'from 148 verified clients',
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),

        // 5. Today's Schedule Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Today's Schedule",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: widget.onViewAllBookings,
              child: const Text(
                'View All',
                style: TextStyle(
                  color: Color(0xFF5244E9),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // 6. Schedule Card 1 (Confirmed)
        InkWell(
          onTap: () {
            context.push(
              '/booking-details',
              extra: {
                'clientName': 'Jhon Vick',
                'caseId': '1265-8262',
                'consultationType': 'Video consultation',
                'date': 'Today',
                'timeSlot': '10:30 - 10:45 AM',
                'fee': '499',
                'status': 'confirmed',
              },
            );
          },
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF16131A),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFF28232F)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Video Consultation | Confirmed Badge
                Row(
                  children: [
                    const Icon(Icons.videocam_outlined,
                        color: Color(0xFF38BDF8), size: 18),
                    const SizedBox(width: 8),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF064E3B).withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: const Color(0xFF059669).withValues(alpha: 0.6)),
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
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Client Info (Avatar PS, Jhon Vick, Case ID)
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
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
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Jhon Vick',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Text(
                              'Case id #1265-8262',
                              style: TextStyle(
                                  color: Color(0xFF94A3B8), fontSize: 12),
                            ),
                            const SizedBox(width: 4),
                            InkWell(
                              onTap: () {
                                Clipboard.setData(
                                    const ClipboardData(text: '#1265-8262'));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Case ID copied!'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                              child: const Icon(Icons.copy_rounded,
                                  color: Color(0xFF94A3B8), size: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Time Slot Container
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF25202B),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.calendar_today_outlined,
                          color: Color(0xFF819DFF), size: 15),
                      SizedBox(width: 8),
                      Text(
                        'Today, 10:30 - 10:45AM (15 mins)',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // 7. Schedule Card 2 (Pending with Reschedule & Accept Actions)
        InkWell(
          onTap: () {
            context.push(
              '/booking-details',
              extra: {
                'clientName': 'Jhon',
                'caseId': '1265-8263',
                'consultationType': 'Video consultation',
                'date': 'Today',
                'timeSlot': '10:30 - 10:45 AM',
                'fee': '499',
                'status': _secondScheduleAccepted ? 'confirmed' : 'pending',
              },
            );
          },
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF16131A),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFF28232F)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Video Consultation | Pending Badge
                Row(
                  children: [
                    const Icon(Icons.videocam_outlined,
                        color: Color(0xFF38BDF8), size: 18),
                    const SizedBox(width: 8),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _secondScheduleAccepted
                            ? const Color(0xFF064E3B).withValues(alpha: 0.35)
                            : const Color(0xFF451A03).withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _secondScheduleAccepted
                              ? const Color(0xFF059669).withValues(alpha: 0.6)
                              : const Color(0xFFD97706).withValues(alpha: 0.6),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _secondScheduleAccepted
                                ? Icons.check_circle_rounded
                                : Icons.access_time_rounded,
                            color: _secondScheduleAccepted
                                ? const Color(0xFF10B981)
                                : const Color(0xFFFBBF24),
                            size: 13,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _secondScheduleAccepted ? 'Confirmed' : 'Pending',
                            style: TextStyle(
                              color: _secondScheduleAccepted
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFFFBBF24),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Client Info (PS, Jhon, Case ID)
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
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
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Jhon',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Text(
                              'Case id #1265-8263',
                              style: TextStyle(
                                  color: Color(0xFF94A3B8), fontSize: 12),
                            ),
                            const SizedBox(width: 4),
                            InkWell(
                              onTap: () {
                                Clipboard.setData(
                                    const ClipboardData(text: '#1265-8263'));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Case ID copied!'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                              child: const Icon(Icons.copy_rounded,
                                  color: Color(0xFF94A3B8), size: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Time Slot Container
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF25202B),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.calendar_today_outlined,
                          color: Color(0xFF819DFF), size: 15),
                      SizedBox(width: 8),
                      Text(
                        'Today, 10:30 - 10:45AM (15 mins)',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Sub Info: Starts in 45 mins | ₹499 (incl. taxes)
                const Row(
                  children: [
                    Icon(Icons.circle, color: Color(0xFF10B981), size: 7),
                    SizedBox(width: 5),
                    Text(
                      'Starts in 45 mins',
                      style: TextStyle(
                        color: Color(0xFF10B981),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '₹499 (incl. taxes)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Actions: Reschedule & Accept
                if (_secondScheduleAccepted)
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton.icon(
                      onPressed: _onJoinVideo,
                      icon: const Icon(Icons.videocam_rounded, size: 18),
                      label: const Text('Join Video Consultation',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5244E9),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _onReschedule,
                          icon: const Icon(Icons.calendar_month_outlined,
                              size: 16, color: Colors.white),
                          label: const Text('Reschedule',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF3B3346)),
                            backgroundColor: const Color(0xFF25202B),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _onAcceptPending,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5244E9),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Accept',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  // Card Widget: Purple/Blue Gradient/Solid Card (Top-Left)
  Widget _buildPurpleMetricCard({
    required String title,
    required String value,
    required String badgeText,
    required IconData badgeIcon,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF5244E9),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5244E9).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
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
              const Spacer(),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(badgeIcon, color: const Color(0xFF38BDF8), size: 12),
                const SizedBox(width: 4),
                Text(
                  badgeText,
                  style: const TextStyle(
                    color: Color(0xFFE0F2FE),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Card Widget: Crisp White Card (Top-Right & Bottom-Left)
  Widget _buildWhiteMetricCard({
    required String title,
    required String value,
    required String badgeText,
    IconData? badgeIcon,
    required Color badgeBgColor,
    required Color badgeTextColor,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF475569),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFF6FF),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: badgeBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (badgeIcon != null) ...[
                  Icon(badgeIcon, color: badgeTextColor, size: 12),
                  const SizedBox(width: 4),
                ],
                Text(
                  badgeText,
                  style: TextStyle(
                    color: badgeTextColor,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Card Widget: Purple Rating Card (Bottom-Right)
  Widget _buildRatingPurpleCard({
    required String title,
    required String rating,
    required String maxRating,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF5244E9),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5244E9).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
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
              const Spacer(),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.star_rounded,
                    color: Color(0xFFFBBF24), size: 18),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                rating,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                maxRating,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
