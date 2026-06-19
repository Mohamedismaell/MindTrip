import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/appp_dialog.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service_imp.dart';
import 'package:permission_handler/permission_handler.dart';

class FloatMapButton extends StatelessWidget {
  const FloatMapButton({super.key});

  Future<void> onTap(BuildContext context) async {
    final locationService = sl<LocationService>();
    // final errorColor = context.colorTheme.error;
    final status = await locationService.checkAccess();

    if (!context.mounted) return;

    switch (status) {
      case LocationAccessStatus.denied:
        await AppDialog.show(
          context: context,
          title: "Permission Required",
          description: "Location permission is required.",
          primaryText: "Retry",
          onPrimary: () => onTap(context),
        );
        break;

      case LocationAccessStatus.deniedForever:
        await AppDialog.show(
          context: context,
          title: "Permission Required",
          description: "Enable permission from settings.",
          primaryText: "Settings",
          onPrimary: openAppSettings,
        );
        break;

      case LocationAccessStatus.serviceDisabled:
        await AppDialog.show(
          context: context,
          title: "Enable Location",
          description: "Turn on GPS.",
          primaryText: "Open Settings",
          onPrimary: Geolocator.openLocationSettings,
        );
        break;

      case LocationAccessStatus.granted:
        if (context.mounted) {
          context.push(AppRoutes.map);
        }
        // final location = await locationService.getCurrentLocationDetails();
        /// * use it

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TapScaleEffect(
      onTap: () => onTap(context),

      child: Container(
        width: 65.w,
        height: 65.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [AppShadows.floatMapButton],
          border: Border.all(
            color: context.colorTheme.primary,
            style: BorderStyle.solid,
            width: 2.5,
          ),
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.map_outlined,
          size: 32.sp,
          color: context.colorTheme.primary,
        ),
      ),
    );
  }
}
