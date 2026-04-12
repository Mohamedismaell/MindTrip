import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_mock_data.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit_profile_button.dart';
import 'package:mindtrip/features/profile/presentation/widgets/interest_chip.dart';
import 'package:mindtrip/features/profile/presentation/widgets/my_trip_card.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile_flow_scaffold.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile_identity.dart';
import 'package:mindtrip/features/profile/presentation/widgets/review_card.dart';
import 'package:mindtrip/features/profile/presentation/widgets/saved_trip_card.dart';
import 'package:mindtrip/features/profile/presentation/widgets/section_heading.dart';
import 'package:mindtrip/features/profile/presentation/widgets/stats_card.dart';
import 'package:mindtrip/features/profile/presentation/widgets/top_actions_row.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showPlaceholder(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('This action is coming soon.')),
    );
  }

  //Todo start from bio
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final user = state.user;
        final displayName = user?.displayName ?? 'Traveler';
        final photoUrl =
            user?.profilePhotoUrl ?? ProfileMockData.defaultAvatarUrl;

        return ProfileFlowScaffold(
          routeLocation: AppRoutes.profile,
          showHeader: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopActionsRow(
                onSettingsTap: () => context.push(AppRoutes.profileSettings),
                onMenuTap: () => _showPlaceholder(context),
              ),
              SizedBox(height: 18.h),
              ProfileIdentity(displayName: displayName, photoUrl: photoUrl),
              SizedBox(height: 22.h),
              const EditProfileButton(),
              SizedBox(height: 26.h),
              Center(child: StatsCard(stats: ProfileMockData.stats)),
              SizedBox(height: 28.h),
              SectionHeading(
                title: 'My interests',
                trailing: Icon(
                  Icons.edit_square,
                  size: 18.sp,
                  color: context.colorTheme.onSurface,
                ),
              ),
              SizedBox(height: 16.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 18.h,
                children: ProfileMockData.interests
                    .map((interest) => InterestChip(data: interest))
                    .toList(),
              ),
              SizedBox(height: 26.h),
              const SectionHeading(title: 'Saved Trips', actionText: 'See all'),
              SizedBox(height: 16.h),
              SizedBox(
                height: 101.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  itemCount: ProfileMockData.savedTrips.length,
                  separatorBuilder: (_, _) => SizedBox(width: 28.w),
                  itemBuilder: (context, index) {
                    return SavedTripCard(
                      data: ProfileMockData.savedTrips[index],
                    );
                  },
                ),
              ),
              SizedBox(height: 28.h),
              const SectionHeading(title: 'My Trips'),
              SizedBox(height: 18.h),
              SizedBox(
                height: 233.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  itemCount: ProfileMockData.myTrips.length,
                  separatorBuilder: (_, _) => SizedBox(width: 32.w),
                  itemBuilder: (context, index) {
                    return MyTripCard(data: ProfileMockData.myTrips[index]);
                  },
                ),
              ),
              SizedBox(height: 30.h),
              const SectionHeading(title: 'My Reviews', actionText: 'See all'),
              SizedBox(height: 20.h),
              ...ProfileMockData.reviews.map(
                (review) => Padding(
                  padding: EdgeInsets.only(bottom: 18.h),
                  child: ReviewCard(data: review),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
