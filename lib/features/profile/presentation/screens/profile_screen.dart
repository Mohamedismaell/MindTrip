import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_mock_data.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile_flow_scaffold.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile_user_avatar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final user = state.user;
        final displayName = user?.displayName ?? 'Traveler';
        final email = user?.email ?? 'traveler@mindtrip.app';
        final photoUrl = user?.profilePhotoUrl;
        final language = user?.languagePreference ?? 'English';

        return ProfileFlowScaffold(
          routeLocation: AppRoutes.profile,
          trailingIcon: IconButton(
            key: const Key('profile-settings-button'),
            onPressed: () => context.push(AppRoutes.profileSettings),
            icon: SvgPicture.asset(HomeAssets.drawerIcon),
          ),
          headdingIcon: IconButton(
            key: const Key('profile-settings-button'),
            onPressed: () => context.push(AppRoutes.profileSettings),
            icon: Icon(
              Icons.settings_outlined,
              color: context.colorTheme.onSurface,
              size: 22.sp,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProfileHeaderCard(
                displayName: displayName,
                email: email,
                photoUrl: photoUrl,
                language: language,
              ),
              SizedBox(height: 18.h),
              _ProfileStatsCard(stats: ProfileMockData.stats),
              SizedBox(height: 18.h),
              const _SectionTitle(
                title: 'Interests',
                subtitle: 'Local placeholders for this phase',
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: ProfileMockData.interests
                    .map((interest) => _InterestChip(label: interest))
                    .toList(),
              ),
              SizedBox(height: 24.h),
              const _SectionTitle(title: 'Saved Trips'),
              SizedBox(height: 12.h),
              ...ProfileMockData.savedTrips.map(
                (trip) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: _TripCard(data: trip),
                ),
              ),
              SizedBox(height: 12.h),
              const _SectionTitle(title: 'My Trips'),
              SizedBox(height: 12.h),
              ...ProfileMockData.myTrips.map(
                (trip) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: _TripCard(data: trip),
                ),
              ),
              SizedBox(height: 12.h),
              const _SectionTitle(title: 'Recent Reviews'),
              SizedBox(height: 12.h),
              ...ProfileMockData.reviews.map(
                (review) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: _ReviewCard(data: review),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProfileHeaderCard extends StatelessWidget {
  const _ProfileHeaderCard({
    required this.displayName,
    required this.email,
    required this.photoUrl,
    required this.language,
  });

  final String displayName;
  final String email;
  final String? photoUrl;
  final String language;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colorTheme.surface,
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: context.colorTheme.primary.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          ProfileUserAvatar(
            key: const Key('profile-avatar'),
            displayName: displayName,
            imageUrl: photoUrl,
            radius: 38,
          ),
          SizedBox(height: 14.h),
          Text(
            displayName,
            key: const Key('profile-display-name'),
            style: context.textTheme.titleLarge?.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: context.colorTheme.onSurface,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            email,
            key: const Key('profile-email'),
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              color: context.colorTheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.primaryLightBlue1.withOpacity(0.38),
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Text(
              'Preferred language: $language',
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: context.colorTheme.primary,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          CustomGradientButton(
            width: double.infinity,
            text: 'Edit Profile',
            onTap: () => context.push(AppRoutes.editProfile),
          ),
        ],
      ),
    );
  }
}

class _ProfileStatsCard extends StatelessWidget {
  const _ProfileStatsCard({required this.stats});

  final List<ProfileStatData> stats;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLightGray,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        children: stats
            .map(
              (stat) => Expanded(
                child: Column(
                  children: [
                    Text(
                      stat.value,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: context.colorTheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      stat.label,
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        color: context.colorTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.titleMedium?.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: context.colorTheme.onSurface,
          ),
        ),
        if (subtitle != null) ...[
          SizedBox(height: 4.h),
          Text(
            subtitle!,
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 12.sp,
              color: context.colorTheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}

class _InterestChip extends StatelessWidget {
  const _InterestChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLightBlue1.withOpacity(0.34),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Text(
        label,
        style: context.textTheme.bodySmall?.copyWith(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: context.colorTheme.primary,
        ),
      ),
    );
  }
}

class _TripCard extends StatelessWidget {
  const _TripCard({required this.data});

  final ProfileTripData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.colorTheme.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.primaryLightGray),
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: AppColors.primaryLightBlue1.withOpacity(0.28),
              borderRadius: BorderRadius.circular(16.r),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.flight_takeoff_rounded,
              color: context.colorTheme.primary,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: context.colorTheme.onSurface,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  data.subtitle,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 12.sp,
                    color: context.colorTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.primaryLightGray,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Text(
              data.badge,
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: context.colorTheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.data});

  final ProfileReviewData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primaryLightGray,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.title,
            style: context.textTheme.titleSmall?.copyWith(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: context.colorTheme.onSurface,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            data.subtitle,
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: 13.sp,
              color: context.colorTheme.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            data.dateLabel,
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: context.colorTheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
