import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AdvocateWalletScreen extends StatefulWidget {
  const AdvocateWalletScreen({super.key});

  @override
  State<AdvocateWalletScreen> createState() => _AdvocateWalletScreenState();
}

class _AdvocateWalletScreenState extends State<AdvocateWalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final double _availableBalance = 6789.0;
  final double _pendingBalance = 1998.0;
  final double _totalEarned = 142500.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showWithdrawalModal() {
    final amountController = TextEditingController(text: '5000');
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1B1720),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.account_balance_wallet_rounded,
                    color: Color(0xFF819DFF), size: 22),
                const SizedBox(width: 10),
                const Text(
                  'Request Withdrawal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, color: Color(0xFF94A3B8)),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Available for immediate transfer: ₹${_availableBalance.toStringAsFixed(0)}',
              style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
            ),
            const SizedBox(height: 18),
            // Amount Input
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                prefixText: '₹ ',
                prefixStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
                filled: true,
                fillColor: const Color(0xFF28232F),
                hintText: 'Enter amount',
                hintStyle:
                    const TextStyle(color: Color(0xFF64748B), fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Color(0xFF3B3346)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Destination Bank Account
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF28232F),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFF3B3346)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.account_balance_rounded,
                      color: Color(0xFF819DFF), size: 20),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'HDFC Bank •••• 9812',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'IFSC: HDFC0001234 • Penny Drop Verified',
                        style:
                            TextStyle(color: Color(0xFF10B981), fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  final entered = double.tryParse(amountController.text) ?? 0.0;
                  if (entered <= 0 || entered > _availableBalance) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Please enter a valid amount within available balance.'),
                        backgroundColor: Color(0xFFEF4444),
                      ),
                    );
                    return;
                  }
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Withdrawal request for ₹${entered.toStringAsFixed(0)} initiated via nodal IMPS.'),
                      backgroundColor: const Color(0xFF16805B),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4349ED),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('Confirm IMPS Withdrawal',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
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
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.white, size: 20),
                      onPressed: () => context.pop(),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Earnings & Wallet',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.receipt_long_rounded,
                          color: Color(0xFF819DFF), size: 22),
                      tooltip: 'Fee Summary & Tax Flow',
                      onPressed: () => context.push('/advocate/fees-summary'),
                    ),
                  ],
                ),
              ),

              // Wallet Overview Banner
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2854F5), Color(0xFF3F37C9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2854F5).withValues(alpha: 0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Available Balance',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.shield_rounded,
                                  color: Colors.white, size: 12),
                              SizedBox(width: 4),
                              Text(
                                'Nodal Escrow',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '₹${_availableBalance.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pending Clearing',
                              style: TextStyle(
                                  color: Colors.white60, fontSize: 11),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '₹${_pendingBalance.toStringAsFixed(0)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total Lifetime Earned',
                              style: TextStyle(
                                  color: Colors.white60, fontSize: 11),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '₹${_totalEarned.toStringAsFixed(0)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        ElevatedButton.icon(
                          onPressed: _showWithdrawalModal,
                          icon: const Icon(Icons.arrow_upward_rounded,
                              size: 16, color: Color(0xFF2854F5)),
                          label: const Text(
                            'Withdraw',
                            style: TextStyle(
                                color: Color(0xFF2854F5),
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Linked Bank Account Snapshot Card
              InkWell(
                onTap: () => context.push('/advocate/bank-details'),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B1720),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF28232F)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.account_balance_rounded,
                          color: Color(0xFF819DFF), size: 20),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'HDFC Bank •••• 9812',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Chamber Retainer Account • Verified',
                            style: TextStyle(
                              color: Color(0xFF10B981),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_rounded,
                          color: Color(0xFF94A3B8), size: 14),
                    ],
                  ),
                ),
              ),

              // Tabs: Consultation Settlements / Withdrawal History
              TabBar(
                controller: _tabController,
                indicatorColor: const Color(0xFF4349ED),
                indicatorWeight: 3,
                labelColor: Colors.white,
                unselectedLabelColor: const Color(0xFF94A3B8),
                tabs: const [
                  Tab(text: 'Consultation Fees'),
                  Tab(text: 'Withdrawals'),
                ],
              ),

              // Tab View Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Consultation Fees List
                    ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      children: [
                        _buildFeeItem(
                          clientName: 'Jhon Vick',
                          caseId: '#1265-8262',
                          type: 'Video Consultation',
                          date: 'Today, 10:45 AM',
                          amount: '+ ₹499',
                          isCredit: true,
                          status: 'Settled',
                        ),
                        _buildFeeItem(
                          clientName: 'Alena Rao',
                          caseId: '#1285-8272',
                          type: 'Phone Consultation',
                          date: 'Today, 11:45 AM',
                          amount: '+ ₹299',
                          isCredit: true,
                          status: 'Settled',
                        ),
                        _buildFeeItem(
                          clientName: 'Rajesh Mehra',
                          caseId: '#1265-9014',
                          type: 'Doorstep Consultation',
                          date: 'Yesterday, 04:30 PM',
                          amount: '+ ₹1,499',
                          isCredit: true,
                          status: 'Settled',
                        ),
                        _buildFeeItem(
                          clientName: 'Deepak Verma',
                          caseId: '#1299-4412',
                          type: 'Corporate Retainer Fee',
                          date: '10 Oct 2026',
                          amount: '+ ₹4,500',
                          isCredit: true,
                          status: 'Settled',
                        ),
                      ],
                    ),

                    // Withdrawal History List
                    ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      children: [
                        _buildWithdrawalItem(
                          refId: 'WTH-98214-HDFC',
                          account: 'HDFC Bank •••• 9812',
                          date: '08 Oct 2026, 06:12 PM',
                          amount: '₹12,500',
                          status: 'Processed',
                        ),
                        _buildWithdrawalItem(
                          refId: 'WTH-97011-HDFC',
                          account: 'HDFC Bank •••• 9812',
                          date: '01 Oct 2026, 11:20 AM',
                          amount: '₹25,000',
                          status: 'Processed',
                        ),
                        _buildWithdrawalItem(
                          refId: 'WTH-95880-HDFC',
                          account: 'HDFC Bank •••• 9812',
                          date: '24 Sep 2026, 05:40 PM',
                          amount: '₹8,900',
                          status: 'Processed',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeeItem({
    required String clientName,
    required String caseId,
    required String type,
    required String date,
    required String amount,
    required bool isCredit,
    required String status,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1720),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF28232F)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF16805B).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_downward_rounded,
                color: Color(0xFF10B981), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$clientName ($caseId)',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  '$type • $date',
                  style:
                      const TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  color: Color(0xFF10B981),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                status,
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWithdrawalItem({
    required String refId,
    required String account,
    required String date,
    required String amount,
    required String status,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1720),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF28232F)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF4349ED).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.north_east_rounded,
                color: Color(0xFF819DFF), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  refId,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  '$account • $date',
                  style:
                      const TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF16805B).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Color(0xFF10B981),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
