import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';

class PlaceDetailsInfoChips extends StatelessWidget {
  final PlaceEntity place;

  const PlaceDetailsInfoChips({super.key, required this.place});
  //Todo Edit with real info
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _OutlinedInfoChip(label: '2-3 Hours', emoji: '🕛'),
        SizedBox(width: 16.w),
        _OutlinedInfoChip(
          label: place.price == null || place.price == 0
              ? 'Free entry'
              : 'Moderate budget',
          emoji: '💰',
        ),
      ],
    );
  }
}

class _OutlinedInfoChip extends StatelessWidget {
  final String emoji;
  final String label;

  const _OutlinedInfoChip({required this.label, required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(9.r),
        border: Border.all(color: context.colorTheme.outline),
      ),
      child: Row(
        children: [
          Text(emoji),
          SizedBox(width: 8.w),
          Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.h8Medium.copyWith(),
          ),
        ],
      ),
    );
  }
}
