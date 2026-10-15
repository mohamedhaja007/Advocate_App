import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/advocate_profile_model.dart';
import '../../data/models/advocate_booking_model.dart';
import '../../domain/repositories/i_advocate_repository.dart';

abstract class AdvocateDashboardState extends Equatable {
  const AdvocateDashboardState();
  @override
  List<Object?> get props => [];
}

class AdvocateDashboardInitial extends AdvocateDashboardState {}

class AdvocateDashboardLoading extends AdvocateDashboardState {}

class AdvocateDashboardLoaded extends AdvocateDashboardState {
  final AdvocateProfileModel profile;
  final List<AdvocateBookingModel> todaySchedule;
  final int todayBookingsCount;
  final int pendingBookingsCount;
  final double todayFees;
  final double rating;
  final bool isAvailableForConsults;

  const AdvocateDashboardLoaded({
    required this.profile,
    required this.todaySchedule,
    required this.todayBookingsCount,
    required this.pendingBookingsCount,
    required this.todayFees,
    required this.rating,
    required this.isAvailableForConsults,
  });

  @override
  List<Object?> get props => [
        profile,
        todaySchedule,
        todayBookingsCount,
        pendingBookingsCount,
        todayFees,
        rating,
        isAvailableForConsults,
      ];
}

class AdvocateDashboardError extends AdvocateDashboardState {
  final String message;
  const AdvocateDashboardError(this.message);
  @override
  List<Object?> get props => [message];
}

class AdvocateDashboardCubit extends Cubit<AdvocateDashboardState> {
  final IAdvocateRepository repository;

  AdvocateDashboardCubit({required this.repository}) : super(AdvocateDashboardInitial());

  Future<void> loadDashboard() async {
    emit(AdvocateDashboardLoading());
    try {
      final profile = await repository.getProfile();
      final bookings = await repository.getBookings();
      emit(AdvocateDashboardLoaded(
        profile: profile,
        todaySchedule: bookings,
        todayBookingsCount: 5,
        pendingBookingsCount: 2,
        todayFees: 6789.0,
        rating: 4.1,
        isAvailableForConsults: profile.isAvailableForConsults,
      ));
    } catch (e) {
      emit(AdvocateDashboardError(e.toString()));
    }
  }

  Future<void> toggleAvailability(bool isAvailable) async {
    final currentState = state;
    if (currentState is AdvocateDashboardLoaded) {
      try {
        await repository.toggleAvailability(isAvailable);
        emit(AdvocateDashboardLoaded(
          profile: currentState.profile.copyWith(isAvailableForConsults: isAvailable),
          todaySchedule: currentState.todaySchedule,
          todayBookingsCount: currentState.todayBookingsCount,
          pendingBookingsCount: currentState.pendingBookingsCount,
          todayFees: currentState.todayFees,
          rating: currentState.rating,
          isAvailableForConsults: isAvailable,
        ));
      } catch (_) {}
    }
  }

  Future<void> acceptBooking(String id) async {
    try {
      await repository.acceptBooking(id);
      loadDashboard();
    } catch (_) {}
  }
}
