import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/ai_planner/data/datasources/mock_chat_datasource.dart';
import 'package:mindtrip/features/ai_planner/data/repositories/chat_repository_impl.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/chat_repository.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/send_message_use_case.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/chat_cubit.dart';
import 'package:mindtrip/core/database/cache/app_hive.dart';
import 'package:mindtrip/features/ai_planner/data/datasources/trip_local_datasource.dart';
import 'package:mindtrip/features/ai_planner/data/datasources/mock_itinerary_datasource.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/generate_itinerary_use_case.dart';
import 'package:mindtrip/features/ai_planner/data/repositories/trip_repository_impl.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/trip_repository.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trip_details_cubit.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/edit_itinerary_use_case.dart';

class AiPlannerDi {
  AiPlannerDi._();

  static void init() {
    //! Cubits — registerFactory so it resets on each navigation
    sl.registerFactory<AiPlannerCubit>(() => AiPlannerCubit());

    //! Trips Feature
    sl.registerLazySingleton<TripLocalDataSource>(
      () => TripLocalDataSource(AppHive.tripsBox),
    );
    sl.registerLazySingleton<ItineraryDataSource>(
      () => MockItineraryDataSource(AppHive.itinerariesBox),
    );
    sl.registerLazySingleton<TripRepository>(
      () => TripRepositoryImpl(
        sl<TripLocalDataSource>(),
        sl<ItineraryDataSource>(),
      ),
    );
    sl.registerLazySingleton<GenerateItineraryUseCase>(
      () => GenerateItineraryUseCase(sl<TripRepository>()),
    );
    sl.registerLazySingleton<TripsCubit>(
      () => TripsCubit(sl<TripRepository>()),
    );
    sl.registerFactory<EditItineraryUseCase>(
      () => EditItineraryUseCase(),
    );
    sl.registerFactory<TripDetailsCubit>(
      () => TripDetailsCubit(sl<TripRepository>(), sl<EditItineraryUseCase>()),
    );

    //! Chat — Data sources
    sl.registerLazySingleton<ChatDataSource>(() => MockChatDataSource());

    //! Chat — Repository
    sl.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(dataSource: sl<ChatDataSource>()),
    );

    //! Chat — Use cases
    sl.registerLazySingleton<SendMessageUseCase>(
      () => SendMessageUseCase(repository: sl<ChatRepository>()),
    );

    //! Chat — Cubit (factory: each trip gets its own chat instance)
    sl.registerFactory<ChatCubit>(
      () => ChatCubit(
        sendMessageUseCase: sl<SendMessageUseCase>(),
        chatRepository: sl<ChatRepository>(),
      ),
    );
  }
}
