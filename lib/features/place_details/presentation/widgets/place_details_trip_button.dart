import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_gradient_button.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_state.dart';
import 'package:mindtrip/features/add_to_trip/presentation/widgets/add_to_trip_flow_wrapper.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlaceDetailsTripButton extends StatelessWidget {
  final PlaceEntity place;

  const PlaceDetailsTripButton({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddToTripCubit(
        place: place,
        // getTripContainingPlace: sl(),
        // getAllTrips: sl(),
        // getItinerary: sl(),
        // addPlaceUseCase: sl(),
        // removePlaceUseCase: sl(),
        // movePlaceInTripUseCase: sl(),
        // movePlaceBetweenTripsUseCase: sl(),
        // getTripById: sl(),
        // saveTrip: sl(),
        generateItinerary: sl(),
        // saveItinerary: sl(),
      ),
      // ..init(),
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
                onTap: () => _handleOnTap(context),
                text: buttonText,
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleOnTap(BuildContext context) {
    showAddToTripSheet(context);
  }

  void showAddToTripSheet(BuildContext parentContext) {
    final cubit = parentContext.read<AddToTripCubit>();

    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,

      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          expand: false,
          builder: (_, controller) => ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: PrimaryScrollController(
              controller: controller,
              child: const AddToTripFlowWrapper(),
            ),
          ),
        ),
      ),
    );
  }
}
