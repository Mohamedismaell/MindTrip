import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_mock_data.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile/edit_profile_button.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile/interest_chip.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile/mytrips_section.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile/profile_identity.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile/review_card.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile/saved_trip_card.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile/section_heading.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile/stats_card.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile/top_actions_row.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile_flow_scaffold.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showPlaceholder(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('This action is coming soon.')),
    );
  }

  //! there is no User Name
  //! there is no locaiotn
  //! there is no trips - reviews - saved
  //! there is no saved Trips
  //! there is no my Trips
  //! there is no reviews
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final user = state.user;
        final displayName = user?.displayName ?? 'Traveler';
        final photoUrl = user?.profilePhotoUrl;
        final interests = user?.interests;
        return ProfileFlowScaffold(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopActionsRow(
                onSettingsTap: () => context.push(AppRoutes.profileSettings),
                onMenuTap: () => _showPlaceholder(context),
              ),
              SizedBox(height: 18.h),
              ProfileIdentity(displayName: displayName, photoUrl: photoUrl),
              SizedBox(height: 24.h),
              const EditProfileButton(),
              SizedBox(height: 34.h),
              Center(child: StatsCard(stats: ProfileMockData.stats)),
              SizedBox(height: 28.h),
              SectionHeading(
                title: 'My interests',
                trailing: SizedBox(
                  width: 20.w,
                  child: InkWell(
                    onTap: () {
                      context.push(AppRoutes.interests);
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
              const SectionHeading(title: 'Saved Trips', actionText: 'See all'),
              SizedBox(height: 16.h),
              SizedBox(
                height: 101.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  // clipBehavior: Clip.none,
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
              SectionHeading(
                title: 'My Trips',
                actionText: 'See all',
                onActionTap: () => context.push(AppRoutes.myTrips),
              ),
              SizedBox(height: 18.h),
              const MyTripsSection(),
              SizedBox(height: 28.h),
              const SectionHeading(title: 'My Reviews', actionText: 'See all'),
              SizedBox(height: 24.h),
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
