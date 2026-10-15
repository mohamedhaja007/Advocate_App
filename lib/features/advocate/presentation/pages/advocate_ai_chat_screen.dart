import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

/// Static model representing an AI message or legal intelligence response
class LegalAiMessage {
  final String text;
  final bool isUser;
  final String? sectionBadge;
  final String? headerTitle;
  final List<LegalPointCard>? points;
  final String? recommendedStep;
  final DateTime timestamp;
  int rating; // 0 = none, 1 = up, -1 = down

  LegalAiMessage({
    required this.text,
    required this.isUser,
    this.sectionBadge,
    this.headerTitle,
    this.points,
    this.recommendedStep,
    DateTime? timestamp,
    this.rating = 0,
  }) : timestamp = timestamp ?? DateTime.now();
}

class LegalPointCard {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;

  const LegalPointCard({
    required this.icon,
    this.iconColor = const Color(0xFFF59E0B),
    required this.title,
    required this.description,
  });
}

class AdvocateAiChatScreen extends StatefulWidget {
  final String? initialPrompt;

  const AdvocateAiChatScreen({
    super.key,
    this.initialPrompt,
  });

  @override
  State<AdvocateAiChatScreen> createState() => _AdvocateAiChatScreenState();
}

class _AdvocateAiChatScreenState extends State<AdvocateAiChatScreen> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<LegalAiMessage> _messages = [];
  bool _isTyping = false;

  final List<String> _presetPrompts = [
    'Help me understand my legal rights',
    'Can my landlord deduct painting charges from my deposit without sharing receipts?',
    'BNS vs IPC Section Mapping',
    'Drafting a Legal Notice for Cheque Bounce',
    'Section 108 Transfer of Property Act',
    'Bail jurisprudence under BNSS 479',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialPrompt != null && widget.initialPrompt!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleSendMessage(widget.initialPrompt!);
      });
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleSendMessage(String text) {
    final query = text.trim();
    if (query.isEmpty) return;

    _inputController.clear();
    setState(() {
      _messages.add(LegalAiMessage(text: query, isUser: true));
      _isTyping = true;
    });
    _scrollToBottom();

    // Simulate AI thinking and generate structured response
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      final aiResponse = _generateLegalResponse(query);
      setState(() {
        _isTyping = false;
        _messages.add(aiResponse);
      });
      _scrollToBottom();
    });
  }

  LegalAiMessage _generateLegalResponse(String query) {
    final lower = query.toLowerCase();

    if (lower.contains('paint') ||
        lower.contains('landlord') ||
        lower.contains('deposit') ||
        lower.contains('tenant') ||
        lower.contains('receipt')) {
      return LegalAiMessage(
        isUser: false,
        headerTitle: 'Nyaya Legal Intelligence',
        sectionBadge: 'Sec 108 TPA',
        text:
            "Under prevailing Indian tenancy jurisprudence and Section 108 of the Transfer of Property Act, standard wear and tear is the owner's statutory maintenance duty. Deductions require proven actual damage and certified GST bills.",
        points: const [
          LegalPointCard(
            icon: Icons.shield_outlined,
            iconColor: Color(0xFF10B981),
            title: 'Normal Wear & Tear Excluded',
            description:
                'Faded paint from routine usage cannot be charged back to the tenant.',
          ),
          LegalPointCard(
            icon: Icons.description_outlined,
            iconColor: Color(0xFFF59E0B),
            title: 'Statutory Right to Invoices',
            description:
                'The lessor must produce legitimate, itemized work receipts to justify withholding.',
          ),
          LegalPointCard(
            icon: Icons.gavel_rounded,
            iconColor: Color(0xFF6366F1),
            title: '30–Day Mandatory Settlement',
            description:
                'Model Tenancy norms prescribe full refund upon vacant possession, plus interest if delayed.',
          ),
        ],
        recommendedStep: 'Draft Legal Demand Notice',
      );
    } else if (lower.contains('bns') ||
        lower.contains('ipc') ||
        lower.contains('mapping') ||
        lower.contains('penal')) {
      return LegalAiMessage(
        isUser: false,
        headerTitle: 'Nyaya Criminal Law Intelligence',
        sectionBadge: 'BNS 2023',
        text:
            'Bharatiya Nyaya Sanhita (BNS) 2023 replaces the Indian Penal Code (IPC) with consolidated numbering and modernized offenses:',
        points: const [
          LegalPointCard(
            icon: Icons.balance_rounded,
            iconColor: Color(0xFFEF4444),
            title: 'Section 103 BNS (Old IPC 302)',
            description:
                'Punishment for murder. Retains capital punishment or life imprisonment, adds sub-clause (2) for mob lynching.',
          ),
          LegalPointCard(
            icon: Icons.security_rounded,
            iconColor: Color(0xFF3B82F6),
            title: 'Section 111 BNS (Organized Crime)',
            description:
                'New statutory definition for organized crime syndicate activities, extortion, contract killing, and cybercrime.',
          ),
          LegalPointCard(
            icon: Icons.description_outlined,
            iconColor: Color(0xFF10B981),
            title: 'Section 316 / 318 BNS (Cheating & Fraud)',
            description:
                'Corresponds to old IPC 415 & 420; streamlined penalties for criminal breach of trust and financial fraud.',
          ),
        ],
        recommendedStep: 'View Full Concordance Table',
      );
    } else if (lower.contains('cheque') ||
        lower.contains('bounce') ||
        lower.contains('138') ||
        lower.contains('negotiable')) {
      return LegalAiMessage(
        isUser: false,
        headerTitle: 'Nyaya Commercial Intelligence',
        sectionBadge: 'Sec 138 NI Act',
        text:
            'A complaint under Section 138 of the Negotiable Instruments Act mandates strict compliance with statutory timeframes:',
        points: const [
          LegalPointCard(
            icon: Icons.timer_outlined,
            iconColor: Color(0xFFF59E0B),
            title: '30-Day Statutory Notice Period',
            description:
                'Legal demand notice must be dispatched within 30 days of receiving the bank memo of dishonour.',
          ),
          LegalPointCard(
            icon: Icons.mail_outline_rounded,
            iconColor: Color(0xFF3B82F6),
            title: '15-Day Opportunity to Pay',
            description:
                'The drawer has 15 statutory days from notice delivery to settle before cause of action arises.',
          ),
          LegalPointCard(
            icon: Icons.gavel_rounded,
            iconColor: Color(0xFF10B981),
            title: 'Limitation for Filing Complaint',
            description:
                'Private criminal complaint must be instituted before the Judicial Magistrate within 30 days thereafter.',
          ),
        ],
        recommendedStep: 'Generate 138 Legal Notice',
      );
    } else if (lower.contains('bail') ||
        lower.contains('bnss') ||
        lower.contains('479') ||
        lower.contains('undertrial')) {
      return LegalAiMessage(
        isUser: false,
        headerTitle: 'Nyaya Criminal Procedure',
        sectionBadge: 'Sec 479 BNSS',
        text:
            'Section 479 of Bharatiya Nagarik Suraksha Sanhita (BNSS) reformulates undertrial detention relief:',
        points: const [
          LegalPointCard(
            icon: Icons.lock_open_rounded,
            iconColor: Color(0xFF10B981),
            title: 'First-Time Offender Relief',
            description:
                'Accused who have never been convicted are eligible for mandatory bail upon completing 1/3rd of the maximum sentence.',
          ),
          LegalPointCard(
            icon: Icons.timer_rounded,
            iconColor: Color(0xFF3B82F6),
            title: 'Half-Term Release Provision',
            description:
                'Other undertrials must be released on bond upon completing 1/2 of the maximum imprisonment term.',
          ),
          LegalPointCard(
            icon: Icons.rule_folder_rounded,
            iconColor: Color(0xFFF59E0B),
            title: 'Jail Superintendent Obligation',
            description:
                'Mandates proactive application by prison authorities to the court upon qualification by the undertrial.',
          ),
        ],
        recommendedStep: 'Draft BNSS 479 Bail Application',
      );
    } else {
      return LegalAiMessage(
        isUser: false,
        headerTitle: 'Nyaya Legal Intelligence',
        sectionBadge: 'Indian Jurisprudence',
        text:
            "Based on established Indian legal frameworks, the matter involves actionable statutory remedies under civil and constitutional jurisprudence:",
        points: [
          LegalPointCard(
            icon: Icons.verified_user_outlined,
            iconColor: const Color(0xFF10B981),
            title: 'Statutory Remedy & Cause of Action',
            description:
                'Right to enforce legal safeguards under corresponding Indian acts and judicial precedents.',
          ),
          LegalPointCard(
            icon: Icons.article_outlined,
            iconColor: const Color(0xFF3B82F6),
            title: 'Evidentiary Pre-Requisites',
            description:
                'Requires documented notices, contemporaneous records, and verified transactional trail.',
          ),
          LegalPointCard(
            icon: Icons.gavel_rounded,
            iconColor: const Color(0xFFF59E0B),
            title: 'Court Procedure & Limitation',
            description:
                'Subject to applicable Limitation Act provisions and designated trial court jurisdiction.',
          ),
        ],
        recommendedStep: 'Research Precedents & Citations',
      );
    }
  }

  void _onCopy(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied legal intelligence to clipboard!'),
        backgroundColor: Color(0xFF16805B),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _onShare(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sharing legal analysis...'),
        backgroundColor: Color(0xFF5244E9),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _clearChat() {
    setState(() {
      _messages.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Chat history cleared'),
        duration: Duration(seconds: 1),
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
              // 1. Header Bar
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => context.pop(),
                      borderRadius: BorderRadius.circular(22),
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B1720),
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF28232F)),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Text(
                      'Ai Chat',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    // History / Clear icon button
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: const Color(0xFF16131A),
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (ctx) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 40,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF332B3D),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Legal AI Assistant Options',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ListTile(
                                  leading: const Icon(Icons.refresh_rounded,
                                      color: Color(0xFF819DFF)),
                                  title: const Text(
                                    'Start New Session',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onTap: () {
                                    Navigator.pop(ctx);
                                    _clearChat();
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.history_rounded,
                                      color: Color(0xFF819DFF)),
                                  title: const Text(
                                    'Previous Research Sessions',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: const Text(
                                    '4 active legal queries saved',
                                    style: TextStyle(color: Color(0xFF64748B)),
                                  ),
                                  onTap: () {
                                    Navigator.pop(ctx);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(22),
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B1720),
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF28232F)),
                        ),
                        child: const Icon(
                          Icons.history_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Chat Conversation or Welcome State
              Expanded(
                child: _messages.isEmpty
                    ? _buildWelcomeState()
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        itemCount: _messages.length + (_isTyping ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == _messages.length && _isTyping) {
                            return _buildTypingIndicator();
                          }
                          final msg = _messages[index];
                          return msg.isUser
                              ? _buildUserBubble(msg.text)
                              : _buildAiResponseCard(msg);
                        },
                      ),
              ),

              // 3. Bottom Input Bar
              _buildBottomInputBar(),
            ],
          ),
        ),
      ),
    );
  }

  // Welcome State matching the reference image
  Widget _buildWelcomeState() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hi Adv. Rajesh !',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'How can I help you today?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Get quick guidance on Indian legal matters, research case laws, explore statutory rights, or draft legal notices.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 13,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 28),

            // Prompt Pills
            Wrap(
              spacing: 10,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: _presetPrompts.map((prompt) {
                return InkWell(
                  onTap: () => _handleSendMessage(prompt),
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B1720),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFF2E2938)),
                    ),
                    child: Text(
                      prompt,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // User Query Bubble (Dark navy rounded pill)
  Widget _buildUserBubble(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.82,
        ),
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: const BoxDecoration(
          color: Color(0xFF0F213A),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(6),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            height: 1.4,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // AI Response Card matching reference design with badges, cards & actions
  Widget _buildAiResponseCard(LegalAiMessage msg) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Badge Row: "Nyaya Legal Intelligence [Sec 108 TPA]"
          Row(
            children: [
              Text(
                msg.headerTitle ?? 'Nyaya Legal Intelligence',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (msg.sectionBadge != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    msg.sectionBadge!,
                    style: const TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),

          // Main response paragraph
          Text(
            msg.text,
            style: const TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 14,
              height: 1.5,
            ),
          ),

          // Structured Point Cards (if provided)
          if (msg.points != null && msg.points!.isNotEmpty) ...[
            const SizedBox(height: 14),
            ...msg.points!.map((point) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF16131A),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF28232F)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(point.icon, color: point.iconColor, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            point.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            point.description,
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
              );
            }),
          ],

          // Recommended Next Steps Pill
          if (msg.recommendedStep != null) ...[
            const SizedBox(height: 12),
            const Text(
              'RECOMMENDED NEXT STEPS',
              style: TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Opening: ${msg.recommendedStep}'),
                    backgroundColor: const Color(0xFF5244E9),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.description_outlined,
                      color: Color(0xFF5244E9),
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      msg.recommendedStep!,
                      style: const TextStyle(
                        color: Color(0xFF5244E9),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          // Feedback & Action Bar: Copy, Share, Thumbs up, Thumbs down
          const SizedBox(height: 16),
          Row(
            children: [
              IconButton(
                onPressed: () => _onCopy(msg.text),
                icon: const Icon(Icons.copy_rounded,
                    color: Color(0xFF94A3B8), size: 18),
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.only(right: 14),
                tooltip: 'Copy',
              ),
              IconButton(
                onPressed: () => _onShare(msg.text),
                icon: const Icon(Icons.share_outlined,
                    color: Color(0xFF94A3B8), size: 18),
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.only(right: 14),
                tooltip: 'Share',
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  setState(() {
                    msg.rating = (msg.rating == 1) ? 0 : 1;
                  });
                },
                icon: Icon(
                  msg.rating == 1
                      ? Icons.thumb_up_rounded
                      : Icons.thumb_up_outlined,
                  color: msg.rating == 1
                      ? const Color(0xFF5244E9)
                      : const Color(0xFF94A3B8),
                  size: 18,
                ),
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.only(right: 12),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    msg.rating = (msg.rating == -1) ? 0 : -1;
                  });
                },
                icon: Icon(
                  msg.rating == -1
                      ? Icons.thumb_down_rounded
                      : Icons.thumb_down_outlined,
                  color: msg.rating == -1
                      ? Colors.redAccent
                      : const Color(0xFF94A3B8),
                  size: 18,
                ),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(color: Color(0xFF201B26), height: 1),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF16131A),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF28232F)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF819DFF)),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Nyaya AI is researching Indian jurisprudence...',
                  style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Bottom Input Bar Container
  Widget _buildBottomInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF141118),
        border: Border(top: BorderSide(color: Color(0xFF231F2A))),
      ),
      child: Row(
        children: [
          // Text Input Pill with + and scanner icons
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF1B1720),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: const Color(0xFF2E2938)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Document attachment selected'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add_rounded,
                        color: Color(0xFF94A3B8), size: 22),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      decoration: const InputDecoration(
                        hintText: 'Ask any Indian legal issue, act, or citation...',
                        hintStyle: TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 12,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onSubmitted: _handleSendMessage,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Legal Document Scanner active'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    icon: const Icon(Icons.crop_free_rounded,
                        color: Color(0xFF94A3B8), size: 20),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Circular Action Button: Mic or Send
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _inputController,
            builder: (context, value, _) {
              final hasText = value.text.trim().isNotEmpty;
              return InkWell(
                onTap: () {
                  if (hasText) {
                    _handleSendMessage(_inputController.text);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Voice input listening...'),
                        backgroundColor: Color(0xFF5244E9),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: hasText ? const Color(0xFF5244E9) : Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      hasText ? Icons.send_rounded : Icons.mic_none_rounded,
                      color: hasText ? Colors.white : const Color(0xFF0F172A),
                      size: 22,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
