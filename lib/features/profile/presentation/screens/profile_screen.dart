import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/profile/presentation/manager/profile_reviews_cubit.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile/my_reviews_section.dart';
import 'package:mindtrip/features/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_gradient_button.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_mock_data.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile/interest_chip.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile/mytrips_section.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile/profile_identity.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile/section_heading.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile/stats_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileReviewsCubit>()..getReviews(),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          final user = state.user;
          final displayName = user?.displayName ?? 'Traveler';
          final photoUrl = user?.profilePhotoUrl;
          final interests = user?.interests;
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) return;
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(AppRoutes.home);
              }
            },
            child: Scaffold(
              backgroundColor: context.colorTheme.surface,
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TapScaleEffect(
                        onTap: () => context.push(AppRoutes.profileSettings),
                        borderRadius: BorderRadius.circular(25.r),
                        child: Container(
                          width: 50.w,
                          height: 50.w,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryLightGray,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.settings,
                            size: 28.sp,
                            color: context.colorTheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      SizedBox(height: 18.h),
                      ProfileIdentity(
                        displayName: displayName,
                        photoUrl: photoUrl,
                      ),
                      SizedBox(height: 24.h),
                      const _EditprofileButoon(),
                      SizedBox(height: 34.h),
                      Center(child: StatsCard(stats: ProfileMockData.stats)),
                      SizedBox(height: 28.h),
                      SectionHeading(
                        title: 'My interests',
                        trailing: SizedBox(
                          width: 20.w,
                          child: TapScaleEffect(
                            onTap: () {
                              context.push(AppRoutes.interests, extra: true);
                            },
                            child: SvgPicture.asset(
                              ProfileAssets.editIcon,
                              colorFilter: ColorFilter.mode(
                                context.colorTheme.onSurface,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      if (interests != null && interests.isNotEmpty) ...[
                        Wrap(
                          spacing: 12.w,
                          runSpacing: 18.h,
                          children: interests
                              .map((interest) => InterestChip(interest: interest))
                              .toList(),
                        ),
                      ],
                      SizedBox(height: 26.h),
                      SectionHeading(
                        title: 'My Trips',
                        actionText: 'See all',
                        onActionTap: () => context.push(AppRoutes.myTrips),
                      ),
                      SizedBox(height: 18.h),
                      const MyTripsSection(),
                      SizedBox(height: 28.h),
                      const MyReviewsSection(),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _EditprofileButoon extends StatelessWidget {
  const _EditprofileButoon();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomGradientButton(
        onTap: () => context.push(AppRoutes.editProfile),
        width: 170.w,
        text: "Edit Profile",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20.w,
              child: SvgPicture.asset(ProfileAssets.editIcon),
            ),
            SizedBox(width: 10.w),
            Text(
              'Edit Profile',
              style: AppTextStyles.h8Bold.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
