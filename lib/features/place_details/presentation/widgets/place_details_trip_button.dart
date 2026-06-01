import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/features/place_details/presentation/widgets/add_to_trip_sheet.dart';

class PlaceDetailsTripButton extends StatelessWidget {
  final PlaceEntity place;

  const PlaceDetailsTripButton({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: CustomGradientButton(
        width: double.infinity,
        onTap: () => showAddToTripSheet(context, place: place),
        text: 'Add to your trip',
      ),
    );
  }
}
