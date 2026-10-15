import '../../data/models/advocate_profile_model.dart';
import '../../data/models/advocate_booking_model.dart';
import '../../data/models/advocate_slot_model.dart';
import '../../data/models/advocate_earnings_model.dart';

abstract class IAdvocateRepository {
  // Auth & Profile
  Future<AdvocateProfileModel> loginWithEmail(String email, String password);
  Future<void> sendOtp(String mobile);
  Future<AdvocateProfileModel> verifyOtp(String mobile, String otp);
  Future<AdvocateProfileModel> registerStep1(Map<String, dynamic> step1Data);
  Future<AdvocateProfileModel> registerStep2(Map<String, dynamic> step2Data);
  Future<AdvocateProfileModel> getProfile();
  Future<AdvocateProfileModel> updateProfile(AdvocateProfileModel profile);
  Future<void> logout();

  // Availability & Dashboard
  Future<bool> toggleAvailability(bool isAvailable);

  // Bookings
  Future<List<AdvocateBookingModel>> getBookings({AdvocateBookingStatus? status});
  Future<AdvocateBookingModel> getBookingDetails(String id);
  Future<void> acceptBooking(String id);
  Future<void> rejectBooking(String id, String reason);
  Future<void> rescheduleBooking(String id, String newSlot);
  Future<void> completeConsultation(String id);

  // Calendar & Slots
  Future<List<AdvocateSlotModel>> getSlots({required int dayOfMonth});
  Future<void> blockSlot(String slotId);
  Future<void> unblockSlot(String slotId);
  Future<void> saveSlot(AdvocateSlotModel slot);
  Future<void> removeSlot(String slotId);

  // Earnings & Financials
  Future<AdvocateEarningsModel> getEarningsSummary(String period);
  Future<List<AdvocateSettlementModel>> getSettlements();
  Future<void> instantSettle(double amount, String bankAccount);
  Future<void> requestWithdrawal(double amount);

  // Reviews
  Future<List<AdvocateReviewModel>> getReviews();
}
