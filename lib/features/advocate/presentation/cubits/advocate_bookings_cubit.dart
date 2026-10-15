import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/advocate_booking_model.dart';
import '../../domain/repositories/i_advocate_repository.dart';

abstract class AdvocateBookingsState extends Equatable {
  const AdvocateBookingsState();
  @override
  List<Object?> get props => [];
}

class AdvocateBookingsInitial extends AdvocateBookingsState {}

class AdvocateBookingsLoading extends AdvocateBookingsState {}

class AdvocateBookingsLoaded extends AdvocateBookingsState {
  final List<AdvocateBookingModel> allBookings;
  final List<AdvocateBookingModel> confirmedBookings;
  final List<AdvocateBookingModel> pendingBookings;
  final List<AdvocateBookingModel> cancelledBookings;
  final int selectedTab;

  const AdvocateBookingsLoaded({
    required this.allBookings,
    required this.confirmedBookings,
    required this.pendingBookings,
    required this.cancelledBookings,
    this.selectedTab = 0,
  });

  @override
  List<Object?> get props => [
        allBookings,
        confirmedBookings,
        pendingBookings,
        cancelledBookings,
        selectedTab,
      ];
}

class AdvocateBookingsError extends AdvocateBookingsState {
  final String message;
  const AdvocateBookingsError(this.message);
  @override
  List<Object?> get props => [message];
}

class AdvocateBookingsCubit extends Cubit<AdvocateBookingsState> {
  final IAdvocateRepository repository;

  AdvocateBookingsCubit({required this.repository}) : super(AdvocateBookingsInitial());

  Future<void> loadBookings({int tab = 0}) async {
    emit(AdvocateBookingsLoading());
    try {
      final bookings = await repository.getBookings();
      final confirmed = bookings
          .where((b) => b.status == AdvocateBookingStatus.confirmed)
          .toList();
      final pending = bookings
          .where((b) => b.status == AdvocateBookingStatus.pending)
          .toList();
      final cancelled = bookings
          .where((b) => b.status == AdvocateBookingStatus.cancelled)
          .toList();

      emit(AdvocateBookingsLoaded(
        allBookings: bookings,
        confirmedBookings: confirmed,
        pendingBookings: pending,
        cancelledBookings: cancelled,
        selectedTab: tab,
      ));
    } catch (e) {
      emit(AdvocateBookingsError(e.toString()));
    }
  }

  void switchTab(int tab) {
    final currentState = state;
    if (currentState is AdvocateBookingsLoaded) {
      emit(AdvocateBookingsLoaded(
        allBookings: currentState.allBookings,
        confirmedBookings: currentState.confirmedBookings,
        pendingBookings: currentState.pendingBookings,
        cancelledBookings: currentState.cancelledBookings,
        selectedTab: tab,
      ));
    }
  }

  Future<void> acceptBooking(String id) async {
    try {
      await repository.acceptBooking(id);
      loadBookings(tab: 0);
    } catch (_) {}
  }

  Future<void> rejectBooking(String id, String reason) async {
    try {
      await repository.rejectBooking(id, reason);
      loadBookings(tab: 2);
    } catch (_) {}
  }

  Future<void> rescheduleBooking(String id, String slot) async {
    try {
      await repository.rescheduleBooking(id, slot);
      loadBookings();
    } catch (_) {}
  }
}
