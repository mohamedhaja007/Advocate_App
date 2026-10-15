import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AdvocateReviewsScreen extends StatefulWidget {
  const AdvocateReviewsScreen({super.key});

  @override
  State<AdvocateReviewsScreen> createState() => _AdvocateReviewsScreenState();
}

class _AdvocateReviewsScreenState extends State<AdvocateReviewsScreen> {
  int _visibleCount = 6;

  final List<Map<String, dynamic>> _reviews = [
    {
      'name': 'Meera Nambiar',
      'category': 'Civil Litigation',
      'rating': 5,
      'time': '1 week ago',
      'comment':
          'Clear legal opinion during the urgent chamber consultation. Cut straight through complex contractual clauses.',
    },
    {
      'name': 'Kunal Singhania',
      'category': 'Commercial Contracts',
      'rating': 5,
      'time': '2 weeks ago',
      'comment':
          'Exceptional guidance on shareholders agreement and indemnity clauses. Highly recommended for startup disputes.',
    },
    {
      'name': 'Pooja Venkatesh',
      'category': 'Arbitration & Dispute',
      'rating': 5,
      'time': '3 weeks ago',
      'comment':
          'Very thorough brief preparation before NCLT hearing. Her composure and clarity in statutory procedures are remarkable.',
    },
    {
      'name': 'Rohit Deshmukh',
      'category': 'Corporate Law',
      'rating': 4,
      'time': '1 month ago',
      'comment':
          'Comprehensive legal review of MSME recovery notice. Punctual video consultation and actionable next steps.',
    },
    {
      'name': 'Ananya Iyer',
      'category': 'Civil Litigation',
      'rating': 5,
      'time': '1 month ago',
      'comment':
          'Drafted an airtight reply notice within 24 hours. Very approachable and transparent with court hearing timings.',
    },
    {
      'name': 'Siddharth Menon',
      'category': 'Family & Estate',
      'rating': 5,
      'time': '2 months ago',
      'comment':
          'Compassionate yet firm legal strategy for succession probate. Provided immense clarity on legal heirship documentation.',
    },
    {
      'name': 'Vikramaditya Roy',
      'category': 'Arbitration & Dispute',
      'rating': 5,
      'time': '2 months ago',
      'comment':
          'Brilliant statutory arguments on limitation act and jurisdictional stay. One of the best counsel at Delhi High Court.',
    },
  ];

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
            'Reviews',
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
            // Rating Overview Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF16131A),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFF28232F)),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left: Rating Score
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '4.2',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: List.generate(
                              5,
                              (index) => const Icon(Icons.star_rounded,
                                  color: Color(0xFFFBBF24), size: 16),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            '120 reviews and\n9 ratings',
                            style: TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 11,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),

                      // Right: Rating Distribution Bars
                      Expanded(
                        child: Column(
                          children: [
                            _buildRatingBar(star: 5, count: 88, max: 100),
                            const SizedBox(height: 4),
                            _buildRatingBar(star: 4, count: 20, max: 100),
                            const SizedBox(height: 4),
                            _buildRatingBar(star: 3, count: 18, max: 100),
                            const SizedBox(height: 4),
                            _buildRatingBar(star: 2, count: 4, max: 100),
                            const SizedBox(height: 4),
                            _buildRatingBar(star: 1, count: 1, max: 100),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Color(0xFF262130), height: 28),

                  // 3 Performance Metric Pills
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMetricCol('100%', 'RECOMMENDED'),
                      Container(
                          width: 1, height: 26, color: const Color(0xFF28232F)),
                      _buildMetricCol('98%', 'CASE CLARITY'),
                      Container(
                          width: 1, height: 26, color: const Color(0xFF28232F)),
                      _buildMetricCol('129', 'CLIENTS'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Review List
            ..._reviews.take(_visibleCount).map((review) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF16131A),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF28232F)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Review Header
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: review['name'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' • ${review['category']}',
                                    style: const TextStyle(
                                      color: Color(0xFF94A3B8),
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                      const SizedBox(height: 6),

                      // Stars & Time
                      Row(
                        children: [
                          Row(
                            children: List.generate(
                              review['rating'] as int,
                              (idx) => const Icon(Icons.star_rounded,
                                  color: Color(0xFFFBBF24), size: 13),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            review['time'],
                            style: const TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Comment
                      Text(
                        review['comment'],
                        style: const TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            // More Button
            if (_visibleCount < _reviews.length)
              Center(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _visibleCount = _reviews.length;
                    });
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'More',
                        style: TextStyle(
                          color: Color(0xFF6B8AFF),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_rounded,
                          color: Color(0xFF6B8AFF), size: 15),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBar({
    required int star,
    required int count,
    required int max,
  }) {
    return Row(
      children: [
        Text(
          '$star★',
          style: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: count / max,
              minHeight: 5,
              backgroundColor: const Color(0xFF28232F),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFFFBBF24)),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 16,
          child: Text(
            '$count',
            textAlign: TextAlign.end,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCol(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF64748B),
            fontSize: 9,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
