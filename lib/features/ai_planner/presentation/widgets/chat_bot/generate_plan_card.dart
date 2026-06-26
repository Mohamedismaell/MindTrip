import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/models/interest_categories.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/data/models/generate_plan_request_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/collected_planner_data_entity.dart';

class GeneratePlanCard extends StatelessWidget {
  const GeneratePlanCard({
    super.key,
    required this.collected,
    required this.aiMessage,
    required this.onGenerate,
  });

  final CollectedPlannerDataEntity collected;
  final String aiMessage;
  final void Function(GeneratePlanRequestModel request, {DateTime? tripStart})
  onGenerate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: context.colorTheme.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: context.colorTheme.primary.withValues(alpha: .15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(),

          SizedBox(height: 18.h),

          _SummaryGrid(collected: collected),

          SizedBox(height: 16.h),

          _InterestSection(interests: collected.interests),

          SizedBox(height: 16.h),

          // _SuccessBanner(message: aiMessage),

          // SizedBox(height: 18.h),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                onGenerate(
                  GeneratePlanRequestModel(
                    city: collected.destination,
                    days: collected.days,
                    people: collected.people,
                    budget: collected.budget,
                    interests: collected.interests,
                  ),
                  tripStart: DateTime.parse(collected.date!),
                );
              },
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Generate Trip Plan'),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 42.w,
                    height: 42.w,
                    decoration: BoxDecoration(
                      color: context.colorTheme.primary.withValues(alpha: .1),
                      shape: BoxShape.circle,
                    ),

                    child: Icon(
                      Icons.auto_awesome,
                      color: context.colorTheme.primary,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text("All set!", style: AppTextStyles.h6Bold),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                "I've got everything I need to build your trip.",
                style: AppTextStyles.h9Regular.copyWith(
                  color: context.colorTheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: AppCachedImage(
            imagePath: 'assets/images/ai_planner/travelefromgemini.webp',
          ),
        ),
      ],
    );
  }
}

class _SummaryGrid extends StatelessWidget {
  const _SummaryGrid({required this.collected});

  final CollectedPlannerDataEntity collected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colorTheme.outline.withValues(alpha: .15),
        ),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _InfoTile(
                  icon: Icons.location_on,
                  title: 'Destination',
                  value: collected.destination,
                ),
              ),
              Expanded(
                child: _InfoTile(
                  icon: Icons.calendar_today,
                  title: 'Duration',
                  value: '${collected.days} Days',
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(height: 1, color: context.colorTheme.outline),
          ),

          Row(
            children: [
              Expanded(
                child: _InfoTile(
                  icon: Icons.people,
                  title: 'Travelers',
                  value:
                      '${collected.people} ${collected.people == 1 ? "Person" : "People"}',
                ),
              ),
              Expanded(
                child: _InfoTile(
                  icon: Icons.account_balance_wallet,
                  title: 'Budget',
                  value: '${collected.budget} EGP',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: [
          Icon(icon, color: context.colorTheme.primary),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.h10Regular.copyWith(
                    color: context.colorTheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(value, style: AppTextStyles.h8SemiBold),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InterestSection extends StatelessWidget {
  const _InterestSection({required this.interests});

  final List<String> interests;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Interests', style: AppTextStyles.h9SemiBold),

        SizedBox(height: 8.h),

        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: interests.map((interest) {
            return Chip(
              label: Text(
                InterestCategories.withEmoji(interest),
                style: context.textTheme.bodyMedium,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// class _SuccessBanner extends StatelessWidget {
//   const _SuccessBanner({required this.message});

//   final String message;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(14.r),
//       decoration: BoxDecoration(
//         color: Colors.green.withValues(alpha: .08),
//         borderRadius: BorderRadius.circular(14.r),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Icon(Icons.check_circle, color: Colors.green),

//           SizedBox(width: 12.w),

//           Expanded(child: Text(message, style: AppTextStyles.h10Regular)),
//         ],
//       ),
//     );
//   }
// }
