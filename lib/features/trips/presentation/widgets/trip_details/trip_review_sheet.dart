import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_gradient_button.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';

class TripReviewSheet extends StatefulWidget {
  const TripReviewSheet({
    super.key,
    required this.onSubmitted,
  });

  final Function(double rating, String comment) onSubmitted;

  static Future<void> show(
    BuildContext context,
    Function(double rating, String comment) onSubmitted,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TripReviewSheet(onSubmitted: onSubmitted),
    );
  }

  @override
  State<TripReviewSheet> createState() => _TripReviewSheetState();
}

class _AiPlannerTextField extends StatelessWidget {
  const _AiPlannerTextField({
    required this.controller,
    required this.hintText,
  });

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.h9Medium.copyWith(
          color: context.colorTheme.outline,
        ),
        filled: true,
        fillColor: AppColors.primaryLightGray.withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.all(16.r),
      ),
    );
  }
}

class _TripReviewSheetState extends State<TripReviewSheet> {
  double _rating = 5;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20.h,
        left: 20.w,
        right: 20.w,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: context.colorTheme.outline.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Write a Review',
            style: AppTextStyles.h6Bold,
          ),
          SizedBox(height: 8.h),
          Text(
            'How was your trip experience?',
            style: AppTextStyles.h9Medium.copyWith(
              color: context.colorTheme.outline,
            ),
          ),
          SizedBox(height: 24.h),
          RatingBar.builder(
            initialRating: 5,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0.w),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),
          SizedBox(height: 24.h),
          _AiPlannerTextField(
            controller: _commentController,
            hintText: 'Share your thoughts about this trip...',
          ),
          SizedBox(height: 32.h),
          CustomGradientButton(
            text: 'Submit Review',
            onTap: () {
              widget.onSubmitted(_rating, _commentController.text);
              Navigator.pop(context);
            },
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
