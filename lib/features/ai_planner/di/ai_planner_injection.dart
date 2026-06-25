import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/features/ai_planner/data/datasources/ai_planner_remote_datasource.dart';
import 'package:mindtrip/features/ai_planner/data/datasources/chat_remote_datasource.dart';
import 'package:mindtrip/features/ai_planner/data/datasources/ai_planner_local_datasource.dart';
import 'package:mindtrip/features/ai_planner/data/repositories/ai_planner_repository_impl.dart';
import 'package:mindtrip/features/ai_planner/data/repositories/chat_repository_impl.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/chat_repository.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/ai_planner_repository.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/generate_plan_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/send_message_use_case.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/chat_cubit.dart';

class AiPlannerDi {
  AiPlannerDi._();

  static void init() {
    //! Chat — Data sources (real remote implementation)
    sl.registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(apiConsumer: sl<ApiConsumer>()),
    );
    sl.registerLazySingleton<AiPlannerLocalDataSource>(
      () => AiPlannerLocalDataSource(),
    );
    sl.registerLazySingleton<AiPlannerRemoteDataSource>(
      () => AiPlannerRemoteDataSourceImp(apiConsumer: sl<ApiConsumer>()),
    );

    //! Chat — Repository
    sl.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(dataSource: sl<ChatRemoteDataSource>()),
    );
    sl.registerLazySingleton<AiPlannerRepository>(
      () => AiPlannerRepositoryImpl(
        remoteDataSource: sl<AiPlannerRemoteDataSource>(),
      ),
    );

    //! Chat — Use cases
    sl.registerLazySingleton<SendMessageUseCase>(
      () => SendMessageUseCase(sl<ChatRepository>()),
    );
    sl.registerLazySingleton<GeneratePlanUseCase>(
      () => GeneratePlanUseCase(sl<AiPlannerRepository>()),
    );

    //! Chat — Cubit (factory: each trip gets its own chat instance)
    sl.registerFactory<ChatCubit>(
      () => ChatCubit(
        sendMessageUseCase: sl<SendMessageUseCase>(),
        chatRepository: sl<ChatRepository>(),
      ),
    );
    //! Cubits — registerFactory so it resets on each navigation
    sl.registerFactory<AiPlannerCubit>(
      () => AiPlannerCubit(generatePlanUseCase: sl<GeneratePlanUseCase>()),
    );
  }
}
