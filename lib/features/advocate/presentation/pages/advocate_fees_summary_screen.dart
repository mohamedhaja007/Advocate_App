import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AdvocateFeesSummaryScreen extends StatefulWidget {
  const AdvocateFeesSummaryScreen({super.key});

  @override
  State<AdvocateFeesSummaryScreen> createState() =>
      _AdvocateFeesSummaryScreenState();
}

class _AdvocateFeesSummaryScreenState extends State<AdvocateFeesSummaryScreen> {
  int _selectedPeriod = 0; // 0: Today, 1: This Week, 2: This Month, 3: FY 2024-25

  final List<String> _periods = ['Today', 'This Week', 'This Month', 'FY 2024-25'];

  void _onInstantSettle() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1B1720),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Instant Settle to HDFC?',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        content: const Text(
          'Initiate immediate nodal transfer of ₹6,789 directly to your verified HDFC Chamber Retainer account (**4012)? Standard IMPS speed applies.',
          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF94A3B8))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      '₹6,789 successfully dispatched to HDFC Account (**4012)!'),
                  backgroundColor: Color(0xFF16805B),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4349ED),
              foregroundColor: Colors.white,
            ),
            child: const Text('Confirm Settle'),
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
          title: const Text(
            'Fees Summary',
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
            // Period Filter Pills Row
            Row(
              children: _periods.asMap().entries.map((entry) {
                final idx = entry.key;
                final period = entry.value;
                final isSelected = _selectedPeriod == idx;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: InkWell(
                      onTap: () => setState(() => _selectedPeriod = idx),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF4349ED)
                              : const Color(0xFF1B1720),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF4349ED)
                                : const Color(0xFF28232F),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            period,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF94A3B8),
                              fontSize: 11,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 18),

            // Card 1: Today's Net Realized Earnings
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF16131A),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFF28232F)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Today's Net Realized Earnings",
                    style: TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        '₹6,789',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF142D23),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.trending_up_rounded,
                                color: Color(0xFF10B981), size: 14),
                            SizedBox(width: 4),
                            Text(
                              '+7.4%',
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

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '₹42,850',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'T+1 Auto Disbursal - 07:00 PM',
                              style: TextStyle(
                                color: const Color(0xFF10B981)
                                    .withValues(alpha: 0.9),
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '₹7,543',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Before 10% TDS Sec 194J',
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _onInstantSettle,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4349ED),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Instant Settle to HDFC Account (**4012)',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Card 2: Fee Flow Distribution
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF16131A),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFF28232F)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Fee Flow Distribution',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Total Fee  ₹42,850',
                        style: TextStyle(
                          color: const Color(0xFF819DFF).withValues(alpha: 0.9),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    '100% Retainer Rate',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 11),
                  ),
                  const SizedBox(height: 14),

                  // Horizontal distribution bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 60,
                          child: Container(
                            height: 8,
                            color: const Color(0xFF4349ED),
                          ),
                        ),
                        Expanded(
                          flex: 30,
                          child: Container(
                            height: 8,
                            color: const Color(0xFF60A5FA),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Container(
                            height: 8,
                            color: const Color(0xFF10B981),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Breakdown Row 1: Video Consultations
                  _buildDistributionRow(
                    color: const Color(0xFF4349ED),
                    title: 'Video Consultations',
                    subtitle:
                        'High-definition encrypted call via Nyaya Secure Meet',
                    amount: '₹4,491',
                  ),
                  const Divider(color: Color(0xFF262130), height: 22),

                  // Breakdown Row 2: Chamber Advisory
                  _buildDistributionRow(
                    color: const Color(0xFF60A5FA),
                    title: 'Chamber Advisory',
                    subtitle:
                        'Advocate Chambers, Supreme Court Bar Compound',
                    amount: '₹2,500',
                  ),
                  const Divider(color: Color(0xFF262130), height: 22),

                  // Breakdown Row 3: Audio call Consultation
                  _buildDistributionRow(
                    color: const Color(0xFF10B981),
                    title: 'Audio call Consultation',
                    subtitle:
                        'Direct private audio call to your registered mobile number',
                    amount: '₹552',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Card 3: Weekly Fee Volume Flow
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF16131A),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFF28232F)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Weekly Fee Volume Flow',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E2C60),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          '₹38.0k Total',
                          style: TextStyle(
                            color: Color(0xFF819DFF),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Peak intake on Court Hearing days',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 11),
                  ),
                  const SizedBox(height: 20),

                  // Bar Chart
                  SizedBox(
                    height: 120,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildBar(day: 'Mon', heightFraction: 0.35),
                        _buildBar(day: 'Tue', heightFraction: 0.55),
                        _buildBar(day: 'Wed', heightFraction: 0.45),
                        _buildBar(
                            day: 'Thu',
                            heightFraction: 0.95,
                            isPeak: true,
                            amountLabel: '8.8k'),
                        _buildBar(day: 'Fri', heightFraction: 0.75),
                        _buildBar(day: 'Sat', heightFraction: 0.25),
                        _buildBar(day: 'Sun', heightFraction: 0.15),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Trend note
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF141928),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF1F2D4D)),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.trending_up_rounded,
                            color: Color(0xFF819DFF), size: 16),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Thursday & Friday mark peak consultation hours with urgent bench preps yielding highest hourly billables.',
                            style: TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 11,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildDistributionRow({
    required Color color,
    required String title,
    required String subtitle,
    required String amount,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 11,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Text(
          amount,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildBar({
    required String day,
    required double heightFraction,
    bool isPeak = false,
    String? amountLabel,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (amountLabel != null) ...[
          Text(
            amountLabel,
            style: const TextStyle(
              color: Color(0xFF819DFF),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
        ],
        Container(
          width: 28,
          height: 80 * heightFraction,
          decoration: BoxDecoration(
            color: isPeak ? const Color(0xFF4349ED) : const Color(0xFF282E4E),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          day,
          style: TextStyle(
            color: isPeak ? Colors.white : const Color(0xFF64748B),
            fontSize: 11,
            fontWeight: isPeak ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
