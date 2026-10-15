import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/advocate_slot_model.dart';
import '../../domain/repositories/i_advocate_repository.dart';

abstract class AdvocateCalendarState extends Equatable {
  const AdvocateCalendarState();
  @override
  List<Object?> get props => [];
}

class AdvocateCalendarInitial extends AdvocateCalendarState {}

class AdvocateCalendarLoading extends AdvocateCalendarState {}

class AdvocateCalendarLoaded extends AdvocateCalendarState {
  final List<AdvocateSlotModel> slots;
  final int selectedDay;
  final int selectedSubTab; // 0: Calendar, 1: Availability, 2: Consultation

  const AdvocateCalendarLoaded({
    required this.slots,
    this.selectedDay = 21,
    this.selectedSubTab = 0,
  });

  @override
  List<Object?> get props => [slots, selectedDay, selectedSubTab];
}

class AdvocateCalendarError extends AdvocateCalendarState {
  final String message;
  const AdvocateCalendarError(this.message);
  @override
  List<Object?> get props => [message];
}

class AdvocateCalendarCubit extends Cubit<AdvocateCalendarState> {
  final IAdvocateRepository repository;

  AdvocateCalendarCubit({required this.repository}) : super(AdvocateCalendarInitial());

  Future<void> loadCalendar({int day = 21, int subTab = 0}) async {
    emit(AdvocateCalendarLoading());
    try {
      final slots = await repository.getSlots(dayOfMonth: day);
      emit(AdvocateCalendarLoaded(
        slots: slots,
        selectedDay: day,
        selectedSubTab: subTab,
      ));
    } catch (e) {
      emit(AdvocateCalendarError(e.toString()));
    }
  }

  void switchSubTab(int subTab) {
    final currentState = state;
    if (currentState is AdvocateCalendarLoaded) {
      emit(AdvocateCalendarLoaded(
        slots: currentState.slots,
        selectedDay: currentState.selectedDay,
        selectedSubTab: subTab,
      ));
    }
  }

  void selectDay(int day) {
    loadCalendar(day: day, subTab: (state is AdvocateCalendarLoaded) ? (state as AdvocateCalendarLoaded).selectedSubTab : 1);
  }

  Future<void> blockSlot(String slotId) async {
    try {
      await repository.blockSlot(slotId);
      final currentState = state;
      final day = (currentState is AdvocateCalendarLoaded) ? currentState.selectedDay : 21;
      final subTab = (currentState is AdvocateCalendarLoaded) ? currentState.selectedSubTab : 1;
      loadCalendar(day: day, subTab: subTab);
    } catch (_) {}
  }

  Future<void> unblockSlot(String slotId) async {
    try {
      await repository.unblockSlot(slotId);
      final currentState = state;
      final day = (currentState is AdvocateCalendarLoaded) ? currentState.selectedDay : 21;
      final subTab = (currentState is AdvocateCalendarLoaded) ? currentState.selectedSubTab : 1;
      loadCalendar(day: day, subTab: subTab);
    } catch (_) {}
  }
}
