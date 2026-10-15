import 'package:equatable/equatable.dart';

enum AdvocateSlotStatus { available, booked, blocked }

class AdvocateSlotModel extends Equatable {
  final String id;
  final String startTime;
  final String endTime;
  final String durationText;
  final AdvocateSlotStatus status;
  final String period; // Morning, Afternoon, Evening
  final int dayOfMonth;

  const AdvocateSlotModel({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.durationText,
    required this.status,
    required this.period,
    this.dayOfMonth = 21,
  });

  static List<AdvocateSlotModel> fixtures() {
    return const [
      // Morning
      AdvocateSlotModel(
        id: 'm1',
        startTime: '09:30 AM',
        endTime: '09:45 AM',
        durationText: '15 mins',
        status: AdvocateSlotStatus.booked,
        period: 'Morning',
      ),
      AdvocateSlotModel(
        id: 'm2',
        startTime: '10:30 AM',
        endTime: '11:15 AM',
        durationText: '30 mins',
        status: AdvocateSlotStatus.available,
        period: 'Morning',
      ),
      AdvocateSlotModel(
        id: 'm3',
        startTime: '11:15 AM',
        endTime: '11:45 AM',
        durationText: '30 mins',
        status: AdvocateSlotStatus.available,
        period: 'Morning',
      ),
      AdvocateSlotModel(
        id: 'm4',
        startTime: '11:45 AM',
        endTime: '12:00 PM',
        durationText: '15 mins',
        status: AdvocateSlotStatus.available,
        period: 'Morning',
      ),
      // Afternoon
      AdvocateSlotModel(
        id: 'a1',
        startTime: '04:00 PM',
        endTime: '04:15 PM',
        durationText: '15 mins',
        status: AdvocateSlotStatus.available,
        period: 'Afternoon',
      ),
      // Evening
      AdvocateSlotModel(
        id: 'e1',
        startTime: '05:30 PM',
        endTime: '05:45 PM',
        durationText: '15 mins',
        status: AdvocateSlotStatus.available,
        period: 'Evening',
      ),
      AdvocateSlotModel(
        id: 'e2',
        startTime: '06:00 PM',
        endTime: '06:15 PM',
        durationText: '15 mins',
        status: AdvocateSlotStatus.available,
        period: 'Evening',
      ),
      AdvocateSlotModel(
        id: 'e3',
        startTime: '06:30 PM',
        endTime: '06:45 PM',
        durationText: '15 mins',
        status: AdvocateSlotStatus.available,
        period: 'Evening',
      ),
    ];
  }

  @override
  List<Object?> get props => [id, startTime, endTime, status, period];
}
