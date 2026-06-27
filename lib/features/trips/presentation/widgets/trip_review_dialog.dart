import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/appp_dialog.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';

class TripReviewDialog {
  static Future<void> show(
    BuildContext context, {
    required String tripTitle,
    required Function(double rating, String comment) onSubmitted,
  }) {
    double rating = 4;
    final controller = TextEditingController();

    return AppDialog.show(
      context: context,
      title: 'Rate your experience',
      showIcon: false,
      showCloseButton: true,
      description: 'How was your trip to $tripTitle?',
      child: TapRegion(
        behavior: HitTestBehavior.opaque,
        onTapOutside: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RatingBar.builder(
                  initialRating: 4,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (val) {
                    rating = val;
                  },
                ),
                SizedBox(height: 24.h),
                TextField(
                  controller: controller,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Share your feedback and tips',
                    hintStyle: AppTextStyles.h9Medium.copyWith(
                      color: context.colorTheme.outline.withValues(alpha: 0.6),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide(
                        color: context.colorTheme.outline.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide(color: context.colorTheme.primary),
                    ),
                    contentPadding: EdgeInsets.all(16.r),
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            );
          },
        ),
      ),
      primaryText: 'Write a review',
      onPrimary: () {
        onSubmitted(rating, controller.text);
      },
      secondaryText: 'Cancel',
      isSecondaryPlain: true,
      onSecondary: () {},
    );
  }
}
