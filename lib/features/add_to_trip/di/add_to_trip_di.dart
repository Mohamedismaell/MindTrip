import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/edit_plan_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/generate_plan_use_case.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/trips/domain/use_cases/create_trip_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_all_trips_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/update_trip_plan_use_case.dart';

class AddToTripDi {
  AddToTripDi._();

  static void init() {
    sl.registerFactoryParam<AddToTripCubit, PlaceEntity, void>(
      (place, _) => AddToTripCubit(
        place: place,
        getAllTripsUseCase: sl<GetAllTripsUseCase>(),
        editPlanUseCase: sl<EditPlanUseCase>(),
        generatePlanUseCase: sl<GeneratePlanUseCase>(),
        createTripUseCase: sl<CreateTripUseCase>(),
        updateTripPlanUseCase: sl<UpdateTripPlanUseCase>(),
      ),
    );
  }
}
