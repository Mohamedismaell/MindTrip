import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';

class PlaceDetailsOverview extends StatefulWidget {
  final PlaceEntity place;

  const PlaceDetailsOverview({super.key, required this.place});

  @override
  State<PlaceDetailsOverview> createState() => _PlaceDetailsOverviewState();
}

class _PlaceDetailsOverviewState extends State<PlaceDetailsOverview> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final description = widget.place.description?.trim();

    if (description == null || description.isEmpty) {
      return const SizedBox.shrink();
    }

    final shouldTruncate = description.length > 155;

    final displayedText = isExpanded || !shouldTruncate
        ? description
        : '${description.substring(0, 155).trimRight()}...';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: context.textTheme.labelMedium?.copyWith(
            color: AppColors.pureBlack,
          ),
        ),
        SizedBox(height: 10.h),

        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: RichText(
            text: TextSpan(
              style: context.textTheme.bodyLarge,
              children: [
                TextSpan(text: displayedText),

                if (shouldTruncate)
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Text(
                          isExpanded ? 'See Less' : 'See More',
                          style: AppTextStyles.h8Bold.copyWith(
                            color: context.colorTheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
