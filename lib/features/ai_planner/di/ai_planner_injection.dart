import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/ai_planner/data/datasources/mock_chat_datasource.dart';
import 'package:mindtrip/features/ai_planner/data/repositories/chat_repository_impl.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/chat_repository.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/send_message_use_case.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/chat_cubit.dart';
import 'package:mindtrip/core/database/cache/app_hive.dart';
import 'package:mindtrip/features/ai_planner/data/datasources/trip_local_datasource.dart';
import 'package:mindtrip/features/ai_planner/data/repositories/trip_repository_impl.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/trip_repository.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_cubit.dart';
class AiPlannerDi {
  AiPlannerDi._();

  static void init() {
    //! Cubits — registerFactory so it resets on each navigation
    sl.registerFactory<AiPlannerCubit>(() => AiPlannerCubit());

    //! Trips Feature
    sl.registerLazySingleton<TripLocalDataSource>(
      () => TripLocalDataSource(AppHive.tripsBox),
    );
    sl.registerLazySingleton<TripRepository>(
      () => TripRepositoryImpl(sl<TripLocalDataSource>()),
    );
    sl.registerLazySingleton<TripsCubit>(
      () => TripsCubit(sl<TripRepository>()),
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
