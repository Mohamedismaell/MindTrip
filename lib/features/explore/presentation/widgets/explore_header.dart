import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

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
              RichText(
                text: TextSpan(
                  style: context.textTheme.headlineMedium,
                  children: [
                    const TextSpan(text: 'Where do you\nwant to '),
                    TextSpan(
                      text: 'explore?',
                      style: AppTextStyles.h5Bold.copyWith(
                        color: context.colorTheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
