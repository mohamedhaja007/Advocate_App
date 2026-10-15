import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/advocate_profile_model.dart';
import '../../domain/repositories/i_advocate_repository.dart';

abstract class AdvocateAuthState extends Equatable {
  const AdvocateAuthState();
  @override
  List<Object?> get props => [];
}

class AdvocateAuthInitial extends AdvocateAuthState {}

class AdvocateAuthLoading extends AdvocateAuthState {}

class AdvocateAuthOtpSent extends AdvocateAuthState {
  final String mobile;
  const AdvocateAuthOtpSent(this.mobile);
  @override
  List<Object?> get props => [mobile];
}

class AdvocateAuthenticated extends AdvocateAuthState {
  final AdvocateProfileModel profile;
  const AdvocateAuthenticated(this.profile);
  @override
  List<Object?> get props => [profile];
}

class AdvocateVerificationPendingState extends AdvocateAuthState {
  final AdvocateProfileModel profile;
  const AdvocateVerificationPendingState(this.profile);
  @override
  List<Object?> get props => [profile];
}

class AdvocateUnauthenticated extends AdvocateAuthState {}

class AdvocateAuthError extends AdvocateAuthState {
  final String message;
  const AdvocateAuthError(this.message);
  @override
  List<Object?> get props => [message];
}

class AdvocateAuthCubit extends Cubit<AdvocateAuthState> {
  final IAdvocateRepository repository;

  AdvocateAuthCubit({required this.repository}) : super(AdvocateAuthInitial());

  Future<void> checkAuthStatus() async {
    try {
      final profile = await repository.getProfile();
      if (profile.verificationStatus == AdvocateVerificationStatus.underReview ||
          profile.verificationStatus == AdvocateVerificationStatus.pending) {
        emit(AdvocateVerificationPendingState(profile));
      } else {
        emit(AdvocateAuthenticated(profile));
      }
    } catch (_) {
      emit(AdvocateUnauthenticated());
    }
  }

  Future<void> loginWithEmail(String email, String password) async {
    emit(AdvocateAuthLoading());
    try {
      final profile = await repository.loginWithEmail(email, password);
      emit(AdvocateAuthenticated(profile));
    } catch (e) {
      emit(AdvocateAuthError(e.toString()));
    }
  }

  Future<void> sendOtp(String mobile) async {
    emit(AdvocateAuthLoading());
    try {
      await repository.sendOtp(mobile);
      emit(AdvocateAuthOtpSent(mobile));
    } catch (e) {
      emit(AdvocateAuthError(e.toString()));
    }
  }

  Future<void> verifyOtp(String mobile, String otp) async {
    emit(AdvocateAuthLoading());
    try {
      final profile = await repository.verifyOtp(mobile, otp);
      emit(AdvocateAuthenticated(profile));
    } catch (e) {
      emit(AdvocateAuthError(e.toString()));
    }
  }

  Future<void> registerStep1(Map<String, dynamic> data) async {
    emit(AdvocateAuthLoading());
    try {
      final profile = await repository.registerStep1(data);
      emit(AdvocateAuthenticated(profile));
    } catch (e) {
      emit(AdvocateAuthError(e.toString()));
    }
  }

  Future<void> registerStep2(Map<String, dynamic> data) async {
    emit(AdvocateAuthLoading());
    try {
      final profile = await repository.registerStep2(data);
      emit(AdvocateAuthenticated(profile));
    } catch (e) {
      emit(AdvocateAuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AdvocateAuthLoading());
    try {
      await repository.logout();
      emit(AdvocateUnauthenticated());
    } catch (e) {
      emit(AdvocateUnauthenticated());
    }
  }
}
