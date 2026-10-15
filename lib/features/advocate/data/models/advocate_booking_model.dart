import 'package:equatable/equatable.dart';

enum AdvocateBookingStatus { confirmed, pending, cancelled, ongoing, completed }

enum AdvocateConsultationType { video, audio, office, doorstep }

class AdvocateBookingModel extends Equatable {
  final String id;
  final String bookingNumber;
  final String clientName;
  final String clientInitials;
  final String caseId;
  final String category;
  final AdvocateConsultationType type;
  final AdvocateBookingStatus status;
  final String date;
  final String timeSlot;
  final String timeRemainingText;
  final double fee;
  final bool isPaid;
  final int documentsCount;
  final String? clientNotes;
  final String? cancelReason;
  final String? cancelDate;
  final List<AdvocateBookingTimelineItem> timeline;

  const AdvocateBookingModel({
    required this.id,
    required this.bookingNumber,
    required this.clientName,
    required this.clientInitials,
    required this.caseId,
    required this.category,
    required this.type,
    required this.status,
    required this.date,
    required this.timeSlot,
    required this.timeRemainingText,
    required this.fee,
    this.isPaid = true,
    this.documentsCount = 2,
    this.clientNotes,
    this.cancelReason,
    this.cancelDate,
    required this.timeline,
  });

  static List<AdvocateBookingModel> fixtures() {
    return const [
      AdvocateBookingModel(
        id: 'bk_1',
        bookingNumber: 'BK-12658262',
        clientName: 'Jhon Vick',
        clientInitials: 'PS',
        caseId: '1265-8262',
        category: 'Corporate Law',
        type: AdvocateConsultationType.video,
        status: AdvocateBookingStatus.confirmed,
        date: '16 Sep 2026',
        timeSlot: '10:30 - 10:45 AM (15 mins)',
        timeRemainingText: 'Starts in 45 mins',
        fee: 499.0,
        isPaid: true,
        documentsCount: 2,
        clientNotes:
            'Urgent review of vendor non-compete clause and jurisdictional arbitral venue.',
        timeline: [
          AdvocateBookingTimelineItem(
              title: 'Booking Received', subtitle: 'Today 09:22 AM', isDone: true),
          AdvocateBookingTimelineItem(
              title: 'Booking Confirmed', subtitle: 'Today 10:00 AM', isDone: true),
          AdvocateBookingTimelineItem(
              title: 'Consultation Completed', subtitle: 'Pending', isDone: false),
        ],
      ),
      AdvocateBookingModel(
        id: 'bk_2',
        bookingNumber: 'BK-12858272',
        clientName: 'Alena',
        clientInitials: 'A',
        caseId: '1285-8272',
        category: 'Commercial Contracts',
        type: AdvocateConsultationType.video,
        status: AdvocateBookingStatus.confirmed,
        date: 'Today',
        timeSlot: '11:45 - 12:00 AM (15 mins)',
        timeRemainingText: 'Starts in 1 hrs 30 mins',
        fee: 499.0,
        isPaid: true,
        documentsCount: 1,
        timeline: [
          AdvocateBookingTimelineItem(
              title: 'Booking Received', subtitle: 'Today 10:05 AM', isDone: true),
          AdvocateBookingTimelineItem(
              title: 'Booking Confirmed', subtitle: 'Today 10:45 AM', isDone: true),
          AdvocateBookingTimelineItem(
              title: 'Consultation Completed', subtitle: 'Pending', isDone: false),
        ],
      ),
      AdvocateBookingModel(
        id: 'bk_3',
        bookingNumber: 'BK-12658263',
        clientName: 'Jhon',
        clientInitials: 'PS',
        caseId: '1265-8263',
        category: 'Civil Litigation',
        type: AdvocateConsultationType.video,
        status: AdvocateBookingStatus.pending,
        date: 'Today',
        timeSlot: '10:30 - 10:45 AM (15 mins)',
        timeRemainingText: 'Starts in 45 mins',
        fee: 499.0,
        isPaid: true,
        documentsCount: 2,
        timeline: [
          AdvocateBookingTimelineItem(
              title: 'Booking Received', subtitle: 'Today 09:22 AM', isDone: true),
          AdvocateBookingTimelineItem(
              title: 'Booking Confirmed', subtitle: 'Pending', isDone: false),
          AdvocateBookingTimelineItem(
              title: 'Consultation Completed', subtitle: 'Pending', isDone: false),
        ],
      ),
      AdvocateBookingModel(
        id: 'bk_4',
        bookingNumber: 'BK-12658264',
        clientName: 'Jhon Vick',
        clientInitials: 'PS',
        caseId: '1265-8262',
        category: 'Civil Litigation',
        type: AdvocateConsultationType.video,
        status: AdvocateBookingStatus.cancelled,
        date: 'Today',
        timeSlot: '10:30 - 10:45 AM (15 mins)',
        timeRemainingText: 'Canceled on 15 Sep 2026 by client',
        fee: 499.0,
        isPaid: true,
        cancelReason:
            'Medical contingency. Full statutory refund of ₹499 credited back to bank handle.',
        cancelDate: '15 Sep 2026',
        timeline: [],
      ),
    ];
  }

  @override
  List<Object?> get props => [id, bookingNumber, status, date, timeSlot];
}

class AdvocateBookingTimelineItem extends Equatable {
  final String title;
  final String subtitle;
  final bool isDone;

  const AdvocateBookingTimelineItem({
    required this.title,
    required this.subtitle,
    required this.isDone,
  });

  @override
  List<Object?> get props => [title, subtitle, isDone];
}
