import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';

class AiPlannerDi {
  AiPlannerDi._();

  static void init() {
    //! Cubit — registerFactory so it resets on each navigation
    sl.registerFactory<AiPlannerCubit>(() => AiPlannerCubit());
  }
}
