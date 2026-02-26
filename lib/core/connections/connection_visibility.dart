import 'package:mindtrip/core/shared/routes/app_routes.dart';

bool shouldShowConnectionBanner(String location) {
  return !location.startsWith(AppRoutes.splash) &&
      !location.startsWith(AppRoutes.onBoarding);
}
