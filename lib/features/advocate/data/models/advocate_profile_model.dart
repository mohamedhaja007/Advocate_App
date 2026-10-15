import 'package:equatable/equatable.dart';

enum AdvocateVerificationStatus { pending, underReview, approved, rejected, suspended }

class AdvocateProfileModel extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String avatarUrl;
  final String barCouncilId;
  final String enrolmentYear;
  final String stateBarCouncil;
  final List<String> barAssociations;
  final String chamberRoom;
  final String courtComplex;
  final String city;
  final String state;
  final String pincode;
  final bool hasExternalOffice;
  final String externalOfficeAddress;
  final List<String> specializations;
  final List<String> courtsOfAppearance;
  final String bio;
  final List<String> languages;
  final double videoFee;
  final double audioFee;
  final double officeFee;
  final int videoDurationMins;
  final int audioDurationMins;
  final int officeDurationMins;
  final String bankAccountHolder;
  final String bankAccountNumberMasked;
  final String ifscCode;
  final String bankName;
  final bool isBankVerified;
  final String sanadFileName;
  final String sanadSignedDate;
  final AdvocateVerificationStatus verificationStatus;
  final double rating;
  final int reviewsCount;
  final int experienceYears;
  final bool isAvailableForConsults;

  const AdvocateProfileModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.barCouncilId,
    required this.enrolmentYear,
    required this.stateBarCouncil,
    required this.barAssociations,
    required this.chamberRoom,
    required this.courtComplex,
    required this.city,
    required this.state,
    required this.pincode,
    required this.hasExternalOffice,
    required this.externalOfficeAddress,
    required this.specializations,
    required this.courtsOfAppearance,
    required this.bio,
    required this.languages,
    required this.videoFee,
    required this.audioFee,
    required this.officeFee,
    this.videoDurationMins = 15,
    this.audioDurationMins = 15,
    this.officeDurationMins = 15,
    required this.bankAccountHolder,
    required this.bankAccountNumberMasked,
    required this.ifscCode,
    required this.bankName,
    this.isBankVerified = true,
    required this.sanadFileName,
    required this.sanadSignedDate,
    this.verificationStatus = AdvocateVerificationStatus.approved,
    this.rating = 4.2,
    this.reviewsCount = 120,
    this.experienceYears = 14,
    this.isAvailableForConsults = true,
  });

  factory AdvocateProfileModel.fixture() {
    return const AdvocateProfileModel(
      id: 'adv_9812',
      fullName: 'Adv. Rajeshwari Sharma',
      email: 'rajeshwari.sharma@advocate.in',
      phone: '+91 98123 45678',
      avatarUrl: 'assets/images/Png/Man.png',
      barCouncilId: 'D/1842/2011',
      enrolmentYear: '2011 (14 yrs)',
      stateBarCouncil: 'Bar Council of Delhi (BCD)',
      barAssociations: [
        'Supreme Court Bar Association (SCBA)',
        'Delhi High Court Bar Association (DHCBA)',
      ],
      chamberRoom: 'Chamber 412, Lawyers Chambers Block',
      courtComplex: 'High Court of Delhi, Sher Shah Road',
      city: 'New Delhi',
      state: 'Delhi',
      pincode: '110503',
      hasExternalOffice: true,
      externalOfficeAddress: '14C Defence Colony, New Delhi - 110024',
      specializations: [
        'Corporate Law',
        'Commercial Contracts',
        'Civil Litigation',
        'Arbitration & Dispute Resolution',
        'Family & Estate Planning',
      ],
      courtsOfAppearance: [
        'Supreme Court of India (SCI)',
        'High Court of Delhi',
        'National Company Law Tribunal (NCLT & NCLAT)',
        'District Courts (Patiala House / Saket / Tis Hazari)',
      ],
      bio:
          'Senior legal counsel with over 14 years of litigation experience in commercial dispute resolution, contractual advisory, and high-stakes arbitration before the High Court of Delhi and Supreme Court.',
      languages: ['English', 'Tamil', 'Hindi'],
      videoFee: 499.0,
      audioFee: 299.0,
      officeFee: 1299.0,
      videoDurationMins: 15,
      audioDurationMins: 15,
      officeDurationMins: 30,
      bankAccountHolder: 'Adv. Rajeshwari Sharma',
      bankAccountNumberMasked: '•••• •••• 9042',
      ifscCode: 'HDFC0001234',
      bankName: 'HDFC Bank Ltd.',
      isBankVerified: true,
      sanadFileName: 'Bar_Council_Sanad_Verif.pdf',
      sanadSignedDate: '12 Aug 2023',
      verificationStatus: AdvocateVerificationStatus.approved,
      rating: 4.2,
      reviewsCount: 120,
      experienceYears: 14,
      isAvailableForConsults: true,
    );
  }

  AdvocateProfileModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    String? avatarUrl,
    String? barCouncilId,
    String? enrolmentYear,
    String? stateBarCouncil,
    List<String>? barAssociations,
    String? chamberRoom,
    String? courtComplex,
    String? city,
    String? state,
    String? pincode,
    bool? hasExternalOffice,
    String? externalOfficeAddress,
    List<String>? specializations,
    List<String>? courtsOfAppearance,
    String? bio,
    List<String>? languages,
    double? videoFee,
    double? audioFee,
    double? officeFee,
    int? videoDurationMins,
    int? audioDurationMins,
    int? officeDurationMins,
    String? bankAccountHolder,
    String? bankAccountNumberMasked,
    String? ifscCode,
    String? bankName,
    bool? isBankVerified,
    String? sanadFileName,
    String? sanadSignedDate,
    AdvocateVerificationStatus? verificationStatus,
    double? rating,
    int? reviewsCount,
    int? experienceYears,
    bool? isAvailableForConsults,
  }) {
    return AdvocateProfileModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      barCouncilId: barCouncilId ?? this.barCouncilId,
      enrolmentYear: enrolmentYear ?? this.enrolmentYear,
      stateBarCouncil: stateBarCouncil ?? this.stateBarCouncil,
      barAssociations: barAssociations ?? this.barAssociations,
      chamberRoom: chamberRoom ?? this.chamberRoom,
      courtComplex: courtComplex ?? this.courtComplex,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
      hasExternalOffice: hasExternalOffice ?? this.hasExternalOffice,
      externalOfficeAddress: externalOfficeAddress ?? this.externalOfficeAddress,
      specializations: specializations ?? this.specializations,
      courtsOfAppearance: courtsOfAppearance ?? this.courtsOfAppearance,
      bio: bio ?? this.bio,
      languages: languages ?? this.languages,
      videoFee: videoFee ?? this.videoFee,
      audioFee: audioFee ?? this.audioFee,
      officeFee: officeFee ?? this.officeFee,
      videoDurationMins: videoDurationMins ?? this.videoDurationMins,
      audioDurationMins: audioDurationMins ?? this.audioDurationMins,
      officeDurationMins: officeDurationMins ?? this.officeDurationMins,
      bankAccountHolder: bankAccountHolder ?? this.bankAccountHolder,
      bankAccountNumberMasked: bankAccountNumberMasked ?? this.bankAccountNumberMasked,
      ifscCode: ifscCode ?? this.ifscCode,
      bankName: bankName ?? this.bankName,
      isBankVerified: isBankVerified ?? this.isBankVerified,
      sanadFileName: sanadFileName ?? this.sanadFileName,
      sanadSignedDate: sanadSignedDate ?? this.sanadSignedDate,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      experienceYears: experienceYears ?? this.experienceYears,
      isAvailableForConsults: isAvailableForConsults ?? this.isAvailableForConsults,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'avatarUrl': avatarUrl,
        'barCouncilId': barCouncilId,
        'enrolmentYear': enrolmentYear,
        'stateBarCouncil': stateBarCouncil,
        'barAssociations': barAssociations,
        'chamberRoom': chamberRoom,
        'courtComplex': courtComplex,
        'city': city,
        'state': state,
        'pincode': pincode,
        'hasExternalOffice': hasExternalOffice,
        'externalOfficeAddress': externalOfficeAddress,
        'specializations': specializations,
        'courtsOfAppearance': courtsOfAppearance,
        'bio': bio,
        'languages': languages,
        'videoFee': videoFee,
        'audioFee': audioFee,
        'officeFee': officeFee,
        'bankAccountHolder': bankAccountHolder,
        'bankAccountNumberMasked': bankAccountNumberMasked,
        'ifscCode': ifscCode,
        'bankName': bankName,
        'verificationStatus': verificationStatus.name,
      };

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        phone,
        barCouncilId,
        stateBarCouncil,
        verificationStatus,
        isAvailableForConsults,
      ];
}
