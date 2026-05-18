import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trips/rename_trip_dialog.dart';

class TripMenuButton extends StatelessWidget {
  const TripMenuButton({super.key, required this.trip});
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    final rename = 'reame';
    final delete = 'delete';
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert_rounded,
        size: 20.sp,
        color: context.colorTheme.onSurface,
      ),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      onSelected: (value) {
        if (value == rename) {
          showRenameTripDialog(
            context,
            tripId: trip.id,
            currentTitle: trip.title,
          );
        } else if (value == delete) {
          context.read<TripsCubit>().deleteTrip(trip.id);
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          value: rename,
          child: Row(
            children: [
              Icon(Icons.edit_outlined, size: 22.sp),
              SizedBox(width: 10.w),
              Text('Rename', style: context.textTheme.bodyLarge),
            ],
          ),
        ),

        PopupMenuItem(
          value: delete,
          child: Row(
            children: [
              Icon(
                Icons.delete_outline_rounded,
                size: 22.sp,
                color: Colors.red,
              ),
              SizedBox(width: 10.w),
              Text(
                'Delete Draft',
                style: context.textTheme.bodyLarge?.copyWith(color: Colors.red),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
