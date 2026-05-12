import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_legal_content.dart';
import 'package:mindtrip/features/profile/presentation/widgets/legal/legal_scaffold.dart';
import 'package:mindtrip/features/profile/presentation/widgets/legal/legal_section_body.dart';

class UserPolicyScreen extends StatelessWidget {
  const UserPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LegalScaffold(
      title: 'User Policy',
      child: ListView(
        padding: EdgeInsets.fromLTRB(26.w, 4.h, 26.w, 32.h),
        children: [
          Text(
            'Last update : 11 May 2026',
            key: const Key('user-policy-last-update'),
            style: context.textTheme.labelLarge?.copyWith(
              color: context.colorTheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 34.h),
          ...ProfileLegalContent.policySections.indexed.map((entry) {
            return _AnimatedPolicySection(section: entry.$2, index: entry.$1);
          }),
        ],
      ),
    );
  }
}

class _AnimatedPolicySection extends StatelessWidget {
  const _AnimatedPolicySection({required this.section, required this.index});

  final ProfileLegalSection section;
  final int index;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 220 + (index * 50)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 12.h),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: LegalSectionBody(section: section),
      ),
    );
  }
}
