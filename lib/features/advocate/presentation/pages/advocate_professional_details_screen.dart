import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AdvocateProfessionalDetailsScreen extends StatefulWidget {
  const AdvocateProfessionalDetailsScreen({super.key});

  @override
  State<AdvocateProfessionalDetailsScreen> createState() =>
      _AdvocateProfessionalDetailsScreenState();
}

class _AdvocateProfessionalDetailsScreenState
    extends State<AdvocateProfessionalDetailsScreen> {
  // Bar Council Credentials
  final TextEditingController _legalNameController =
      TextEditingController(text: 'Adv. Rajeshwari Sharma');
  final TextEditingController _enrolmentNoController =
      TextEditingController(text: 'D/1842/2011');
  String _enrolmentYear = '2011 (14 yrs)';
  String _selectedStateBarCouncil = 'Bar Council of Delhi (BCD)';

  final List<String> _barAssociations = [
    'Supreme Court Bar Association (SCBA)',
    'Delhi High Court Bar Association (DHCBA)',
  ];

  // Chamber & Chambers Block
  final TextEditingController _chamberRoomController =
      TextEditingController(text: 'Chamber 412, Lawyers Chambers Block');
  final TextEditingController _courtComplexController =
      TextEditingController(text: 'High Court of Delhi, Sher Shah Road');
  final TextEditingController _cityController =
      TextEditingController(text: 'New Delhi');
  final TextEditingController _pincodeController =
      TextEditingController(text: '110503');
  bool _externalOfficeEnabled = true;
  final TextEditingController _externalOfficeAddressController =
      TextEditingController(
          text: '14C Defence Colony, New Delhi - 110024');

  // Practice Specializations
  final List<String> _specializations = [
    'Corporate Law',
    'Commercial Contracts',
    'Civil Litigation',
    'Arbitration & Dispute Resolution',
    'Family & Estate Planning',
  ];

  // Courts of Appearance
  final Map<String, bool> _courtsOfAppearance = {
    'Supreme Court of India (SCI)': true,
    'High Court of Delhi': true,
    'National Company Law Tribunal (NCLT & NCLAT)': true,
    'District Courts (Patiala House / Saket / Tis Hazari)': true,
  };

  // Executive Bio & Summary
  final TextEditingController _bioController = TextEditingController(
    text:
        'Senior legal counsel with over 14 years of litigation experience in commercial dispute resolution, contractual advisory, and high-stakes arbitration before the High Court of Delhi and...',
  );

  // Pleading Languages
  final List<String> _pleadingLanguages = ['English', 'Tamil', 'Hindi'];

  @override
  void dispose() {
    _legalNameController.dispose();
    _enrolmentNoController.dispose();
    _chamberRoomController.dispose();
    _courtComplexController.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    _externalOfficeAddressController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _addAssociation() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1B1720),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Add Bar Association',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'e.g. Madras High Court Advocates Association (MHAA)',
            hintStyle: TextStyle(color: Color(0xFF64748B), fontSize: 13),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF334155)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF4349ED)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF94A3B8))),
          ),
          ElevatedButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                setState(() => _barAssociations.add(text));
              }
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4349ED),
              foregroundColor: Colors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _addSpecialization() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1B1720),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Add Practice Specialization',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'e.g. Intellectual Property Rights (IPR)',
            hintStyle: TextStyle(color: Color(0xFF64748B), fontSize: 13),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF334155)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF4349ED)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF94A3B8))),
          ),
          ElevatedButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                setState(() => _specializations.add(text));
              }
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4349ED),
              foregroundColor: Colors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _addLanguage() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1B1720),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Add Pleading Language',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'e.g. Malayalam, Kannada, Telugu',
            hintStyle: TextStyle(color: Color(0xFF64748B), fontSize: 13),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF334155)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF4349ED)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF94A3B8))),
          ),
          ElevatedButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                setState(() => _pleadingLanguages.add(text));
              }
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4349ED),
              foregroundColor: Colors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _onSaveChanges() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Professional details updated successfully!'),
        backgroundColor: Color(0xFF16805B),
      ),
    );
    context.pop();
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
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Professional details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Advocate Practice Profile & Jurisdiction',
                style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Opening Public Practice Desk Preview...'),
                        backgroundColor: Color(0xFF4349ED),
                      ),
                    );
                  },
                  child: const Text(
                    'Preview',
                    style: TextStyle(
                      color: Color(0xFF6B8AFF),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: [
            // Bar Council Certified Banner
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF161E2E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF233554)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E2D4A),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.verified_user_rounded,
                        color: Color(0xFF10B981), size: 20),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bar Council Certified ✓',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Annual verification active • Renewal due 2026',
                          style: TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF142D23),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      '100% Complete',
                      style: TextStyle(
                        color: Color(0xFF10B981),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // SECTION 1: BAR COUNCIL CREDENTIALS
            _buildSectionCard(
              icon: Icons.badge_outlined,
              title: 'Bar Council Credentials',
              trailingBadge: 'Verified',
              trailingBadgeColor: const Color(0xFF10B981),
              trailingBadgeBg: const Color(0xFF142D23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFieldLabel('Registered Full Legal Name'),
                  _buildInputField(
                    controller: _legalNameController,
                    hint: 'Full Legal Name',
                    suffixIcon: const Icon(Icons.lock_outline_rounded,
                        color: Color(0xFF64748B), size: 16),
                    readOnly: true,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Matches official Bar Council Enrollment Sanad ledger.',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 11),
                  ),
                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Enrolment No.'),
                            _buildInputField(
                              controller: _enrolmentNoController,
                              hint: 'D/1842/2011',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Enrolment Year'),
                            _buildDropdownField(
                              value: _enrolmentYear,
                              items: [
                                '2011 (14 yrs)',
                                '2012 (13 yrs)',
                                '2013 (12 yrs)',
                                '2014 (11 yrs)',
                              ],
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() => _enrolmentYear = val);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  _buildFieldLabel('State Bar Council'),
                  _buildDropdownField(
                    value: _selectedStateBarCouncil,
                    items: [
                      'Bar Council of Delhi (BCD)',
                      'Bar Council of Tamil Nadu & Puducherry',
                      'Bar Council of Maharashtra & Goa',
                      'Bar Council of Karnataka',
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedStateBarCouncil = val);
                      }
                    },
                  ),
                  const SizedBox(height: 14),

                  _buildFieldLabel('Bar Association Memberships'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _barAssociations.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final item = entry.value;
                      return Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 6, top: 6, bottom: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B1720),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFF28232F)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                item,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () {
                                setState(() => _barAssociations.removeAt(idx));
                              },
                              child: const Icon(Icons.close,
                                  size: 14, color: Color(0xFF94A3B8)),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: _addAssociation,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E2742),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, size: 14, color: Color(0xFF6B8AFF)),
                          SizedBox(width: 6),
                          Text(
                            '+ Add Association',
                            style: TextStyle(
                              color: Color(0xFF6B8AFF),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // SECTION 2: CHAMBER & CHAMBERS BLOCK
            _buildSectionCard(
              icon: Icons.account_balance_outlined,
              title: 'Chamber & Chambers Block',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFieldLabel('Chamber Number / Room'),
                  _buildInputField(
                    controller: _chamberRoomController,
                    hint: 'Chamber Room',
                  ),
                  const SizedBox(height: 12),

                  _buildFieldLabel('Court Complex / Attached Court'),
                  _buildInputField(
                    controller: _courtComplexController,
                    hint: 'Court Complex',
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('City & State'),
                            _buildInputField(
                              controller: _cityController,
                              hint: 'City',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Pincode'),
                            _buildInputField(
                              controller: _pincodeController,
                              hint: '110001',
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // External Consultation Office
                  Row(
                    children: [
                      Checkbox(
                        value: _externalOfficeEnabled,
                        activeColor: const Color(0xFF4349ED),
                        checkColor: Colors.white,
                        onChanged: (val) =>
                            setState(() => _externalOfficeEnabled = val ?? true),
                      ),
                      const Text(
                        'External Consultation Office',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  if (_externalOfficeEnabled) ...[
                    _buildInputField(
                      controller: _externalOfficeAddressController,
                      hint: 'Office Address',
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Available for after-hours client advisory and video mediation.',
                      style: TextStyle(color: Color(0xFF64748B), fontSize: 11),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 18),

            // SECTION 3: PRACTICE SPECIALIZATIONS
            _buildSectionCard(
              icon: Icons.workspace_premium_outlined,
              title: 'Practice Specializations',
              trailingBadge: '${_specializations.length} Selected',
              trailingBadgeColor: const Color(0xFF6B8AFF),
              trailingBadgeBg: const Color(0xFF1E2C60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Clients and corporate counsel discover your profile matching these validated niches.',
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _specializations.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final item = entry.value;
                      return Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 6, top: 6, bottom: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B1720),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFF28232F)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                setState(() => _specializations.removeAt(idx));
                              },
                              child: const Icon(Icons.close,
                                  size: 14, color: Color(0xFF94A3B8)),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: _addSpecialization,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E2742),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, size: 14, color: Color(0xFF6B8AFF)),
                          SizedBox(width: 6),
                          Text(
                            '+ Add Practice Area',
                            style: TextStyle(
                              color: Color(0xFF6B8AFF),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // SECTION 4: COURTS OF APPEARANCE
            _buildSectionCard(
              icon: Icons.gavel_rounded,
              title: 'Courts of Appearance',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select forums where you regularly maintain appearance and file Vakalatnamas.',
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  ..._courtsOfAppearance.keys.map((court) {
                    final isChecked = _courtsOfAppearance[court] ?? false;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _courtsOfAppearance[court] = !isChecked;
                          });
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B1720),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isChecked
                                  ? const Color(0xFF4349ED)
                                  : const Color(0xFF28232F),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.account_balance_rounded,
                                  color: Color(0xFF819DFF), size: 16),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  court,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Checkbox(
                                value: isChecked,
                                activeColor: const Color(0xFF4349ED),
                                onChanged: (v) {
                                  setState(() {
                                    _courtsOfAppearance[court] = v ?? false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // SECTION 5: EXECUTIVE BIO & SUMMARY
            _buildSectionCard(
              icon: Icons.notes_rounded,
              title: 'Executive Bio & Summary',
              trailingBadge: '${_bioController.text.length} / 500',
              trailingBadgeColor: const Color(0xFF94A3B8),
              trailingBadgeBg: const Color(0xFF28232F),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B1720),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF28232F)),
                    ),
                    child: TextField(
                      controller: _bioController,
                      maxLines: 4,
                      maxLength: 500,
                      onChanged: (text) => setState(() {}),
                      style: const TextStyle(
                          color: Colors.white, fontSize: 13, height: 1.4),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                        hintText: 'Enter executive practice summary...',
                        hintStyle: TextStyle(
                            color: Color(0xFF64748B), fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Rendered on official consultation booking briefs.',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 11),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // SECTION 6: PLEADING LANGUAGES
            _buildSectionCard(
              icon: Icons.translate_rounded,
              title: 'Pleading Languages',
              trailingBadge: '${_pleadingLanguages.length} Selected',
              trailingBadgeColor: const Color(0xFF6B8AFF),
              trailingBadgeBg: const Color(0xFF1E2C60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _pleadingLanguages.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final item = entry.value;
                      return Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 6, top: 6, bottom: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B1720),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFF28232F)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                setState(
                                    () => _pleadingLanguages.removeAt(idx));
                              },
                              child: const Icon(Icons.close,
                                  size: 14, color: Color(0xFF94A3B8)),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: _addLanguage,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E2742),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, size: 14, color: Color(0xFF6B8AFF)),
                          SizedBox(width: 6),
                          Text(
                            '+ Add Language',
                            style: TextStyle(
                              color: Color(0xFF6B8AFF),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // SECTION 7: SANAD VERIFICATION FILE
            _buildSectionCard(
              icon: Icons.description_outlined,
              title: 'Sanad Verification File',
              trailingBadge: 'Signed',
              trailingBadgeColor: const Color(0xFF10B981),
              trailingBadgeBg: const Color(0xFF142D23),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B1720),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF28232F)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.picture_as_pdf_rounded,
                            color: Color(0xFF819DFF), size: 24),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bar_Council_Sanad_Verif',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                '2.4 MB • Signed 12 Aug 2023',
                                style: TextStyle(
                                    color: Color(0xFF64748B), fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.visibility_outlined,
                              color: Color(0xFF819DFF), size: 20),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Opening Sanad Certificate PDF...'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Select new Bar Council Sanad PDF to replace...'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.file_upload_outlined,
                          size: 16, color: Color(0xFF819DFF)),
                      label: const Text(
                        'Replace Credential Certificate',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF819DFF)),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF293B6E)),
                        backgroundColor: const Color(0xFF161F36),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Bottom Actions Bar (Discard & Save Changes)
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFF332F3D)),
                      backgroundColor: const Color(0xFF1E1A24),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Discard Changes',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _onSaveChanges,
                    icon: const Icon(Icons.check_circle_outline, size: 18),
                    label: const Text('Save Changes',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4349ED),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    String? trailingBadge,
    Color? trailingBadgeColor,
    Color? trailingBadgeBg,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
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
              Icon(icon, color: const Color(0xFF6B8AFF), size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (trailingBadge != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: trailingBadgeBg ?? const Color(0xFF1B1720),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    trailingBadge,
                    style: TextStyle(
                      color: trailingBadgeColor ?? const Color(0xFF94A3B8),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF94A3B8),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    Widget? suffixIcon,
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1720),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF28232F)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              keyboardType: keyboardType,
              style: const TextStyle(color: Colors.white, fontSize: 13),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle:
                    const TextStyle(color: Color(0xFF64748B), fontSize: 13),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          ?suffixIcon,
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1720),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF28232F)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value) ? value : items.first,
          dropdownColor: const Color(0xFF1B1720),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: Color(0xFF94A3B8), size: 18),
          style: const TextStyle(color: Colors.white, fontSize: 13),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
