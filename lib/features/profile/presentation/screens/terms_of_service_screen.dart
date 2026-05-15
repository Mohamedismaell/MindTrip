import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_legal_content.dart';
import 'package:mindtrip/features/profile/presentation/widgets/legal/legal_scaffold.dart';
import 'package:mindtrip/features/profile/presentation/widgets/legal/legal_section_body.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LegalScaffold(
      title: 'Terms of service',
      child: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 32.h),
        children: const [
          _TermsIntroCard(),
          _TermsTimeline(sections: ProfileLegalContent.termsSections),
        ],
      ),
    );
  }
}

class _TermsIntroCard extends StatelessWidget {
  const _TermsIntroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('terms-intro-card'),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLightBlue1,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hello 👋', style: context.textTheme.headlineSmall),
          SizedBox(height: 14.h),
          Text(
            'Before using MindTrip, please read these Terms of Service carefully. By using the app, you agree to these terms.',
            style: context.textTheme.labelLarge?.copyWith(
              color: context.colorTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _TermsTimeline extends StatelessWidget {
  const _TermsTimeline({required this.sections});

  final List<ProfileLegalSection> sections;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.h),
      child: Column(
        children: sections.indexed.map((entry) {
          final isLast = entry.$1 == sections.length - 1;
          return _AnimatedTimelineSection(
            section: entry.$2,
            index: entry.$1,
            isLast: isLast,
          );
        }).toList(),
      ),
    );
  }
}

class _AnimatedTimelineSection extends StatelessWidget {
  const _AnimatedTimelineSection({
    required this.section,
    required this.index,
    required this.isLast,
  });

  final ProfileLegalSection section;
  final int index;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 28.w,
            child: Column(
              children: [
                Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    color: context.colorTheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1,
                      color: AppColors.mediumLightGray.withValues(alpha: 0.7),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: 19.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24.h),
              child: LegalSectionBody(section: section),
            ),
          ),
        ],
      ),
    );
  }
}
