import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/advocate_earnings_model.dart';
import '../../domain/repositories/i_advocate_repository.dart';

abstract class AdvocateEarningsState extends Equatable {
  const AdvocateEarningsState();
  @override
  List<Object?> get props => [];
}

class AdvocateEarningsInitial extends AdvocateEarningsState {}

class AdvocateEarningsLoading extends AdvocateEarningsState {}

class AdvocateEarningsLoaded extends AdvocateEarningsState {
  final AdvocateEarningsModel earnings;
  final List<AdvocateSettlementModel> settlements;
  final int selectedPeriodIndex; // 0: Today, 1: This Week, 2: This Month, 3: FY 2024-25

  const AdvocateEarningsLoaded({
    required this.earnings,
    required this.settlements,
    this.selectedPeriodIndex = 0,
  });

  @override
  List<Object?> get props => [earnings, settlements, selectedPeriodIndex];
}

class AdvocateEarningsError extends AdvocateEarningsState {
  final String message;
  const AdvocateEarningsError(this.message);
  @override
  List<Object?> get props => [message];
}

class AdvocateEarningsCubit extends Cubit<AdvocateEarningsState> {
  final IAdvocateRepository repository;

  AdvocateEarningsCubit({required this.repository}) : super(AdvocateEarningsInitial());

  Future<void> loadEarnings({int periodIndex = 0}) async {
    emit(AdvocateEarningsLoading());
    try {
      final periods = ['Today', 'This Week', 'This Month', 'FY 2024-25'];
      final earnings = await repository.getEarningsSummary(periods[periodIndex]);
      final settlements = await repository.getSettlements();

      emit(AdvocateEarningsLoaded(
        earnings: earnings,
        settlements: settlements,
        selectedPeriodIndex: periodIndex,
      ));
    } catch (e) {
      emit(AdvocateEarningsError(e.toString()));
    }
  }

  void switchPeriod(int periodIndex) {
    loadEarnings(periodIndex: periodIndex);
  }

  Future<void> instantSettle(double amount, String bankAccount) async {
    try {
      await repository.instantSettle(amount, bankAccount);
      loadEarnings(periodIndex: (state is AdvocateEarningsLoaded) ? (state as AdvocateEarningsLoaded).selectedPeriodIndex : 0);
    } catch (_) {}
  }

  Future<void> requestWithdrawal(double amount) async {
    try {
      await repository.requestWithdrawal(amount);
      loadEarnings();
    } catch (_) {}
  }
}
