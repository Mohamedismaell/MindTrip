import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';
import 'package:mindtrip/core/shared/presentation/widget/appp_dialog.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_state.dart';
import 'package:mindtrip/features/add_to_trip/presentation/widgets/drag_divider.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddToTripSheet extends StatelessWidget {
  const AddToTripSheet({
    super.key,
    this.scrollController,
    required this.onBack,
    required this.onCreateNew,
    required this.onTripSelected,
  });

  final ScrollController? scrollController;
  final VoidCallback onBack;
  final VoidCallback onCreateNew;
  final ValueChanged<Trip> onTripSelected;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddToTripCubit, AddToTripState>(
      listener: (context, state) {
        if (state.status == AddToTripStatus.loading) {
          print('Loading opop op op po op po');
          AppDialog.showLoading(context: context);
        } else if (state.status == AddToTripStatus.initial) {
          AppDialog.hideLoading(context);
        } else if (state.status == AddToTripStatus.success) {
          print('Success opop op op po op po');
          AppDialog.hideLoading(context);
        } else if (state.status == AddToTripStatus.failure) {
          print('Failure opop op op po op po');
          AppDialog.hideLoading(context);
        }
      },
      builder: (context, state) {
        if (state.status == AddToTripStatus.failure && state.trips.isEmpty) {
          return AppErrorWidget(
            title: 'Failed to load trips',
            message: state.errorMessage,
            onPressed: () => context.read<AddToTripCubit>().loadTrips(),
          );
        }

        return Column(
          children: [
            const DragDivider(),
            SizedBox(height: 25.h),
            Text(
              'Add to a Trip',
              style: AppTextStyles.h6Bold.copyWith(color: AppColors.pureBlack),
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
                enabled:
                    state.status == AddToTripStatus.loading &&
                    state.trips.isEmpty,
                child: ListView.separated(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.trips.length + 1,
                  separatorBuilder: (_, _) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    if (index == state.trips.length) {
                      return _TripTile(
                        title: 'Create New Trip',
                        subtitle: 'Start planning with AI',
                        leadingIcon: Icons.add,
                        onTap: onCreateNew,
                      );
                    }
                    final trip = state.trips[index];
                    return _TripTile(
                      title: trip.title,
                      subtitle: '${trip.plan.daysCount} days',
                      imagePath: trip.coverImageUrl,
                      onTap: () => onTripSelected(trip),
                      placesCount: trip.plan.placesCount.toString(),
                    );
                  },
                ),
              ),
            ),
          ],
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
  final String? placesCount;
  const _TripTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.imagePath,
    this.leadingIcon,
    this.placesCount,
  });

  @override
  Widget build(BuildContext context) {
    return TapScaleEffect(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(8.w, 8.w, 21.w, 8.w),
        decoration: BoxDecoration(
          color: context.colorTheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20.r),

          border: Border.all(color: context.colorTheme.outline, width: 1.3),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: imagePath != null && imagePath!.isNotEmpty
                  ? SizedBox(
                      width: 100.w,
                      height: 100.h,
                      child: AppCachedImage(
                        imagePath: imagePath!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      width: 100.w,
                      height: 100.h,
                      color: context.colorTheme.primaryContainer,
                      alignment: Alignment.center,
                      child: Icon(
                        leadingIcon ?? Icons.map_outlined,
                        color: context.colorTheme.primary,
                      ),
                    ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.h8Bold),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        subtitle,
                        style: AppTextStyles.h9Medium.copyWith(
                          color: context.colorTheme.outline,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      if (placesCount != null)
                        Text(
                          '• $placesCount places',
                          style: AppTextStyles.h9Medium.copyWith(
                            color: context.colorTheme.outline,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: context.colorTheme.outline),
          ],
        ),
      ),
    );
  }
}
