import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/domain/entities/review_entity.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.data,
    this.onEdit,
    this.onDelete,
  });

  final ReviewEntity data;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final showActions = onEdit != null || onDelete != null;
    final formattedDate = data.createdAt != null
        ? DateFormat('d MMMM yyyy').format(data.createdAt!)
        : '';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLightGray,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.location,
                      style: AppTextStyles.h8Bold.copyWith(
                        color: context.colorTheme.onSurface,
                      ),
                    ),
                    if (formattedDate.isNotEmpty) ...[
                      SizedBox(height: 6.h),
                      Text(
                        formattedDate,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorTheme.outline,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (showActions)
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert_rounded,
                    size: 24.sp,
                    color: context.colorTheme.onSurfaceVariant,
                  ),
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem<String>(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            size: 20.sp,
                            color: Colors.black,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'Edit Review',
                            style: AppTextStyles.h9Bold.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline_rounded,
                            size: 20.sp,
                            color: Colors.red,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'Delete Review',
                            style: AppTextStyles.h9Bold.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'edit' && onEdit != null) {
                      onEdit!();
                    } else if (value == 'delete' && onDelete != null) {
                      onDelete!();
                    }
                  },
                ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: List.generate(
              5,
              (index) {
                final isFilled = index < data.rating.round();
                return Padding(
                  padding: EdgeInsets.only(right: 2.w),
                  child: Icon(
                    Icons.star_rounded,
                    size: 20.sp,
                    color: isFilled ? const Color(0xFFF8BD00) : Colors.grey.shade400,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 18.h),
          Text(
            data.body,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
