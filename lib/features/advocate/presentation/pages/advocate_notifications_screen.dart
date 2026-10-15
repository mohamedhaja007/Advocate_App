import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AdvocateNotificationsScreen extends StatelessWidget {
  const AdvocateNotificationsScreen({super.key});

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
          title: const Text(
            'Notification',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF1B1720),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF28232F)),
                ),
                child: const Icon(Icons.notifications_none_rounded,
                    color: Colors.white, size: 18),
              ),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          children: [
            // Section: Today
            _buildSectionHeader(title: 'Today', badgeText: '2 Unread', dateText: 'Oct 24, 2026'),
            const SizedBox(height: 12),

            // Card 1: Video Consultation
            _buildNotificationCard(
              avatarWidget: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/Png/Man.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 40,
                    height: 40,
                    color: const Color(0xFF232A44),
                    child: const Icon(Icons.person, color: Color(0xFF819DFF)),
                  ),
                ),
              ),
              title: 'Video Consultation',
              timeAgo: '2 hrs ago',
              description:
                  'Adv. Elena Marlowe • Corporate Law\nToday at 10:30 AM • 15 min slot',
              actions: [
                ElevatedButton(
                  onPressed: () => context.push('/video-call'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.videocam_rounded, size: 15, color: Colors.black),
                      SizedBox(width: 6),
                      Text(
                        'Join Video Room',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Reschedule proposal sent.'),
                        backgroundColor: Color(0xFF4349ED),
                      ),
                    );
                  },
                  child: const Text(
                    'Reschedule',
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Card 2: Escrow Protected
            _buildNotificationCard(
              avatarWidget: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFF142D23),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.verified_user_rounded,
                    color: Color(0xFF10B981), size: 20),
              ),
              title: 'Escrow Protected',
              timeAgo: '2 hrs ago',
              description:
                  'Payment confirmed via UPI for 15m consultation.\n● Avvocat Escrow Guarantee Active',
              actions: [
                OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Downloading Escrow Receipt...'),
                        backgroundColor: Color(0xFF16805B),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFF332F3D)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Receipt',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Section: Yesterday
            _buildSectionHeader(title: 'Yesterday', dateText: 'Oct 23, 2026'),
            const SizedBox(height: 12),

            // Card 3: Document Filed: Vakalatnama
            _buildNotificationCard(
              avatarWidget: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFF332912),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.description_outlined,
                    color: Color(0xFFFBBF24), size: 20),
              ),
              title: 'Document Filed: Vakalatnama',
              timeAgo: 'Yesterday',
              description:
                  'E-filing confirmation received from State Bar Council.\nFiling Reg: #KLR-2026-890',
              actions: [
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Opening Bar Council Acknowledgement...'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.download_rounded,
                      size: 14, color: Colors.black),
                  label: const Text(
                    'Acknowledgement',
                    style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Section: Earlier This Week
            _buildSectionHeader(title: 'Earlier This Week'),
            const SizedBox(height: 12),

            // Card 4: Shield Credit Added
            _buildNotificationCard(
              avatarWidget: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFF1E2C60),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.account_balance_wallet_outlined,
                    color: Color(0xFF6B8AFF), size: 20),
              ),
              title: '₹500 Shield Credit Added',
              timeAgo: '4d ago',
              description:
                  'Rohan verified their client profile using your legal invite link. Balance usable for any advocate session.',
            ),
            const SizedBox(height: 12),

            // Card 5: Document Filed
            _buildNotificationCard(
              avatarWidget: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFF262130),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.article_outlined,
                    color: Color(0xFF94A3B8), size: 20),
              ),
              title: 'Document Filed',
              timeAgo: '4d ago',
              description:
                  'Rohan verified their client profile using your legal invite link.',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    String? badgeText,
    String? dateText,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (badgeText != null) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF252A4A),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              badgeText,
              style: const TextStyle(
                color: Color(0xFF6B8AFF),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        const Spacer(),
        if (dateText != null)
          Text(
            dateText,
            style: const TextStyle(color: Color(0xFF64748B), fontSize: 11),
          ),
      ],
    );
  }

  Widget _buildNotificationCard({
    required Widget avatarWidget,
    required String title,
    required String timeAgo,
    required String description,
    List<Widget>? actions,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              avatarWidget,
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          timeAgo,
                          style: const TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (actions != null && actions.isNotEmpty) ...[
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 52.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: actions,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
