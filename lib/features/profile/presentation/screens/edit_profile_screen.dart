import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_mock_data.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/edit_avatar.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/edit_top_bar.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/info_card.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/profile_info_row.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile/profile_flow_scaffold.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  void _showLocalOnlyMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state.user;
    final displayName = user?.displayName ?? 'Traveler';
    final email = user?.email ?? 'traveler@mindtrip.app';
    final photoUrl = user?.profilePhotoUrl ?? ProfileMockData.defaultAvatarUrl;

    return ProfileFlowScaffold(
      routeLocation: AppRoutes.editProfile,
      showHeader: false,
      horizontalPadding: 16.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          EditTopBar(
            onBackTap: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
                return;
              }

              context.go(AppRoutes.profile);
            },
          ),
          SizedBox(height: 38.h),
          Center(
            child: EditAvatar(
              imageUrl: photoUrl,
              onCameraTap: () => _showLocalOnlyMessage(
                context,
                'Profile photo updates are coming soon.',
              ),
            ),
          ),
          SizedBox(height: 38.h),
          InfoCard(
            rows: [
              ProfileInfoRow(
                key: const Key('edit-profile-display-name-row'),
                label: 'Full name',
                value: displayName,
              ),
              ProfileInfoRow(
                key: const Key('edit-profile-phone-row'),
                label: 'Phone Number',
                value: ProfileMockData.phoneNumber,
              ),
              ProfileInfoRow(
                key: const Key('edit-profile-email-row'),
                label: 'Email',
                value: email,
              ),
              ProfileInfoRow(
                key: const Key('edit-profile-username-row'),
                label: 'Username',
                value: ProfileMockData.username,
              ),
            ],
          ),
          SizedBox(height: 38.h),
          Center(
            child: SizedBox(
              width: 281.w,
              height: 55.h,
              child: OutlinedButton(
                key: const Key('edit-profile-save-button'),
                onPressed: () => _showLocalOnlyMessage(
                  context,
                  'Changes stay local only in this phase.',
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: context.colorTheme.primary, width: 1),
                  foregroundColor: context.colorTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                child: Text(
                  'Save Changes',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: context.colorTheme.primary,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 32.h),
          Center(
            child: SizedBox(
              width: 281.w,
              height: 55.h,
              child: OutlinedButton(
                key: const Key('edit-profile-delete-account-button'),
                onPressed: () => _showLocalOnlyMessage(
                  context,
                  'Delete account is coming soon.',
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: context.colorTheme.error, width: 1),
                  foregroundColor: context.colorTheme.error,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                child: Text(
                  'Delete Account',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: context.colorTheme.error,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
