import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/database/cache/app_hive.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/trips/data/datasources/trip_local_datasource.dart';
import 'package:mindtrip/features/trips/data/datasources/remote_trip_datasource.dart';
import 'package:mindtrip/features/trips/data/repositories/trip_repository_impl.dart';
import 'package:mindtrip/features/trips/domain/repositories/trip_repository.dart';
import 'package:mindtrip/features/trips/domain/use_cases/delete_trip_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_all_trips_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_trip_by_id_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_trip_containing_place_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_trip_details_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/create_trip_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/update_trip_use_case.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trip_details_cubit.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_cubit.dart';

class TripsDi {
  TripsDi._();

  static void init() {
    //! Data Source
    sl.registerLazySingleton<TripLocalDataSource>(
      () => TripLocalDataSource(AppHive.tripsBox),
    );
    sl.registerLazySingleton<RemoteTripDataSource>(
      () => RemoteTripDataSourceImpl(sl<ApiConsumer>()),
    );

    //! Repository
    sl.registerLazySingleton<TripRepository>(
      () => TripRepositoryImpl(
        sl<TripLocalDataSource>(),
        sl<RemoteTripDataSource>(),
      ),
    );

    //! Use Cases
    sl.registerLazySingleton<GetAllTripsUseCase>(
      () => GetAllTripsUseCase(sl<TripRepository>()),
    );
    sl.registerLazySingleton<GetTripByIdUseCase>(
      () => GetTripByIdUseCase(sl<TripRepository>()),
    );
    sl.registerLazySingleton<GetTripDetailsUseCase>(
      () => GetTripDetailsUseCase(sl<TripRepository>()),
    );
    sl.registerLazySingleton<CreateTripUseCase>(
      () => CreateTripUseCase(sl<TripRepository>()),
    );
    sl.registerLazySingleton<DeleteTripUseCase>(
      () => DeleteTripUseCase(sl<TripRepository>()),
    );
    sl.registerLazySingleton<UpdateTripUseCase>(
      () => UpdateTripUseCase(sl<TripRepository>()),
    );
    sl.registerLazySingleton<GetTripContainingPlaceUseCase>(
      () => GetTripContainingPlaceUseCase(sl<TripRepository>()),
    );

    //! Cubit
    sl.registerLazySingleton<TripsCubit>(
      () => TripsCubit(sl<TripRepository>()),
    );

    sl.registerFactory<TripDetailsCubit>(
      () => TripDetailsCubit(
        sl<GetTripDetailsUseCase>(),
        sl<CreateTripUseCase>(),
      ),
    );
  }
}
