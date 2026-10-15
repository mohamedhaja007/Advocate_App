import 'package:equatable/equatable.dart';

class AdvocateEarningsModel extends Equatable {
  final double todayNetRealized;
  final double todayGrowthPercent;
  final double todayGrossTotal;
  final String nextDisbursalTime;
  final double pendingTdsAmount;
  final double totalRetainerFee;
  final double videoEarnings;
  final double chamberEarnings;
  final double audioEarnings;
  final double weeklyTotalVolume;
  final Map<String, double> weeklyBars; // e.g. {'Mon': 3.5, 'Tue': 5.5, ...}
  final double availableWalletBalance;
  final double pendingWalletBalance;

  const AdvocateEarningsModel({
    required this.todayNetRealized,
    required this.todayGrowthPercent,
    required this.todayGrossTotal,
    required this.nextDisbursalTime,
    required this.pendingTdsAmount,
    required this.totalRetainerFee,
    required this.videoEarnings,
    required this.chamberEarnings,
    required this.audioEarnings,
    required this.weeklyTotalVolume,
    required this.weeklyBars,
    this.availableWalletBalance = 42850.0,
    this.pendingWalletBalance = 6789.0,
  });

  factory AdvocateEarningsModel.fixture() {
    return const AdvocateEarningsModel(
      todayNetRealized: 6789.0,
      todayGrowthPercent: 7.4,
      todayGrossTotal: 42850.0,
      nextDisbursalTime: '07:00 PM',
      pendingTdsAmount: 7543.0,
      totalRetainerFee: 42850.0,
      videoEarnings: 4491.0,
      chamberEarnings: 2500.0,
      audioEarnings: 552.0,
      weeklyTotalVolume: 38000.0,
      weeklyBars: {
        'Mon': 0.35,
        'Tue': 0.55,
        'Wed': 0.45,
        'Thu': 0.95,
        'Fri': 0.75,
        'Sat': 0.25,
        'Sun': 0.15,
      },
      availableWalletBalance: 42850.0,
      pendingWalletBalance: 6789.0,
    );
  }

  @override
  List<Object?> get props => [
        todayNetRealized,
        todayGrossTotal,
        pendingTdsAmount,
        availableWalletBalance,
      ];
}

class AdvocateSettlementModel extends Equatable {
  final String id;
  final String title;
  final String badgeText;
  final String utr;
  final String timeText;
  final double amount;
  final bool isDispatched;

  const AdvocateSettlementModel({
    required this.id,
    required this.title,
    required this.badgeText,
    required this.utr,
    required this.timeText,
    required this.amount,
    required this.isDispatched,
  });

  static List<AdvocateSettlementModel> fixtures() {
    return const [
      AdvocateSettlementModel(
        id: 'set_1',
        title: 'Today Payout',
        badgeText: 'Dispatched',
        utr: 'UTR: HDFC89127391',
        timeText: '07:02 PM',
        amount: 6789.0,
        isDispatched: true,
      ),
      AdvocateSettlementModel(
        id: 'set_2',
        title: 'Yesterday Payout',
        badgeText: 'Settled',
        utr: 'UTR: HDFC8901244',
        timeText: 'T+1 Cleared',
        amount: 11250.0,
        isDispatched: false,
      ),
      AdvocateSettlementModel(
        id: 'set_3',
        title: '18 Sep Payout',
        badgeText: 'Settled',
        utr: 'UTR: HDFC87431198',
        timeText: 'T+1 Cleared',
        amount: 8500.0,
        isDispatched: false,
      ),
    ];
  }

  @override
  List<Object?> get props => [id, utr, amount, isDispatched];
}

class AdvocateReviewModel extends Equatable {
  final String id;
  final String clientName;
  final String category;
  final int rating;
  final String timeAgo;
  final String comment;
  final bool isVerified;

  const AdvocateReviewModel({
    required this.id,
    required this.clientName,
    required this.category,
    required this.rating,
    required this.timeAgo,
    required this.comment,
    this.isVerified = true,
  });

  static List<AdvocateReviewModel> fixtures() {
    return const [
      AdvocateReviewModel(
        id: 'rev_1',
        clientName: 'Meera Nambiar',
        category: 'Civil Litigation',
        rating: 5,
        timeAgo: '1 week ago',
        comment:
            'Clear legal opinion during the urgent chamber consultation. Cut straight through complex contractual clauses.',
      ),
      AdvocateReviewModel(
        id: 'rev_2',
        clientName: 'Kunal Singhania',
        category: 'Commercial Contracts',
        rating: 5,
        timeAgo: '2 weeks ago',
        comment:
            'Exceptional guidance on shareholders agreement and indemnity clauses. Highly recommended for startup disputes.',
      ),
      AdvocateReviewModel(
        id: 'rev_3',
        clientName: 'Pooja Venkatesh',
        category: 'Arbitration & Dispute',
        rating: 5,
        timeAgo: '3 weeks ago',
        comment:
            'Very thorough brief preparation before NCLT hearing. Her composure and clarity in statutory procedures are remarkable.',
      ),
      AdvocateReviewModel(
        id: 'rev_4',
        clientName: 'Rohit Deshmukh',
        category: 'Corporate Law',
        rating: 4,
        timeAgo: '1 month ago',
        comment:
            'Comprehensive legal review of MSME recovery notice. Punctual video consultation and actionable next steps.',
      ),
      AdvocateReviewModel(
        id: 'rev_5',
        clientName: 'Ananya Iyer',
        category: 'Civil Litigation',
        rating: 5,
        timeAgo: '1 month ago',
        comment:
            'Drafted an airtight reply notice within 24 hours. Very approachable and transparent with court hearing timings.',
      ),
      AdvocateReviewModel(
        id: 'rev_6',
        clientName: 'Siddharth Menon',
        category: 'Family & Estate',
        rating: 5,
        timeAgo: '2 months ago',
        comment:
            'Compassionate yet firm legal strategy for succession probate. Provided immense clarity on legal heirship documentation.',
      ),
    ];
  }

  @override
  List<Object?> get props => [id, clientName, rating, timeAgo];
}
