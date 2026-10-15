import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AdvocateBankDetailsScreen extends StatelessWidget {
  const AdvocateBankDetailsScreen({super.key});

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
            'Bank details',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: [
            // Bank Card
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
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFF232A44),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.account_balance_rounded,
                            color: Color(0xFF819DFF), size: 20),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'HDFC Bank Ltd.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Chamber Retainer Current A/C',
                              style: TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF142D23),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFF1D5A42)),
                        ),
                        child: const Text(
                          'Verified',
                          style: TextStyle(
                            color: Color(0xFF10B981),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Color(0xFF262130), height: 24),

                  // Account Holder
                  const Text(
                    'ACCOUNT HOLDER',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    children: [
                      Text(
                        'Adv. Rajeshwari Sharma',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.check_circle_rounded,
                          color: Color(0xFF10B981), size: 14),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Account Number & IFSC
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'ACCOUNT NUMBER',
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Text(
                                  '•••• •••• 9042',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                GestureDetector(
                                  onTap: () {
                                    Clipboard.setData(
                                        const ClipboardData(text: '9042'));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Account number copied!'),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                  child: const Icon(Icons.copy_rounded,
                                      color: Color(0xFF94A3B8), size: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'IFSC & BRANCH',
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'HDFC0001234\nNew Delhi',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                height: 1.25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Penny drop verified note
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF142D23),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF1D5A42)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.shield_outlined,
                      color: Color(0xFF10B981), size: 16),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '₹1.00 Penny Drop Verified • NPCI e-Mandate 100% Match',
                      style: TextStyle(
                        color: Color(0xFF10B981),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Recent Settlements Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Settlements',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2C60),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'T+1 Dispatched',
                    style: TextStyle(
                      color: Color(0xFF819DFF),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Settlement 1 (Today)
            _buildSettlementCard(
              icon: Icons.north_east_rounded,
              iconColor: const Color(0xFF10B981),
              iconBg: const Color(0xFF142D23),
              title: 'Today Payout',
              badge: 'Dispatched',
              badgeColor: const Color(0xFF10B981),
              badgeBg: const Color(0xFF142D23),
              utr: 'UTR: HDFC89127391',
              timeText: '07:02 PM',
              amount: '₹6,789',
            ),
            const SizedBox(height: 10),

            // Settlement 2 (Yesterday)
            _buildSettlementCard(
              icon: Icons.done_all_rounded,
              iconColor: const Color(0xFF819DFF),
              iconBg: const Color(0xFF1E2C60),
              title: 'Yesterday Payout',
              badge: 'Settled',
              badgeColor: const Color(0xFF819DFF),
              badgeBg: const Color(0xFF1E2C60),
              utr: 'UTR: HDFC8901244',
              timeText: 'T+1 Cleared',
              amount: '₹11,250',
            ),
            const SizedBox(height: 10),

            // Settlement 3 (18 Sep)
            _buildSettlementCard(
              icon: Icons.done_all_rounded,
              iconColor: const Color(0xFF819DFF),
              iconBg: const Color(0xFF1E2C60),
              title: '18 Sep Payout',
              badge: 'Settled',
              badgeColor: const Color(0xFF819DFF),
              badgeBg: const Color(0xFF1E2C60),
              utr: 'UTR: HDFC87431198',
              timeText: 'T+1 Cleared',
              amount: '₹8,500',
            ),
            const SizedBox(height: 24),

            // Statutory Section
            const Text(
              'Statutory',
              style: TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            // Change Primary Bank Account
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Aadhaar / Bar Sanad e-Sign OTP initiated for bank change.'),
                    backgroundColor: Color(0xFF4349ED),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF16131A),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF28232F)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.swap_horiz_rounded,
                        color: Color(0xFF819DFF), size: 20),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Change Primary Bank Account',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Requires Aadhaar / Bar Sanad e-Sign OTP',
                            style: TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded,
                        color: Color(0xFF64748B), size: 18),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Download TDS & Settlement Statement
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Downloading FY 2024-25 Form 26AS Reconciliation Statement PDF...'),
                    backgroundColor: Color(0xFF16805B),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF16131A),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF28232F)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.description_outlined,
                        color: Color(0xFF819DFF), size: 20),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Download FY 2024-25 TDS & Settlement Statement (PDF)',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Form 26AS Reconciliation Statement',
                            style: TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.download_rounded,
                        color: Color(0xFF819DFF), size: 18),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSettlementCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String badge,
    required Color badgeColor,
    required Color badgeBg,
    required String utr,
    required String timeText,
    required String amount,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF16131A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF28232F)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 18),
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: badgeBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        badge,
                        style: TextStyle(
                          color: badgeColor,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '$utr   •   $timeText',
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
