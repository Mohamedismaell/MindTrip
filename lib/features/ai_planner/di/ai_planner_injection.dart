import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/ai_planner/data/datasources/mock_chat_datasource.dart';
import 'package:mindtrip/features/ai_planner/data/datasources/planning_session_local_datasource.dart';
import 'package:mindtrip/features/ai_planner/data/repositories/chat_repository_impl.dart';
import 'package:mindtrip/features/ai_planner/data/repositories/planning_session_repository_impl.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/chat_repository.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/planning_session_repository.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/delete_planning_session_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/get_planning_session_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/save_planning_session_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/send_message_use_case.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/chat_cubit.dart';

class AiPlannerDi {
  AiPlannerDi._();

  static void init() {
    //! Cubits — registerFactory so it resets on each navigation
    sl.registerFactory<AiPlannerCubit>(
      () => AiPlannerCubit(
        sl<GetPlanningSessionUseCase>(),
        sl<SavePlanningSessionUseCase>(),
        sl<DeletePlanningSessionUseCase>(),
      ),
    );

    //! Chat — Data sources
    sl.registerLazySingleton<ChatDataSource>(() => MockChatDataSource());
    sl.registerLazySingleton<PlanningSessionLocalDataSource>(
      () => PlanningSessionLocalDataSource(),
    );

    //! Chat — Repository
    sl.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(dataSource: sl<ChatDataSource>()),
    );
    sl.registerLazySingleton<PlanningSessionRepository>(
      () => PlanningSessionRepositoryImpl(sl<PlanningSessionLocalDataSource>()),
    );

    //! Chat — Use cases
    sl.registerLazySingleton<SendMessageUseCase>(
      () => SendMessageUseCase(repository: sl<ChatRepository>()),
    );
    sl.registerLazySingleton<GetPlanningSessionUseCase>(
      () => GetPlanningSessionUseCase(sl<PlanningSessionRepository>()),
    );
    sl.registerLazySingleton<SavePlanningSessionUseCase>(
      () => SavePlanningSessionUseCase(sl<PlanningSessionRepository>()),
    );
    sl.registerLazySingleton<DeletePlanningSessionUseCase>(
      () => DeletePlanningSessionUseCase(sl<PlanningSessionRepository>()),
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
