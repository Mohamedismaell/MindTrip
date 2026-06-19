import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/features/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_head_line.dart';

class ExploreHeader extends StatelessWidget {
  const ExploreHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final user = state.user;
        final displayName = user?.displayName;
        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good morning, $displayName',
                style: AppTextStyles.h9Medium.copyWith(
                  color: context.colorTheme.outline,
                ),
              ),
              SizedBox(height: 12.h),
              CustomHeadLine(
                textAlign: TextAlign.left,
                firstTitle: 'Where do you\nwant to ',
                secondTitle: 'explore?',
                firstStyle: AppTextStyles.h5Bold.copyWith(
                  color: context.colorTheme.onSurface,
                ),
                secondStyle: AppTextStyles.h5Bold.copyWith(
                  color: context.colorTheme.primary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
