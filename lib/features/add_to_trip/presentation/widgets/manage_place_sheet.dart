import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/appp_dialog.dart';
import 'package:mindtrip/core/shared/presentation/widget/glss_snack_bar.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_state.dart';
import 'package:mindtrip/features/add_to_trip/presentation/widgets/drag_divider.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/generating_loading_dialog.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

class ManagePlaceSheet extends StatelessWidget {
  const ManagePlaceSheet({
    super.key,
    required this.trip,
    required this.onMoveToDay,
    required this.onClose,
  });

  final Trip trip;
  final VoidCallback onMoveToDay;
  final VoidCallback onClose;

  void _showLoading(BuildContext context, Widget dialog) {
    AppDialog.hideLoading(context);
    if (!(ModalRoute.of(context)?.isCurrent ?? true)) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => dialog,
    );
  }

  void _handleStatus(BuildContext context, AddToTripState state) {
    if (state.status == AddToTripStatus.removingFromTrip) {
      _showLoading(
        context,
        const GeneratingDialog(
          title: 'Updating trip...',
          description: 'Please wait while we update your trip.',
        ),
      );
      return;
    }

    if (state.status == AddToTripStatus.success) {
      AppDialog.hideLoading(context);
      AppGlassSnackBar.showSuccess(
        context: context,
        message: 'Place removed from trip.',
      );
      onClose();
      return;
    }

    if (state.status == AddToTripStatus.removingFailure) {
      AppDialog.hideLoading(context);
      AppGlassSnackBar.showError(context: context, message: state.errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddToTripCubit, AddToTripState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: _handleStatus,
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const DragDivider(),
            SizedBox(height: 25.h),
            Text(
              'Manage Trip',
              style: AppTextStyles.h6Bold.copyWith(color: AppColors.pureBlack),
            ),
            SizedBox(height: 6.h),
            Text(
              'This place is already in "${trip.title}"',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorTheme.outline,
              ),
            ),
            SizedBox(height: 28.h),
            _ManageActionItem(
              icon: Icons.calendar_today_outlined,
              title: 'Move to another day',
              subtitle: 'Change the day within "${trip.title}"',
              onTap: () {
                context.read<AddToTripCubit>().selectTrip(trip);
                onMoveToDay();
              },
            ),
            SizedBox(height: 12.h),
            _ManageActionItem(
              icon: Icons.delete_outline_rounded,
              title: 'Remove from trip',
              subtitle: 'Delete this place from "${trip.title}"',
              isDestructive: true,
              onTap: () {
                AppDialog.show(
                  context: context,
                  icon: Icons.delete_outline_rounded,
                  iconColor: context.colorTheme.error,
                  title: 'Remove Place?',
                  description:
                      'Are you sure you want to remove this place from your trip?',
                  primaryText: 'Cancel',
                  onPrimary: () {},
                  secondaryText: 'Remove',
                  onSecondary: () {
                    context.read<AddToTripCubit>().removeFromTrip(trip);
                  },
                );
              },
            ),
            SizedBox(height: 32.h),
          ],
        );
      },
    );
  }
}

class _ManageActionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ManageActionItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? context.colorTheme.error
        : context.colorTheme.onSurface;
    return TapScaleEffect(
      enableOverlay: false,
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: isDestructive
                ? context.colorTheme.error.withValues(alpha: 0.4)
                : context.colorTheme.outline,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: isDestructive
                    ? context.colorTheme.error.withValues(alpha: 0.1)
                    : context.colorTheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isDestructive
                    ? context.colorTheme.error
                    : AppColors.pureWhite,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.bodyLarge?.copyWith(color: color),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorTheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
