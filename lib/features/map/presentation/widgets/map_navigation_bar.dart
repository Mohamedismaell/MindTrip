import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_state.dart';

class MapNavigationBar extends StatelessWidget {
  const MapNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapNavigationCubit, MapNavigationState>(
      buildWhen: (previous, current) =>
          previous.activeRoute != current.activeRoute ||
          previous.isRouteLoading != current.isRouteLoading ||
          previous.routeError != current.routeError,
      builder: (context, state) {
        if (state.isRouteLoading) {
          return buildloading(context);
        }
        if (state.routeError != null) {
          return buildNoRouteBanner(context, state.routeError!);
        }
        final route = state.activeRoute;
        if (route == null) return const SizedBox.shrink();
        final distanceKm = (route.distance / 1000).toStringAsFixed(1);
        final durationMin = (route.duration / 60).ceil();

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: context.colorTheme.primaryContainer,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [AppShadows.mainElevationButton],
          ),
          child: Row(
            children: [
              Icon(
                Icons.directions,
                color: context.colorTheme.onPrimaryContainer,
                size: 32.sp,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Navigating...',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colorTheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$durationMin min • $distanceKm km',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorTheme.onPrimaryContainer.withValues(
                          alpha: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  context.read<MapNavigationCubit>().stopNavigation();
                },
                icon: Icon(
                  Icons.close,
                  color: context.colorTheme.onPrimaryContainer,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: context.colorTheme.surface.withValues(
                    alpha: 0.5,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget buildloading(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
    decoration: BoxDecoration(
      color: context.colorTheme.surface,
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: [AppShadows.mainElevationButton],
    ),
    child: Row(
      children: [
        SizedBox(
          width: 24.w,
          height: 24.w,
          child: const CircularProgressIndicator(strokeWidth: 2),
        ),
        SizedBox(width: 16.w),
        Text('Calculating route...', style: context.textTheme.headlineSmall),
      ],
    ),
  );
}

Widget buildNoRouteBanner(BuildContext context, String errorMsg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
    decoration: BoxDecoration(
      color: context.colorTheme.errorContainer,
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: [AppShadows.mainElevationButton],
    ),
    child: Row(
      children: [
        Icon(Icons.error_outline, color: context.colorTheme.error),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            errorMsg,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorTheme.onErrorContainer,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.pureWhite,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.close, color: context.colorTheme.error),
            onPressed: () {
              print('pressed');
              context.read<MapNavigationCubit>().stopNavigation();
            },
          ),
        ),
      ],
    ),
  );
}
