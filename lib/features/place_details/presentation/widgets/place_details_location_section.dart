import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/appp_dialog.dart';
import 'package:mindtrip/core/widget/custom_otlined_button.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service_imp.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlaceDetailsLocationSection extends StatelessWidget {
  final PlaceEntity place;

  const PlaceDetailsLocationSection({super.key, required this.place});

  Future<void> onPressed(BuildContext context) async {
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
          onPrimary: () => onPressed(context),
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
          context.push(AppRoutes.map, extra: place);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: context.textTheme.labelMedium?.copyWith(
            color: AppColors.pureBlack,
          ),
        ),
        SizedBox(height: 16.h),
        Skeleton.shade(
          child: SvgPicture.asset(
            'assets/images/map/place_preview.svg',
            width: double.infinity,
            height: 158.h,
          ),
        ),
        SizedBox(height: 14.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 42.w),
          child: Skeleton.shade(
            child: CustomOtlinedButton(
              onPressed: () => onPressed(context),
              icon: Icons.open_in_new_rounded,
              color: context.colorTheme.primary,
              text: 'Open full map',
            ),
          ),
        ),
      ],
    );
  }
}
