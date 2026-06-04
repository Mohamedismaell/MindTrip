import 'package:mindtrip/core/database/cache/app_hive.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/itinerary/data/datasources/mock_itinerary_datasource.dart';
import 'package:mindtrip/features/itinerary/data/repositories/itinerary_repository_impl.dart';
import 'package:mindtrip/features/itinerary/domain/repositories/itinerary_repository.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/generate_itinerary_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/get_itinerary_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/save_itinerary_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/add_place_to_trip_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/remove_place_from_trip_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/move_place_in_trip_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/move_place_between_trips_use_case.dart';
import 'package:mindtrip/features/itinerary/presentation/cubit/trip_details_cubit.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_trip_by_id_use_case.dart';

class ItineraryDi {
  ItineraryDi._();

  static void init() {
    //! Data Source
    sl.registerLazySingleton<ItineraryDataSource>(
      () => MockItineraryDataSource(AppHive.itinerariesBox),
    );

    //! Repository
    sl.registerLazySingleton<ItineraryRepository>(
      () => ItineraryRepositoryImpl(sl<ItineraryDataSource>()),
    );

    //! Use Cases
    sl.registerLazySingleton<GenerateItineraryUseCase>(
      () => GenerateItineraryUseCase(sl<ItineraryRepository>()),
    );
    sl.registerLazySingleton<GetItineraryUseCase>(
      () => GetItineraryUseCase(sl<ItineraryRepository>()),
    );
    sl.registerLazySingleton<SaveItineraryUseCase>(
      () => SaveItineraryUseCase(sl<ItineraryRepository>()),
    );
    sl.registerLazySingleton<AddPlaceToTripUseCase>(
      () => AddPlaceToTripUseCase(sl<ItineraryRepository>()),
    );
    sl.registerLazySingleton<RemovePlaceFromTripUseCase>(
      () => RemovePlaceFromTripUseCase(sl<ItineraryRepository>()),
    );
    sl.registerLazySingleton<MovePlaceInTripUseCase>(
      () => MovePlaceInTripUseCase(sl<ItineraryRepository>()),
    );
    sl.registerLazySingleton<MovePlaceBetweenTripsUseCase>(
      () => MovePlaceBetweenTripsUseCase(sl<ItineraryRepository>()),
    );

    //! Cubit
    sl.registerFactory<TripDetailsCubit>(
      () => TripDetailsCubit(
        sl<GetTripByIdUseCase>(),
        sl<GetItineraryUseCase>(),
      ),
    );
  }
}
