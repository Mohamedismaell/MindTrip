import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service_imp.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_cubit.dart';
import 'package:mindtrip/features/map/presentation/cubit/map_navigation_cubit.dart';

class PlaceActions extends StatelessWidget {
  const PlaceActions({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.dragController,
  });

  final double? latitude;
  final double? longitude;
  final DraggableScrollableController dragController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50.h,
            child: FilledButton.icon(
              onPressed: () async {
                if (latitude == null || longitude == null) return;

                final locationService = sl<LocationService>();

                final position = await locationService.getCurrentLocation();

                if (position != null && context.mounted) {
                  context.read<MapCubit>().dismissBottomSheet();
                  context.read<MapNavigationCubit>().navigateToPosition(
                        Position(position.longitude, position.latitude),
                        latitude!,
                        longitude!,
                      );
                }
              },
              icon: const Icon(Icons.directions),
              label: const Text('Navigate Here'),
            ),
          ),
        ),

        SizedBox(width: 20.w),

        Expanded(
          child: SizedBox(
            height: 50.h,
            child: FilledButton.icon(
              onPressed: () async {
                if (latitude == null || longitude == null) return;

                if (dragController.isAttached) {
                  await dragController.animateTo(
                    0.1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }

                if (context.mounted) {
                  context.read<MapCubit>().triggerFlyTo(latitude!, longitude!);
                }
              },
              icon: const Icon(Icons.map),
              label: const Text('View on Map'),
            ),
          ),
        ),
      ],
    );
  }
}
