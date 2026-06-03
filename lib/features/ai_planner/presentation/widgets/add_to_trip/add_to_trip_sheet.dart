import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/tap_scale_effect.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/add_to_trip/drag_divider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddToTripSheet extends StatelessWidget {
  const AddToTripSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddToTripCubit, AddToTripState>(
      builder: (context, state) {
        if (state.tripsStatus == TripsLoadStatus.error) {
          //Todo change the ui
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, size: 48.r, color: Colors.red),
                SizedBox(height: 16.h),
                Text('Failed to load trips', style: AppTextStyles.h6Bold),
                SizedBox(height: 8.h),
                Text(
                  state.errorMessage ?? 'Please check your connection',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium,
                ),
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: () => context.read<AddToTripCubit>().loadTrips(),
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }

        return Container(
          padding: EdgeInsets.only(
            left: 30.w,
            right: 30.w,
            top: 29.h,
            bottom: 24.h,
          ),
          decoration: BoxDecoration(
            color: context.colorTheme.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DragDivider(),
              SizedBox(height: 25.h),
              Text(
                'Add to a Trip',
                style: AppTextStyles.h6Bold.copyWith(
                  color: AppColors.pureBlack,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Choose where you want to add this place',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorTheme.outline,
                ),
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: Skeletonizer(
                  enabled: state.tripsStatus == TripsLoadStatus.loading,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                        state.trips.isEmpty &&
                            state.tripsStatus == TripsLoadStatus.loading
                        ? 2
                        : state.trips.length + 1,
                    separatorBuilder: (_, _) => SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      if (state.trips.isEmpty &&
                          state.tripsStatus == TripsLoadStatus.loading) {
                        return _TripTile(
                          title: 'Loading Trip Title',
                          subtitle: 'Loading description...',
                          onTap: () {},
                        );
                      }

                      if (index == state.trips.length) {
                        return _TripTile(
                          title: 'Create New Trip',
                          subtitle: 'Start planning with AI',
                          leadingIcon: Icons.add,
                          onTap: () =>
                              context.read<AddToTripCubit>().triggerCreateNew(),
                        );
                      }
                      final trip = state.trips[index];
                      final coverImage =
                          trip.itineraryCoverUrl ?? trip.coverAsset;
                      final placesCount = trip.placePreviews.length;
                      return _TripTile(
                        title: trip.title,
                        subtitle:
                            '${trip.durationDays} days · $placesCount places',
                        imagePath: coverImage,
                        onTap: () =>
                            context.read<AddToTripCubit>().selectTrip(trip),
                      );
                    },
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

class _TripTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? imagePath;
  final VoidCallback onTap;
  final IconData? leadingIcon;

  const _TripTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.imagePath,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TapScaleEffect(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          border: Border.all(color: context.colorTheme.outline),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: imagePath != null
                  ? AppCachedImage(
                      width: 84.w,
                      height: 84.h,
                      imagePath: imagePath,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: 84.w,
                      height: 84.h,
                      color: AppColors.primaryLightGray,
                      alignment: Alignment.center,
                      child: Skeleton.ignore(
                        child: Icon(
                          leadingIcon ?? Icons.add,
                          size: 30.r,
                          color: context.colorTheme.onSurfaceVariant,
                        ),
                      ),
                    ),
            ),
            SizedBox(width: 13.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.h8SemiBold.copyWith(
                      color: context.colorTheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    subtitle,
                    style: AppTextStyles.h9Medium.copyWith(
                      color: context.colorTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 24.r,
              color: context.colorTheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
