import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/appp_dialog.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/presentation/widgets/rename_trip_dialog.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/trips/presentation/share_trip/trip_share_cubit.dart';

class TripMenuButton extends StatelessWidget {
  const TripMenuButton({super.key, required this.trip});
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    const String rename = 'rename';
    const String delete = 'delete';
    const String share = 'share';

    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert_rounded,
        size: 20.sp,
        color: context.colorTheme.onSurface,
      ),
      elevation: 2,
      position: PopupMenuPosition.under,
      offset: const Offset(-25, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      onSelected: (value) async {
        if (value == rename) {
          showRenameTripDialog(
            context,
            tripId: trip.tripId,
            currentTitle: trip.title,
          );
        } else if (value == delete) {
          await AppDialog.show(
            context: context,
            title: 'Delete Trip',
            description: 'Are you sure you want to delete this trip?',
            primaryText: 'Cancel',
            onPrimary: () {},
            onSecondary: () {
              context.read<TripsCubit>().deleteTrip(trip.tripId);
            },
            secondaryText: 'Delete',
          );
        } else if (value == share) {
          context.read<TripShareCubit>().shareTrip(
                context: context,
                trip: trip,
              );
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
          value: share,
          child: Row(
            children: [
              Icon(Icons.share_outlined, size: 22.sp),
              SizedBox(width: 10.w),
              Text('Share', style: context.textTheme.bodyLarge),
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
                'Delete',
                style: context.textTheme.bodyLarge?.copyWith(color: Colors.red),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
