import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_state.dart';

class AddToTripSheet extends StatelessWidget {
  const AddToTripSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddToTripCubit, AddToTripState>(
      listener: (context, state) {
        if (state.status == AddToTripStatus.error &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(
            left: 24.w,
            right: 24.w,
            top: 24.h,
            bottom: MediaQuery.of(context).padding.bottom + 24.h,
          ),
          decoration: BoxDecoration(
            color: context.colorTheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryLightGray,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Add to a Trip',
                style: AppTextStyles.h4SemiBold.copyWith(
                  color: context.colorTheme.onSurface,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Choose where you want to add this place',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorTheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 24.h),
              if (state.status == AddToTripStatus.loadingTrips)
                const Center(child: CircularProgressIndicator())
              else
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.trips.length + 1,
                    separatorBuilder: (_, _) => SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      if (index == state.trips.length) {
                        return _CreateNewTripTile(
                          onTap: () =>
                              context.read<AddToTripCubit>().triggerCreateNew(),
                        );
                      }
                      final trip = state.trips[index];
                      return _TripListTile(
                        trip: trip,
                        onTap: () {
                          context.read<AddToTripCubit>().selectTrip(trip);
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _TripListTile extends StatelessWidget {
  final Trip trip;
  final VoidCallback onTap;

  const _TripListTile({required this.trip, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final coverImage = trip.itineraryCoverUrl ?? trip.coverAsset;
    final placesCount = trip.placePreviews.length;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          border: Border.all(color: context.colorTheme.outline),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 64.w,
                height: 48.w,
                child: AppCachedImage(imagePath: coverImage, fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(trip.title, style: context.textTheme.bodyLarge),
                  SizedBox(height: 4.h),
                  Text(
                    '${trip.durationDays} days · $placesCount places',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: context.colorTheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateNewTripTile extends StatelessWidget {
  final VoidCallback onTap;

  const _CreateNewTripTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          border: Border.all(color: context.colorTheme.outline),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 64.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: AppColors.primaryLightGray,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.add,
                color: context.colorTheme.onSurfaceVariant,
              ),
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Create New Trip', style: context.textTheme.bodyLarge),
                SizedBox(height: 4.h),
                Text(
                  'Start planning with AI',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right,
              color: context.colorTheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
