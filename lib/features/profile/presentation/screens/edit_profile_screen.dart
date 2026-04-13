import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_mock_data.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile_flow_scaffold.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  void _showLocalOnlyMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
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
          _EditTopBar(
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
            child: _EditAvatar(
              imageUrl: photoUrl,
              onCameraTap: () => _showLocalOnlyMessage(
                context,
                'Profile photo updates are coming soon.',
              ),
            ),
          ),
          SizedBox(height: 38.h),
          _InfoCard(
            rows: [
              _ProfileInfoRow(
                key: const Key('edit-profile-display-name-row'),
                label: 'Full name',
                value: displayName,
              ),
              _ProfileInfoRow(
                key: const Key('edit-profile-phone-row'),
                label: 'Phone Number',
                value: ProfileMockData.phoneNumber,
              ),
              _ProfileInfoRow(
                key: const Key('edit-profile-email-row'),
                label: 'Email',
                value: email,
              ),
              _ProfileInfoRow(
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

class _EditTopBar extends StatelessWidget {
  const _EditTopBar({required this.onBackTap});

  final VoidCallback onBackTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: onBackTap,
              icon: Icon(
                Icons.arrow_back_rounded,
                size: 30.sp,
                color: context.colorTheme.onSurfaceVariant,
              ),
            ),
          ),
          Text(
            'Edit Profile',
            style: context.textTheme.titleLarge?.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: context.colorTheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _EditAvatar extends StatelessWidget {
  const _EditAvatar({
    required this.imageUrl,
    required this.onCameraTap,
  });

  final String imageUrl;
  final VoidCallback onCameraTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 120.w,
          height: 120.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: context.colorTheme.primary, width: 1.5),
          ),
          clipBehavior: Clip.antiAlias,
          child: AppCachedImage(imageUrl: imageUrl),
        ),
        Positioned(
          right: -4.w,
          bottom: 6.h,
          child: InkWell(
            onTap: onCameraTap,
            borderRadius: BorderRadius.circular(19.r),
            child: Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: context.colorTheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                size: 20.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.rows});

  final List<_ProfileInfoRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryLightGray,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: List.generate(rows.length, (index) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
                child: rows[index],
              ),
              if (index != rows.length - 1)
                Container(
                  height: 0.5,
                  color: AppColors.mediumLightGray.withOpacity(0.35),
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: context.colorTheme.onSurface,
            ),
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: 16.sp,
              color: context.colorTheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
