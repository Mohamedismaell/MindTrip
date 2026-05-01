import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_state.dart';

class MapNavigationBar extends StatelessWidget {
  const MapNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      buildWhen: (previous, current) =>
          previous.activeRoute != current.activeRoute ||
          previous.isRouteLoading != current.isRouteLoading ||
          previous.routeError != current.routeError,
      builder: (context, state) {
        if (state.isRouteLoading) {
          return Positioned(
            top: MediaQuery.of(context).padding.top + 10.h,
            left: 20.w,
            right: 20.w,
            child: Container(
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
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    'Calculating route...',
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state.routeError != null) {
          return Positioned(
            top: MediaQuery.of(context).padding.top + 10.h,
            left: 20.w,
            right: 20.w,
            child: Container(
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
                      state.routeError!,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorTheme.onErrorContainer,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: context.colorTheme.onErrorContainer),
                    onPressed: () {
                      context.read<MapCubit>().stopNavigation();
                    },
                  ),
                ],
              ),
            ),
          );
        }

        final route = state.activeRoute;
        if (route == null) return const SizedBox.shrink();

        final distanceKm = (route.distance / 1000).toStringAsFixed(1);
        final durationMin = (route.duration / 60).ceil();

        return Positioned(
          top: MediaQuery.of(context).padding.top + 10.h,
          left: 20.w,
          right: 20.w,
          child: Container(
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
                          color: context.colorTheme.onPrimaryContainer.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<MapCubit>().stopNavigation();
                  },
                  icon: Icon(
                    Icons.close,
                    color: context.colorTheme.onPrimaryContainer,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: context.colorTheme.surface.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
