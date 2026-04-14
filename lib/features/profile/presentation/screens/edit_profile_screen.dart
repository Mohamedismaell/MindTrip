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
import 'package:mindtrip/features/profile/presentation/manager/edit_profile_cubit.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/edit_avatar.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/edit_top_bar.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/editable_info_row.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/image_source_bottom_sheet.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/info_card.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/profile_info_row.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile_flow_scaffold.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleCameraTap(BuildContext context) async {
    final source = await showImageSourceSheet(context);
    if (source == null) return;

    final file = await sl<ImagePickCropService>().pickAndCropImage(source);
    if (file == null) return;
    print('file path ${file.path}');
    if (context.mounted) {
      context.read<EditProfileCubit>().pickPhoto(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserCubit>().state.user;

    return BlocProvider(
      create: (_) {
        final cubit = sl<EditProfileCubit>();
        if (user != null) {
          cubit.init(user);
          _nameController.text = user.displayName;
          _phoneController.text = user.phoneNumber ?? '';
        }
        // Sync text field changes → cubit drafts
        _nameController.addListener(
          () => cubit.updateDisplayName(_nameController.text),
        );
        _phoneController.addListener(
          () => cubit.updatePhoneNumber(_phoneController.text),
        );
        return cubit;
      },
      child: BlocConsumer<EditProfileCubit, EditProfileState>(
        listenWhen: (prev, curr) => prev.saveStatus != curr.saveStatus,
        listener: (context, state) {
          if (state.saveStatus == EditSaveStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile updated!'),
                behavior: SnackBarBehavior.floating,
              ),
            );
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.profile);
            }
          } else if (state.saveStatus == EditSaveStatus.failed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Save failed. Try again.'),
                behavior: SnackBarBehavior.floating,
                action: SnackBarAction(
                  label: 'Retry',
                  onPressed: () =>
                      context.read<EditProfileCubit>().saveChanges(),
                ),
              ),
            );
            context.read<EditProfileCubit>().dismissError();
          }
        },
        builder: (context, state) {
          final photoUrl = user?.profilePhotoUrl;
          final email = user?.email ?? 'traveler@mindtrip.app';
          final isSaving = state.saveStatus == EditSaveStatus.saving;

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

                // Avatar
                Center(
                  child: EditAvatar(
                    imageUrl: photoUrl,
                    pendingPhotoPath: state.pendingPhotoPath,
                    onCameraTap: () => _handleCameraTap(context),
                  ),
                ),
                SizedBox(height: 38.h),

                // Editable Fields Card
                _EditableInfoCard(
                  nameController: _nameController,
                  phoneController: _phoneController,
                  email: email,
                ),
                SizedBox(height: 38.h),

                // Save Button
                Center(
                  child: SizedBox(
                    width: 281.w,
                    height: 55.h,
                    child: isSaving
                        ? const Center(child: CircularProgressIndicator())
                        : CustomOtlinedButton(
                            key: const Key('edit-profile-save-button'),
                            onPressed: state.hasChanges
                                ? () => context
                                      .read<EditProfileCubit>()
                                      .saveChanges()
                                : () {},
                            text: 'Save Changes',
                          ),
                  ),
                ),
                SizedBox(height: 32.h),

                // Delete Account
                Center(
                  child: SizedBox(
                    width: 281.w,
                    height: 55.h,
                    child: OutlinedButton(
                      key: const Key('edit-profile-delete-account-button'),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Delete account is coming soon.'),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: context.colorTheme.error,
                          width: 1,
                        ),
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
      ),
    );
  }
}

class _EditableInfoCard extends StatelessWidget {
  const _EditableInfoCard({
    required this.nameController,
    required this.phoneController,
    required this.email,
  });

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final String email;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      rows: [
        EditableInfoRow(
          key: const Key('edit-profile-display-name-row'),
          label: 'Full name',
          controller: nameController,
          hintText: 'Enter your name',
        ),
        EditableInfoRow(
          key: const Key('edit-profile-phone-row'),
          label: 'Phone Number',
          controller: phoneController,
          keyboardType: TextInputType.phone,
          hintText: 'Enter phone number',
        ),
        ProfileInfoRow(
          key: const Key('edit-profile-email-row'),
          label: 'Email',
          value: email,
        ),
      ],
    );
  }
}
