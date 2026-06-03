import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/app_snackbar.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_state.dart';

class ManagePlaceSheet extends StatelessWidget {
  const ManagePlaceSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddToTripCubit, AddToTripState>(
      listener: (context, state) {
        if (state.addingStatus == ActionStatus.error &&
            state.errorMessage != null) {
          AppSnackBar.showError(
            context: context,
            message: state.errorMessage ?? 'Operation failed',
          );
        }
      },
      builder: (context, state) {
        if (state.hostTripName == null) return const SizedBox.shrink();

        return Container(
          padding: EdgeInsets.only(
            left: 24.w,
            right: 24.w,
            top: 24.h,
            bottom: 24.h,
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
                'Added to ${state.hostTripName}',
                style: AppTextStyles.h4SemiBold.copyWith(
                    color: context.colorTheme.onSurface),
              ),
              SizedBox(height: 24.h),
              if (state.addingStatus == ActionStatus.processing)
                Padding(
                  padding: EdgeInsets.all(32.0.r),
                  child: const Center(child: CircularProgressIndicator()),
                )
              else ...[
                _ManageActionItem(
                  icon: Icons.calendar_today,
                  title: 'Move to another day',
                  onTap: () {
                    final trip = state.trips.firstWhere(
                        (t) => t.id == state.hostTripId,
                        orElse: () => state.trips.first);
                    context.read<AddToTripCubit>().selectTrip(trip);
                  },
                ),
                SizedBox(height: 12.h),
                _ManageActionItem(
                  icon: Icons.swap_horiz,
                  title: 'Move to another trip',
                  onTap: () {
                    context.read<AddToTripCubit>().loadTrips();
                  },
                ),
                SizedBox(height: 12.h),
                _ManageActionItem(
                  icon: Icons.delete_outline,
                  title: 'Remove from trip',
                  isDestructive: true,
                  onTap: () {
                    _showRemoveConfirmation(context);
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _showRemoveConfirmation(BuildContext context) {
    final cubit = context.read<AddToTripCubit>();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove Place?'),
        content: const Text(
            'Are you sure you want to remove this place from your trip?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              cubit.removeFromTrip();
            },
            child: const Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
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
            Icon(Icons.chevron_right,
                color: context.colorTheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}
