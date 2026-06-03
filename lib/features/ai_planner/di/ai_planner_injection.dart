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
import 'package:mindtrip/features/ai_planner/domain/usecases/add_place_to_trip_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/remove_place_from_trip_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/move_place_in_trip_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/move_place_between_trips_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/get_all_trips_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/get_trip_by_id_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/save_trip_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/delete_trip_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/update_trip_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/get_itinerary_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/save_itinerary_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/get_trip_containing_place_use_case.dart';

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
    sl.registerLazySingleton<AddPlaceToTripUseCase>(
      () => AddPlaceToTripUseCase(sl<TripRepository>()),
    );
    sl.registerLazySingleton<RemovePlaceFromTripUseCase>(
      () => RemovePlaceFromTripUseCase(sl<TripRepository>()),
    );
    sl.registerLazySingleton<MovePlaceInTripUseCase>(
      () => MovePlaceInTripUseCase(sl<TripRepository>()),
    );
    sl.registerLazySingleton<MovePlaceBetweenTripsUseCase>(
      () => MovePlaceBetweenTripsUseCase(sl<TripRepository>()),
    );
    sl.registerLazySingleton<GetAllTripsUseCase>(
      () => GetAllTripsUseCase(sl<TripRepository>()),
    );
    sl.registerLazySingleton<GetTripByIdUseCase>(
      () => GetTripByIdUseCase(sl<TripRepository>()),
    );
    sl.registerLazySingleton<SaveTripUseCase>(
      () => SaveTripUseCase(sl<TripRepository>()),
    );
    sl.registerLazySingleton<DeleteTripUseCase>(
      () => DeleteTripUseCase(sl<TripRepository>()),
    );
    sl.registerLazySingleton<UpdateTripUseCase>(
      () => UpdateTripUseCase(sl<TripRepository>()),
    );
    sl.registerLazySingleton<GetItineraryUseCase>(
      () => GetItineraryUseCase(sl<TripRepository>()),
    );
    sl.registerLazySingleton<SaveItineraryUseCase>(
      () => SaveItineraryUseCase(sl<TripRepository>()),
    );
    sl.registerLazySingleton<GetTripContainingPlaceUseCase>(
      () => GetTripContainingPlaceUseCase(sl<TripRepository>()),
    );
    sl.registerLazySingleton<TripsCubit>(
      () => TripsCubit(
        getAllTrips: sl<GetAllTripsUseCase>(),
        saveTrip: sl<SaveTripUseCase>(),
        deleteTrip: sl<DeleteTripUseCase>(),
        updateTrip: sl<UpdateTripUseCase>(),
        generateItinerary: sl<GenerateItineraryUseCase>(),
        saveItinerary: sl<SaveItineraryUseCase>(),
      ),
    );
    sl.registerFactory<TripDetailsCubit>(
      () => TripDetailsCubit(sl<GetTripByIdUseCase>(), sl<GetItineraryUseCase>()),
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
