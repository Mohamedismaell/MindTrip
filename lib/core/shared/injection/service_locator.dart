import 'package:get_it/get_it.dart';
import 'package:mindtrip/core/shared/injection/common_di.dart';
import 'package:mindtrip/features/explore/di/explore_di.dart';
import 'package:mindtrip/features/places/di/places_di.dart';
import 'package:mindtrip/features/home/di/home_di.dart';
import 'package:mindtrip/features/trips/di/trips_di.dart';
import 'package:mindtrip/features/itinerary/di/itinerary_di.dart';
import 'package:mindtrip/features/ai_planner/di/ai_planner_injection.dart';
import 'package:mindtrip/features/authetication/di/auth_di.dart';
import 'package:mindtrip/features/map/di/map_di.dart';
import 'package:mindtrip/features/onboarding/di/on_boarding_injection.dart';
import 'package:mindtrip/features/profile/di/profile_di.dart';
import 'package:mindtrip/features/place_details/di/place_details_di.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  await CommonDi.init();

  AuthDi.init();
  OnboardingDi.init();
  ItineraryDi.init();
  TripsDi.init();
  AiPlannerDi.init();
  MapDi.init();
  ProfileDi.init();
  PlaceDetailsDi.init();
  PlacesDi.init();
  ExploreDi.init();
  HomeDi.init();
}
