import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_mock_data.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile/profile_user_avatar.dart';

class ProfileIdentity extends StatelessWidget {
  const ProfileIdentity({
    super.key,
    required this.displayName,
    required this.photoUrl,
  });

  final String displayName;
  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ProfileUserAvatar(
                key: const Key('profile-avatar'),
                displayName: displayName,
                imageUrl: photoUrl,
                radius: 60,
              ),
              Positioned(
                right: 7.w,
                bottom: 5.h,
                child: Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0BAB05),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            displayName,
            key: const Key('profile-display-name'),
            style: AppTextStyles.h6Bold.copyWith(
              color: context.colorTheme.onSurface,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            ProfileMockData.username,
            style: AppTextStyles.h8Medium.copyWith(
              color: context.colorTheme.onSurface,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 14.5.w,
                child: SvgPicture.asset(
                  HomeAssets.locationIcon,
                  colorFilter: ColorFilter.mode(
                    context.colorTheme.onSurfaceVariant,
                    BlendMode.srcIn,
                  ),
                ),
              ),

              SizedBox(width: 8.w),
              Text(
                ProfileMockData.location,
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorTheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Text(
            ProfileMockData.bio,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
