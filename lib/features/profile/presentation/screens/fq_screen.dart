import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_legal_content.dart';
import 'package:mindtrip/features/profile/presentation/widgets/legal/legal_scaffold.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  String _query = '';
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    final normalizedQuery = _query.trim().toLowerCase();
    final items = ProfileLegalContent.faqs.where((item) {
      if (normalizedQuery.isEmpty) return true;
      return item.question.toLowerCase().contains(normalizedQuery) ||
          item.answer.toLowerCase().contains(normalizedQuery);
    }).toList();

    return LegalScaffold(
      title: 'FAQs',
      child: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 32.h),
        children: [
          RichText(
            text: TextSpan(
              style: context.textTheme.headlineSmall?.copyWith(
                color: AppColors.pureBlack,
              ),
              children: [
                const TextSpan(
                  text: "We're here to help you plan better\ntrips with ",
                ),
                TextSpan(
                  text: 'MindTrip',
                  style: TextStyle(color: context.colorTheme.primary),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'At MindTrip, our goal is to make your travel planning easier, '
            'faster, and more personalized.\nIf you need help, you can search '
            'below or check the frequently asked questions.',
            style: context.textTheme.bodyLarge?.copyWith(
              fontSize: 18.sp,
              color: context.colorTheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 26.h),
          Text(
            'Frequently asked questions',
            style: context.textTheme.headlineSmall?.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.pureBlack,
            ),
          ),
          SizedBox(height: 14.h),
          if (items.isEmpty)
            Padding(
              padding: EdgeInsets.only(top: 18.h),
              child: Text(
                'No questions found.',
                key: const Key('faq-empty-state'),
                style: context.textTheme.bodyLarge?.copyWith(
                  fontSize: 18.sp,
                  color: AppColors.mediumLightGray,
                ),
              ),
            )
          else
            _FaqList(
              items: items,
              expandedIndex: _expandedIndex,
              onToggle: (index) {
                setState(() {
                  _expandedIndex = _expandedIndex == index ? null : index;
                });
              },
            ),
        ],
      ),
    );
  }
}

class _FaqList extends StatelessWidget {
  const _FaqList({
    required this.items,
    required this.expandedIndex,
    required this.onToggle,
  });

  final List<ProfileFaqItem> items;
  final int? expandedIndex;
  final ValueChanged<int> onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.indexed.map((entry) {
        final index = entry.$1;
        return _FaqAccordionRow(
          item: entry.$2,
          isExpanded: expandedIndex == index,
          onTap: () => onToggle(index),
        );
      }).toList(),
    );
  }
}

class _FaqAccordionRow extends StatelessWidget {
  const _FaqAccordionRow({
    required this.item,
    required this.isExpanded,
    required this.onTap,
  });

  final ProfileFaqItem item;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.mediumLightGray.withValues(alpha: 0.45),
          ),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(item.question, style: AppTextStyles.h8Medium),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOutCubic,
                    child: Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.darkGray1),
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 18.sp,
                        color: AppColors.darkGray1,
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox(width: double.infinity),
                secondChild: Padding(
                  padding: EdgeInsets.only(top: 14.h),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item.answer,
                      key: Key('faq-answer-${item.question}'),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorTheme.outline,
                      ),
                    ),
                  ),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
                firstCurve: Curves.easeOutCubic,
                secondCurve: Curves.easeOutCubic,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
