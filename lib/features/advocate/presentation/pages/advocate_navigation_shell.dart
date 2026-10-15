import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'advocate_home_screen.dart';
import 'advocate_bookings_screen.dart';
import 'advocate_calendar_screen.dart';

class AdvocateNavigationShell extends StatefulWidget {
  final int initialIndex;

  const AdvocateNavigationShell({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<AdvocateNavigationShell> createState() =>
      _AdvocateNavigationShellState();
}

class _AdvocateNavigationShellState extends State<AdvocateNavigationShell> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  Widget _buildAdvocateProfileTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      children: [
        // Location & Actions Header
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                InkWell(
                  onTap: () => context.push('/choose-location'),
                  child: const Row(
                    children: [
                      Icon(Icons.location_on_rounded,
                          color: Color(0xFF819DFF), size: 14),
                      SizedBox(width: 4),
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
            // Message Bubble
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
        const SizedBox(height: 18),

        // Profile Identity Card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF16131A),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF28232F)),
          ),
          child: Column(
            children: [
              // Avatar
              Center(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Image.asset(
                        'assets/images/Png/Man.png',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(
                          width: 70,
                          height: 70,
                          decoration: const BoxDecoration(
                            color: Color(0xFF232A44),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person,
                              color: Color(0xFF819DFF), size: 36),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xFF4349ED),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.edit_rounded,
                            color: Colors.white, size: 13),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Name & Edit Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Adv. Rajeshwari Sharma',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 6),
                  InkWell(
                    onTap: () => context.push('/advocate/professional-details'),
                    child: const Icon(Icons.edit_outlined,
                        color: Color(0xFF94A3B8), size: 15),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              // Bar Council ID pill
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF142D23),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle, color: Color(0xFF10B981), size: 6),
                    SizedBox(width: 5),
                    Text(
                      'Bar Council ID: D/1842/2011',
                      style: TextStyle(
                        color: Color(0xFF10B981),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Subtitle
              const Text(
                'Senior Advocate, High Court of Delhi • Supreme Court Bar Association',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 11,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Info Rows Menu List
        _buildProfileDetailRow(
          icon: Icons.workspace_premium_outlined,
          title: 'Experience',
          badgeText: 'SENIORITY STANDING',
          subtitle: '14+ Years in Active Practice',
          onTap: () => context.push('/advocate/professional-details'),
        ),
        const SizedBox(height: 10),
        _buildProfileDetailRow(
          icon: Icons.location_on_outlined,
          title: 'Location',
          subtitle:
              'Chamber 412, Lawyers Chambers Block, High Court of Delhi, Sher Shah Road & 14C Defence Colony, New Delhi',
          onTap: () => context.push('/advocate/professional-details'),
        ),
        const SizedBox(height: 10),
        _buildProfileDetailRow(
          icon: Icons.category_outlined,
          title: 'Practice Specializations',
          subtitle: 'Corporate Law, Commercial Contracts, Civil Litigation',
          onTap: () => context.push('/advocate/professional-details'),
        ),
        const SizedBox(height: 10),
        _buildProfileDetailRow(
          icon: Icons.translate_rounded,
          title: 'Languages Spoken',
          subtitle: 'English, Tamil, Hindi',
          onTap: () => context.push('/advocate/professional-details'),
        ),
        const SizedBox(height: 10),
        _buildProfileDetailRow(
          icon: Icons.account_balance_outlined,
          title: 'Chamber Bank Account & Settlements',
          subtitle: 'HDFC Bank (•••• 9042) • T+1 Disbursals',
          onTap: () => context.push('/advocate/bank-details'),
        ),
        const SizedBox(height: 10),
        _buildProfileDetailRow(
          icon: Icons.payments_outlined,
          title: 'Fees & Realized Retainers',
          subtitle: '₹42,850 Realized Today • 10% TDS Sec 194J',
          onTap: () => context.push('/advocate/fees-summary'),
        ),
        const SizedBox(height: 10),

        // Theme Toggle Row
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF16131A),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF28232F)),
          ),
          child: const Row(
            children: [
              Icon(Icons.palette_outlined, color: Color(0xFF819DFF), size: 18),
              SizedBox(width: 12),
              Text(
                'Theme',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                'Dark',
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 13,
                ),
              ),
              SizedBox(width: 6),
              Icon(Icons.chevron_right_rounded,
                  color: Color(0xFF64748B), size: 18),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Client Reviews & Ratings Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF16131A),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFF28232F)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.rate_review_outlined,
                      color: Color(0xFF819DFF), size: 18),
                  const SizedBox(width: 8),
                  const Text(
                    'Client Reviews & Ratings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF332912),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star_rounded,
                            color: Color(0xFFFBBF24), size: 13),
                        SizedBox(width: 3),
                        Text(
                          '4.9 (128 Rev)',
                          style: TextStyle(
                            color: Color(0xFFFBBF24),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Verified feedback from 30+ legal advisories and chamber consultations.',
                style: TextStyle(color: Color(0xFF64748B), fontSize: 11),
              ),
              const SizedBox(height: 14),

              // Summary Box (4.9 Exceptional Legal Acumen)
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B1720),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '4.9',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: List.generate(
                                5,
                                (index) => const Icon(Icons.star_rounded,
                                    color: Color(0xFFFBBF24), size: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Exceptional Legal Acumen',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Top 1% rated advocate in Commercial & Civil matters',
                                style: TextStyle(
                                  color: Color(0xFF64748B),
                                  fontSize: 11,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: Color(0xFF28232F), height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _ReviewMiniStat('100%', 'RECOMMENDED'),
                        _ReviewMiniStat('98%', 'CASE CLARITY'),
                        _ReviewMiniStat('129', 'CLIENTS'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Featured Review Card
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B1720),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Meera Nambiar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          ' • Civil Litigation',
                          style: TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 11,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF142D23),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check_circle_rounded,
                                  color: Color(0xFF10B981), size: 10),
                              SizedBox(width: 3),
                              Text(
                                'Verified',
                                style: TextStyle(
                                  color: Color(0xFF10B981),
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (index) => const Icon(Icons.star_rounded,
                                color: Color(0xFFFBBF24), size: 12),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          '1 week ago',
                          style:
                              TextStyle(color: Color(0xFF64748B), fontSize: 10),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      '"Clear legal opinion during the urgent chamber consultation. Cut straight through complex contractual clauses."',
                      style: TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 11,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // View All 128 Reviews Link
              Center(
                child: InkWell(
                  onTap: () => context.push('/advocate/reviews'),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View All 128 Reviews',
                          style: TextStyle(
                            color: Color(0xFF6B8AFF),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward_rounded,
                            color: Color(0xFF6B8AFF), size: 14),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Switch to Client Mode
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF19223B),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF2D3B68)),
          ),
          child: Row(
            children: [
              const Icon(Icons.swap_horiz_rounded,
                  color: Color(0xFF6B8AFF), size: 22),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Client Mode',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Browse and hire other legal advocates',
                      style: TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => context.go('/home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4349ED),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Switch',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Log Out of Account Button
        InkWell(
          onTap: () => context.go('/advocate/login'),
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF261518),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF4A2528)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout_rounded, color: Color(0xFFEF4444), size: 16),
                SizedBox(width: 8),
                Text(
                  'Log Out of Account',
                  style: TextStyle(
                    color: Color(0xFFEF4444),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),

        // Footer
        const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.shield_outlined, color: Color(0xFF64748B), size: 13),
              SizedBox(width: 6),
              Text(
                'Protected by Bar Council Ethics & AES-256 Vault',
                style: TextStyle(color: Color(0xFF64748B), fontSize: 10),
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        const Center(
          child: Text(
            'AvvocatAI Mobile v2.4.1 (Build 184)',
            style: TextStyle(color: Color(0xFF475569), fontSize: 10),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildProfileDetailRow({
    required IconData icon,
    required String title,
    String? badgeText,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF16131A),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF28232F)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 2),
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFF1E1A24),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF819DFF), size: 17),
            ),
            const SizedBox(width: 12),
            Expanded(
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
                      if (badgeText != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E2C60),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            badgeText,
                            style: const TextStyle(
                              color: Color(0xFF819DFF),
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 11,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right_rounded,
                color: Color(0xFF64748B), size: 18),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bgDark = Color(0xFF0F0D11);

    final screens = [
      AdvocateHomeScreen(
        onViewAllBookings: () {
          setState(() => _currentIndex = 1);
        },
      ),
      const AdvocateBookingsScreen(),
      const AdvocateCalendarScreen(),
      _buildAdvocateProfileTab(),
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: bgDark,
      ),
      child: Scaffold(
        backgroundColor: bgDark,
        body: SafeArea(
          child: screens[_currentIndex],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF141118),
            border: Border(
              top: BorderSide(color: Color(0xFF231F2A), width: 1),
            ),
          ),
          padding: const EdgeInsets.only(top: 4, bottom: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(
                index: 0,
                label: 'Home',
                icon: Icons.home_outlined,
                activeIcon: Icons.home_rounded,
              ),
              _buildBottomNavItem(
                index: 1,
                label: 'Booking',
                icon: Icons.calendar_today_outlined,
                activeIcon: Icons.calendar_today_rounded,
              ),
              _buildBottomNavItem(
                index: 2,
                label: 'Calendar',
                icon: Icons.calendar_month_outlined,
                activeIcon: Icons.calendar_month_rounded,
              ),
              _buildBottomNavItem(
                index: 3,
                label: 'Profile',
                icon: Icons.person_outline_rounded,
                activeIcon: Icons.person_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({
    required int index,
    required String label,
    required IconData icon,
    required IconData activeIcon,
  }) {
    final isSelected = _currentIndex == index;
    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Active top line indicator
            Container(
              width: 30,
              height: 3,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF5244E9) : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 6),
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? const Color(0xFF5244E9) : const Color(0xFF64748B),
              size: 22,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFF5244E9) : const Color(0xFF64748B),
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _ReviewMiniStat extends StatelessWidget {
  final String value;
  final String label;

  const _ReviewMiniStat(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF64748B),
            fontSize: 9,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
