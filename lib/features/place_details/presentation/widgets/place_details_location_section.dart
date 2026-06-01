import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/custom_otlined_button.dart';

class PlaceDetailsLocationSection extends StatelessWidget {
  final PlaceEntity place;

  const PlaceDetailsLocationSection({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: context.textTheme.labelMedium?.copyWith(
            color: AppColors.pureBlack,
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: double.infinity,
          height: 158.h,
          child: SvgPicture.asset('assets/images/map/place_preview.svg'),
        ),
        SizedBox(height: 14.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 42.w),
          child: CustomOtlinedButton(
            onPressed: () {},
            icon: Icons.open_in_new_rounded,
            color: context.colorTheme.primary,
            text: 'Open full map',
          ),
        ),
      ],
    );
  }
}
