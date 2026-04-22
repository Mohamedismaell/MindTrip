import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/widget/cusotm_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class FloatMapButton extends StatelessWidget {
  const FloatMapButton({super.key});
  Future<void> requestLocation(BuildContext context) async {
    final agreed = await AppDialog.show(
      context: context,
      title: "Enable Location",
      description: "We need your location to show nearby places on the map.",
      primaryText: "Allow",
      secondaryText: "Cancel",
      icon: Icons.location_on,
      iconColor: context.colorTheme.primary,
      onPrimary: () {},
    );

    if (agreed != true) return;

    final status = await Permission.location.request();

    if (!context.mounted) return;

    if (status.isGranted) {
      context.push(AppRoutes.mapScreen);
    } else if (status.isPermanentlyDenied) {
      await AppDialog.show(
        context: context,
        title: "Permission Required",
        description:
            "Location permission is permanently denied. Please enable it in settings.",
        primaryText: "Settings",
        secondaryText: "Cancel",
        icon: Icons.settings,
        onPrimary: () {
          openAppSettings();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await requestLocation(context);
      },

      child: Container(
        width: 65.w,
        height: 65.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [AppShadows.floatMapButton],
          // gradient: AppColors.blueLightGradient,
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
