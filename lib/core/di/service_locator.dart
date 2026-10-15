import 'package:get_it/get_it.dart';
import '../storage/secure_storage_service.dart';
import '../network/api_client.dart';
import '../theme/theme_cubit.dart';
import '../localization/locale_cubit.dart';
import '../../features/auth/data/auth_repository.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/home/data/home_repository.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/ai_assistant/data/ai_repository.dart';
import '../../features/ai_assistant/presentation/cubit/ai_assistant_cubit.dart';
import '../../features/documents/data/document_repository.dart';
import '../../features/documents/presentation/cubit/document_cubit.dart';
import '../../features/lawyers/data/lawyer_repository.dart';
import '../../features/lawyers/presentation/cubit/lawyer_cubit.dart';
import '../../features/bookings/data/booking_repository.dart';
import '../../features/payments/data/payment_repository.dart';
import '../../features/bookings/presentation/cubit/booking_cubit.dart';
import '../../features/account/data/account_repository.dart';
import '../../features/account/presentation/cubit/account_cubit.dart';
import '../../features/advocate/domain/repositories/i_advocate_repository.dart';
import '../../features/advocate/data/repositories/advocate_repository_impl.dart';
import '../../features/advocate/presentation/cubits/advocate_auth_cubit.dart';
import '../../features/advocate/presentation/cubits/advocate_dashboard_cubit.dart';
import '../../features/advocate/presentation/cubits/advocate_bookings_cubit.dart';
import '../../features/advocate/presentation/cubits/advocate_calendar_cubit.dart';
import '../../features/advocate/presentation/cubits/advocate_earnings_cubit.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // Core Services
  sl.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
  sl.registerLazySingleton<ApiClient>(
      () => ApiClient(secureStorageService: sl()));

  // Global Cubits
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  sl.registerLazySingleton<LocaleCubit>(() => LocaleCubit());

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(apiClient: sl(), secureStorage: sl()));
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(apiClient: sl()));
  sl.registerLazySingleton<AiRepository>(
      () => AiRepositoryImpl(apiClient: sl()));
  sl.registerLazySingleton<DocumentRepository>(
      () => DocumentRepositoryImpl(apiClient: sl()));
  sl.registerLazySingleton<LawyerRepository>(
      () => LawyerRepositoryImpl(apiClient: sl()));
  sl.registerLazySingleton<BookingRepository>(
      () => BookingRepositoryImpl(apiClient: sl()));
  sl.registerLazySingleton<PaymentRepository>(
      () => PaymentRepositoryImpl(apiClient: sl()));
  sl.registerLazySingleton<AccountRepository>(
      () => AccountRepositoryImpl(apiClient: sl()));

  // Advocate Repository
  sl.registerLazySingleton<IAdvocateRepository>(
      () => AdvocateRepositoryImpl(apiClient: sl(), secureStorage: sl()));

  // Feature Cubits
  sl.registerFactory<AuthCubit>(() => AuthCubit(authRepository: sl()));
  sl.registerFactory<HomeCubit>(() => HomeCubit(homeRepository: sl()));
  sl.registerFactory<AiAssistantCubit>(
      () => AiAssistantCubit(aiRepository: sl()));
  sl.registerFactory<DocumentCubit>(
      () => DocumentCubit(documentRepository: sl()));
  sl.registerFactory<LawyerCubit>(
      () => LawyerCubit(lawyerRepository: sl()));
  sl.registerFactory<BookingCubit>(
      () => BookingCubit(bookingRepository: sl(), paymentRepository: sl()));
  sl.registerFactory<AccountCubit>(
      () => AccountCubit(accountRepository: sl()));

  // Advocate Cubits
  sl.registerFactory<AdvocateAuthCubit>(
      () => AdvocateAuthCubit(repository: sl()));
  sl.registerFactory<AdvocateDashboardCubit>(
      () => AdvocateDashboardCubit(repository: sl()));
  sl.registerFactory<AdvocateBookingsCubit>(
      () => AdvocateBookingsCubit(repository: sl()));
  sl.registerFactory<AdvocateCalendarCubit>(
      () => AdvocateCalendarCubit(repository: sl()));
  sl.registerFactory<AdvocateEarningsCubit>(
      () => AdvocateEarningsCubit(repository: sl()));
}

