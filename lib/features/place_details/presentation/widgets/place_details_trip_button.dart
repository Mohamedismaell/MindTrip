import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/add_to_trip/add_to_trip_sheet.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/add_to_trip/create_trip_planner_sheet.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/add_to_trip/manage_place_sheet.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/add_to_trip/select_day_sheet.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlaceDetailsTripButton extends StatelessWidget {
  final PlaceEntity place;

  const PlaceDetailsTripButton({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddToTripCubit(
        place: place,
        tripRepository: sl(),
        addPlaceUseCase: sl(),
        removePlaceUseCase: sl(),
        movePlaceInTripUseCase: sl(),
        movePlaceBetweenTripsUseCase: sl(),
      )..init(),
      child: BlocBuilder<AddToTripCubit, AddToTripState>(
        builder: (context, state) {
          final buttonText =
              (state.placeAlreadyInTrip && state.hostTripName != null)
              ? 'Added to ${state.hostTripName}'
              : 'Add to your trip';

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Skeleton.shade(
              child: CustomGradientButton(
                width: double.infinity,
                onTap: () => _handleOnTap(context, state),
                text: buttonText,
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleOnTap(BuildContext context, AddToTripState state) {
    if (state.placeAlreadyInTrip) {
      context.read<AddToTripCubit>().openManage();
      _showSheet(context, const ManagePlaceSheet());
    } else {
      context.read<AddToTripCubit>().loadTrips();
      _showSheet(context, const AddToTripSheet());
    }
  }

  void _showSheet(BuildContext parentContext, Widget sheetContent) {
    final cubit = parentContext.read<AddToTripCubit>();
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return BlocProvider.value(
          value: cubit,
          child: BlocConsumer<AddToTripCubit, AddToTripState>(
            listener: (ctx2, state) {
              if (state.status == AddToTripStatus.selectDay) {
                Navigator.pop(ctx2);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _showSheet(parentContext, const SelectDaySheet());
                });
              } else if (state.status == AddToTripStatus.creatingNew) {
                Navigator.pop(ctx2);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _showSheet(parentContext, const CreateTripPlannerSheet());
                });
              } else if (state.status == AddToTripStatus.added) {
                Navigator.pop(ctx2);
                ScaffoldMessenger.of(ctx2).showSnackBar(
                  const SnackBar(content: Text('Successfully updated trip!')),
                );
              } else if (state.status == AddToTripStatus.initial &&
                  sheetContent is ManagePlaceSheet) {
                Navigator.pop(ctx2); // Closes manage sheet after removal
              } else if (state.status == AddToTripStatus.selectTrip &&
                  sheetContent is ManagePlaceSheet) {
                Navigator.pop(ctx2);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _showSheet(
                    parentContext,
                    const AddToTripSheet(),
                  ); // Move to another trip
                });
              }
            },
            builder: (ctx2, state) {
              return sheetContent;
            },
          ),
        );
      },
    );
  }
}
