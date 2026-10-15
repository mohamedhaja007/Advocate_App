import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../../domain/repositories/i_advocate_repository.dart';
import '../models/advocate_profile_model.dart';
import '../models/advocate_booking_model.dart';
import '../models/advocate_slot_model.dart';
import '../models/advocate_earnings_model.dart';

class AdvocateRepositoryImpl implements IAdvocateRepository {
  final ApiClient apiClient;
  final SecureStorageService secureStorage;

  // Local state cache for offline/prototype demonstration
  AdvocateProfileModel _cachedProfile = AdvocateProfileModel.fixture();
  List<AdvocateBookingModel> _cachedBookings = AdvocateBookingModel.fixtures();
  List<AdvocateSlotModel> _cachedSlots = AdvocateSlotModel.fixtures();
  final AdvocateEarningsModel _cachedEarnings = AdvocateEarningsModel.fixture();

  AdvocateRepositoryImpl({
    required this.apiClient,
    required this.secureStorage,
  });

  @override
  Future<AdvocateProfileModel> loginWithEmail(String email, String password) async {
    try {
      final response = await apiClient.post(
        ApiEndpoints.advocateLogin,
        data: {'email': email, 'password': password},
      );
      if (response.data != null && response.data['token'] != null) {
        await secureStorage.saveAccessToken(response.data['token']);
      }
    } catch (_) {
      // Graceful fallback for unbuilt backend endpoints
    }

    _cachedProfile = AdvocateProfileModel.fixture();
    return _cachedProfile;
  }

  @override
  Future<void> sendOtp(String mobile) async {
    try {
      await apiClient.post(
        ApiEndpoints.advocateSendOtp,
        data: {'mobile': mobile},
      );
    } catch (_) {
      // Backend simulation
    }
  }

  @override
  Future<AdvocateProfileModel> verifyOtp(String mobile, String otp) async {
    try {
      final response = await apiClient.post(
        ApiEndpoints.advocateVerifyOtp,
        data: {'mobile': mobile, 'otp': otp},
      );
      if (response.data != null && response.data['token'] != null) {
        await secureStorage.saveAccessToken(response.data['token']);
      }
    } catch (_) {
      // Backend simulation
    }
    return _cachedProfile;
  }

  @override
  Future<AdvocateProfileModel> registerStep1(Map<String, dynamic> step1Data) async {
    try {
      await apiClient.post(ApiEndpoints.advocateRegisterStep1, data: step1Data);
    } catch (_) {}
    return _cachedProfile;
  }

  @override
  Future<AdvocateProfileModel> registerStep2(Map<String, dynamic> step2Data) async {
    try {
      await apiClient.post(ApiEndpoints.advocateRegisterStep2, data: step2Data);
    } catch (_) {}
    return _cachedProfile;
  }

  @override
  Future<AdvocateProfileModel> getProfile() async {
    try {
      final response = await apiClient.get(ApiEndpoints.advocateProfile);
      if (response.data != null) {
        // parse from json
      }
    } catch (_) {}
    return _cachedProfile;
  }

  @override
  Future<AdvocateProfileModel> updateProfile(AdvocateProfileModel profile) async {
    try {
      await apiClient.put(ApiEndpoints.advocateProfile, data: profile.toJson());
    } catch (_) {}
    _cachedProfile = profile;
    return _cachedProfile;
  }

  @override
  Future<void> logout() async {
    try {
      await apiClient.post(ApiEndpoints.advocateLogout);
    } catch (_) {}
    await secureStorage.clearAll();
  }


  @override
  Future<bool> toggleAvailability(bool isAvailable) async {
    try {
      await apiClient.post(
        ApiEndpoints.advocateAvailabilityToggle,
        data: {'isAvailable': isAvailable},
      );
    } catch (_) {}
    _cachedProfile = _cachedProfile.copyWith(isAvailableForConsults: isAvailable);
    return isAvailable;
  }

  @override
  Future<List<AdvocateBookingModel>> getBookings({AdvocateBookingStatus? status}) async {
    try {
      final response = await apiClient.get(
        ApiEndpoints.advocateBookings,
        queryParameters: status != null ? {'status': status.name} : null,
      );
      if (response.data != null) {
        // parse bookings
      }
    } catch (_) {}
    if (status != null) {
      return _cachedBookings.where((b) => b.status == status).toList();
    }
    return _cachedBookings;
  }

  @override
  Future<AdvocateBookingModel> getBookingDetails(String id) async {
    try {
      final response = await apiClient.get('${ApiEndpoints.advocateBookings}/$id');
      if (response.data != null) {
        // parse
      }
    } catch (_) {}
    return _cachedBookings.firstWhere(
      (b) => b.id == id,
      orElse: () => _cachedBookings.first,
    );
  }

  @override
  Future<void> acceptBooking(String id) async {
    try {
      await apiClient.post('${ApiEndpoints.advocateBookings}/$id/accept');
    } catch (_) {}
    _cachedBookings = _cachedBookings.map((b) {
      if (b.id == id) {
        return AdvocateBookingModel(
          id: b.id,
          bookingNumber: b.bookingNumber,
          clientName: b.clientName,
          clientInitials: b.clientInitials,
          caseId: b.caseId,
          category: b.category,
          type: b.type,
          status: AdvocateBookingStatus.confirmed,
          date: b.date,
          timeSlot: b.timeSlot,
          timeRemainingText: 'Starts in 45 mins',
          fee: b.fee,
          isPaid: true,
          documentsCount: b.documentsCount,
          timeline: b.timeline,
        );
      }
      return b;
    }).toList();
  }

  @override
  Future<void> rejectBooking(String id, String reason) async {
    try {
      await apiClient.post(
        '${ApiEndpoints.advocateBookings}/$id/reject',
        data: {'reason': reason},
      );
    } catch (_) {}
    _cachedBookings = _cachedBookings.map((b) {
      if (b.id == id) {
        return AdvocateBookingModel(
          id: b.id,
          bookingNumber: b.bookingNumber,
          clientName: b.clientName,
          clientInitials: b.clientInitials,
          caseId: b.caseId,
          category: b.category,
          type: b.type,
          status: AdvocateBookingStatus.cancelled,
          date: b.date,
          timeSlot: b.timeSlot,
          timeRemainingText: 'Canceled by advocate',
          fee: b.fee,
          isPaid: true,
          cancelReason: reason,
          cancelDate: 'Today',
          timeline: b.timeline,
        );
      }
      return b;
    }).toList();
  }

  @override
  Future<void> rescheduleBooking(String id, String newSlot) async {
    try {
      await apiClient.post(
        '${ApiEndpoints.advocateBookings}/$id/reschedule',
        data: {'newSlot': newSlot},
      );
    } catch (_) {}
  }

  @override
  Future<void> completeConsultation(String id) async {
    try {
      await apiClient.post('${ApiEndpoints.advocateBookings}/$id/complete');
    } catch (_) {}
    _cachedBookings = _cachedBookings.map((b) {
      if (b.id == id) {
        return AdvocateBookingModel(
          id: b.id,
          bookingNumber: b.bookingNumber,
          clientName: b.clientName,
          clientInitials: b.clientInitials,
          caseId: b.caseId,
          category: b.category,
          type: b.type,
          status: AdvocateBookingStatus.completed,
          date: b.date,
          timeSlot: b.timeSlot,
          timeRemainingText: 'Completed',
          fee: b.fee,
          isPaid: true,
          timeline: b.timeline,
        );
      }
      return b;
    }).toList();
  }

  @override
  Future<List<AdvocateSlotModel>> getSlots({required int dayOfMonth}) async {
    try {
      final response = await apiClient.get(
        ApiEndpoints.advocateSlots,
        queryParameters: {'day': dayOfMonth},
      );
      if (response.data != null) {
        // parse
      }
    } catch (_) {}
    return _cachedSlots;
  }

  @override
  Future<void> blockSlot(String slotId) async {
    try {
      await apiClient.post('${ApiEndpoints.advocateSlots}/$slotId/block');
    } catch (_) {}
    _cachedSlots = _cachedSlots.map((s) {
      if (s.id == slotId) {
        return AdvocateSlotModel(
          id: s.id,
          startTime: s.startTime,
          endTime: s.endTime,
          durationText: s.durationText,
          status: AdvocateSlotStatus.blocked,
          period: s.period,
        );
      }
      return s;
    }).toList();
  }

  @override
  Future<void> unblockSlot(String slotId) async {
    try {
      await apiClient.post('${ApiEndpoints.advocateSlots}/$slotId/unblock');
    } catch (_) {}
    _cachedSlots = _cachedSlots.map((s) {
      if (s.id == slotId) {
        return AdvocateSlotModel(
          id: s.id,
          startTime: s.startTime,
          endTime: s.endTime,
          durationText: s.durationText,
          status: AdvocateSlotStatus.available,
          period: s.period,
        );
      }
      return s;
    }).toList();
  }

  @override
  Future<void> saveSlot(AdvocateSlotModel slot) async {
    try {
      await apiClient.post(ApiEndpoints.advocateSlots, data: {
        'startTime': slot.startTime,
        'endTime': slot.endTime,
        'status': slot.status.name,
      });
    } catch (_) {}
    _cachedSlots = [..._cachedSlots.where((s) => s.id != slot.id), slot];
  }

  @override
  Future<void> removeSlot(String slotId) async {
    try {
      await apiClient.delete('${ApiEndpoints.advocateSlots}/$slotId');
    } catch (_) {}
    _cachedSlots = _cachedSlots.where((s) => s.id != slotId).toList();
  }

  @override
  Future<AdvocateEarningsModel> getEarningsSummary(String period) async {
    try {
      final response = await apiClient.get(
        ApiEndpoints.advocateEarningsSummary,
        queryParameters: {'period': period},
      );
      if (response.data != null) {
        // parse
      }
    } catch (_) {}
    return _cachedEarnings;
  }

  @override
  Future<List<AdvocateSettlementModel>> getSettlements() async {
    try {
      final response = await apiClient.get(ApiEndpoints.advocateSettlements);
      if (response.data != null) {
        // parse
      }
    } catch (_) {}
    return AdvocateSettlementModel.fixtures();
  }

  @override
  Future<void> instantSettle(double amount, String bankAccount) async {
    try {
      await apiClient.post(
        ApiEndpoints.advocateInstantSettle,
        data: {'amount': amount, 'bankAccount': bankAccount},
      );
    } catch (_) {}
  }

  @override
  Future<void> requestWithdrawal(double amount) async {
    try {
      await apiClient.post(
        ApiEndpoints.advocateWithdrawal,
        data: {'amount': amount},
      );
    } catch (_) {}
  }

  @override
  Future<List<AdvocateReviewModel>> getReviews() async {
    try {
      final response = await apiClient.get(ApiEndpoints.advocateReviews);
      if (response.data != null) {
        // parse
      }
    } catch (_) {}
    return AdvocateReviewModel.fixtures();
  }
}
