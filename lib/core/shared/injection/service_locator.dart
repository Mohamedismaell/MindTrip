import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/core/shared/injection/common_di.dart';
import 'package:mindtrip/features/ai_planner/di/ai_planner_injection.dart';
import 'package:mindtrip/features/authetication/di/auth_di.dart';
import 'package:mindtrip/features/map/di/map_di.dart';
import 'package:mindtrip/features/onboarding/di/on_boarding_injection.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies({
  required Box onboardingBox,
  // required Box<String> profileBox,
}) async {
  await CommonDi.init();

  AuthDi.init();
  OnboardingDi.init(onboardingBox: onboardingBox);
  AiPlannerDi.init();
  MapDi.init();
}
