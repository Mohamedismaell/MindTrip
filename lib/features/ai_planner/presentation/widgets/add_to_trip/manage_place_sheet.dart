import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/app_snackbar.dart';
import 'package:mindtrip/core/widget/appp_dialog.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/add_to_trip/drag_divider.dart';

class ManagePlaceSheet extends StatelessWidget {
  const ManagePlaceSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddToTripCubit, AddToTripState>(
      listener: (context, state) {
        if (
        // state.tripsStatus == TripsLoadStatus.loading ||
        state.itineraryStatus == TripsLoadStatus.loading ||
            state.addingStatus == ActionStatus.processing ||
            state.creatingStatus == ActionStatus.processing) {
          AppDialog.showLoading(
            context: context,
            title: state.loadingTitle,
            description: state.loadingDescription,
          );
        } else {
          AppDialog.hideLoading(context);
        }
        if (state.addingStatus == ActionStatus.error) {
          AppSnackBar.showError(
            context: context,
            message: state.errorMessage ?? 'Failed to add to trip',
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            DragDivider(),
            SizedBox(height: 25.h),
            Text(
              'Manage Trip',
              style: AppTextStyles.h6Bold.copyWith(color: AppColors.pureBlack),
            ),
            SizedBox(height: 8.h),
            Text(
              'Update where this place is saved',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorTheme.outline,
              ),
            ),
            SizedBox(height: 26.h),
            _ManageActionItem(
              icon: Icons.calendar_today,
              title: 'Move to another day',
              onTap: () {
                context.read<AddToTripCubit>().goToDaySelection();
              },
            ),
            SizedBox(height: 12.h),
            _ManageActionItem(
              icon: Icons.swap_horiz,
              title: 'Move to another trip',
              onTap: () {
                context.read<AddToTripCubit>().goToTripSelection();
              },
            ),
            SizedBox(height: 12.h),
            _ManageActionItem(
              icon: Icons.delete_outline,
              title: 'Remove from trip',
              isDestructive: true,
              onTap: () {
                AppDialog.show(
                  context: context,
                  title: 'Remove Place?',
                  description:
                      'Are you sure you want to remove this place from your trip?',
                  primaryText: 'Cancel',
                  onPrimary: () {},
                  secondaryText: 'Remove',
                  onSecondary: () =>
                      context.read<AddToTripCubit>().removeFromTrip(),
                  iconColor: context.colorTheme.error,
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _ManageActionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ManageActionItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? context.colorTheme.error
        : context.colorTheme.onSurface;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(color: context.colorTheme.outline),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: context.textTheme.bodyLarge?.copyWith(color: color),
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
