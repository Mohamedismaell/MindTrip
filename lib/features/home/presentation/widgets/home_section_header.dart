import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';

class HomeSectionHeader extends StatelessWidget {
  const HomeSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actionLabel = 'See More',
    this.showSeeMore = false,
    this.onSeeMore,
  });

  final String title;
  final String? subtitle;
  final bool showSeeMore;
  final String actionLabel;
  final VoidCallback? onSeeMore;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Hero(
                    tag: 'section_$title',
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        title,
                        style: context.textTheme.headlineSmall,
                      ),
                    ),
                  ),
                ),
                showSeeMore
                    ? TapScaleEffect(
                        onTap: onSeeMore ?? () {},
                        child: Text(
                          actionLabel,
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: context.colorTheme.onSurfaceVariant,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            if (subtitle != null) ...[
              SizedBox(height: 4.h),
              Text(
                subtitle!,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: context.colorTheme.outline,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
