import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_gradient_button.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_state.dart';
import 'package:mindtrip/features/add_to_trip/presentation/widgets/add_to_trip_flow_wrapper.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlaceDetailsTripButton extends StatelessWidget {
  final PlaceEntity place;

  const PlaceDetailsTripButton({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AddToTripCubit>(param1: place),
      child: BlocBuilder<AddToTripCubit, AddToTripState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Skeleton.shade(
              child: CustomGradientButton(
                width: double.infinity,
                onTap: () => _handleOnTap(context),
                text: 'Add to your trip',
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleOnTap(BuildContext context) {
    final cubit = context.read<AddToTripCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          expand: false,
          builder: (_, controller) => ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
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
