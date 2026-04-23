import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/widget/cusotm_dialog.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service.dart';
import 'package:permission_handler/permission_handler.dart';

class FloatMapButton extends StatelessWidget {
  const FloatMapButton({super.key});

  Future<void> onTap(BuildContext context) async {
    final locationService = sl<LocationService>();
    final errorColor = context.colorTheme.error;
    final hasPermission = await locationService.requestPermission();
    if (!context.mounted) return;
    if (!hasPermission) {
      await AppDialog.show(
        context: context,
        title: "Permission Required",
        description: "Location permission is required to continue.",
        primaryText: "Settings",
        secondaryText: "Cancel",
        icon: Icons.lock,
        iconColor: errorColor,

        onPrimary: () {
          openAppSettings();
        },
      );
      return;
    }

    final isEnabled = await locationService.isServiceEnabled();
    if (!context.mounted) return;
    if (!isEnabled) {
      await AppDialog.show(
        context: context,
        title: "Enable Location Services",
        description: "Please turn on location services (GPS) to continue.",
        primaryText: "Open Settings",
        secondaryText: "Cancel",
        icon: Icons.gps_fixed,
        onPrimary: () {
          //! move this to another class or something
          Geolocator.openLocationSettings();
        },
      );
      return;
    }

    context.push(AppRoutes.mapScreen);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
