import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/utils/image_pick_crop_service.dart';
import 'package:mindtrip/core/widget/custom_otlined_button.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_mock_data.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/edit_avatar.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/edit_top_bar.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/image_source_bottom_sheet.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/info_card.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/profile_info_row.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile_flow_scaffold.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  void _showLocalOnlyMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _handleCameraTap(BuildContext context) async {
    // 1. Show source picker bottom sheet
    final source = await showImageSourceSheet(context);
    if (source == null) return;

    // 2. Pick, crop & compress
    final file = await sl<ImagePickCropService>().pickAndCropImage(source);
    if (file == null) return;

    // 3. Upload in background (non-blocking)
    if (context.mounted) {
      context.read<UserCubit>().uploadProfilePhoto(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listenWhen: (prev, curr) =>
          prev.photoUploadStatus != curr.photoUploadStatus,
      listener: (context, state) {
        if (state.photoUploadStatus == PhotoUploadStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile photo updated!'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state.photoUploadStatus == PhotoUploadStatus.failed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message ?? 'Upload failed. Tap photo to retry.'),
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(
                label: 'Retry',
                onPressed: () =>
                    context.read<UserCubit>().retryPhotoUpload(),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        final user = state.user;
        final displayName = user?.displayName ?? 'Traveler';
        final email = user?.email ?? 'traveler@mindtrip.app';
        final photoUrl =
            user?.profilePhotoUrl ?? ProfileMockData.defaultAvatarUrl;

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
                  if (context.canPop()) {
                    context.pop();
                    return;
                  }

                  context.go(AppRoutes.profile);
                },
              ),
              SizedBox(height: 38.h),
              Center(
                child: EditAvatar(
                  imageUrl: photoUrl,
                  localPhotoPath: state.localPhotoPath,
                  photoUploadStatus: state.photoUploadStatus,
                  onCameraTap: () => _handleCameraTap(context),
                  onRetryTap: () =>
                      context.read<UserCubit>().retryPhotoUpload(),
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
                  child: CustomOtlinedButton(
                    key: const Key('edit-profile-save-button'),
                    onPressed: () => _showLocalOnlyMessage(
                      context,
                      'Changes stay local only in this phase.',
                    ),
                    text: 'Save Changes',
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
                      side: BorderSide(
                          color: context.colorTheme.error, width: 1),
                      foregroundColor: context.colorTheme.error,
                    ),
                    child: const Text('Delete Account'),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        );
      },
    );
  }
}
