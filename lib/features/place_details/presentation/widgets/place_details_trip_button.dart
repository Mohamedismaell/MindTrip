import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';

class PlaceDetailsTripButton extends StatelessWidget {
  const PlaceDetailsTripButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: CustomGradientButton(
        width: double.infinity,
        onTap: () {},
        text: 'Add to your trip',
      ),
    );
  }
}
