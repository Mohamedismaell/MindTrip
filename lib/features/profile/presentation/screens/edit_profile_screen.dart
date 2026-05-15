import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/utils/image_pick_crop_service.dart';
import 'package:mindtrip/core/widget/appp_dialog.dart';
import 'package:mindtrip/core/widget/custom_otlined_button.dart';
import 'package:mindtrip/features/profile/presentation/manager/edit_profile_cubit.dart';
import 'package:mindtrip/features/profile/presentation/manager/edit_profile_state.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/edit_avatar.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/edit_profile_listeners.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/edit_top_bar.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/editable_info.dart';
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
    if (!context.mounted) return;
    final file = await sl<ImagePickCropService>().pickAndCropImage(
      context,
      source,
    );
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
        // Sync changes
        _nameController.addListener(
          () => cubit.updateDisplayName(_nameController.text),
        );
        _phoneController.addListener(
          () => cubit.updatePhoneNumber(_phoneController.text),
        );
        return cubit;
      },
      child: EditProfileListeners(
        child: BlocBuilder<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
            final photoUrl = user?.profilePhotoUrl;
            final email = user?.email ?? 'traveler@mindtrip.app';
            final isSaving = state.saveStatus == EditSaveStatus.saving;
            final isDeleting =
                state.deleteStatus == DeleteAccountStatus.deleting;
            return ProfileFlowScaffold(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  EditTopBar(
                    onBackTap: () async {
                      if (context.canPop()) {
                        if (state.hasChanges && !isSaving) {
                          await AppDialog.show(
                            context: context,
                            title: "Save",
                            description:
                                "You have unsaved changes. Do you want to save them?",
                            primaryText: "Save Changes",
                            onPrimary: () {
                              context.read<EditProfileCubit>().saveChanges();
                            },
                            secondaryText: "Discard changes",
                            iconColor: AppColors.errorRed.withValues(
                              alpha: 0.9,
                            ),
                            onSecondary: () {
                              // if (context.mounted) {
                              context.pop();
                              // }
                            },
                          );
                        }
                        if (context.mounted && !state.hasChanges) {
                          context.pop();
                        }
                        return;
                      } else {
                        context.go(AppRoutes.profile);
                      }
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

                  // Editable Fields
                  _EditableInfoCard(
                    nameController: _nameController,
                    phoneController: _phoneController,
                    email: email,
                  ),
                  SizedBox(height: 38.h),

                  // Save Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: CustomOtlinedButton(
                      onPressed: (isSaving || !state.hasChanges)
                          ? null
                          : () =>
                                context.read<EditProfileCubit>().saveChanges(),
                      text: "Save Changes",
                      color: context.colorTheme.primary,
                      isLoading: isSaving,
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Delete Account
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: CustomOtlinedButton(
                      text: "Delete Account",
                      isLoading: isDeleting,
                      onPressed: isDeleting
                          ? null
                          : () async {
                              await AppDialog.show(
                                context: context,
                                title: "Permanently Delete Account",
                                description:
                                    "This action is permanent and cannot be undone.",
                                primaryText: "Cancel",
                                onPrimary: () {
                                  context.pop();
                                },
                                secondaryText: "Delete",
                                onSecondary: () async {
                                  await context
                                      .read<EditProfileCubit>()
                                      .deleteAccount();
                                },
                                iconColor: AppColors.errorRed.withValues(
                                  alpha: 0.9,
                                ),
                              );
                            },
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          },
        ),
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
        EditableInfo(
          key: const Key('edit-profile-display-name-row'),
          label: 'Full name: ',
          controller: nameController,
          hintText: 'Enter your name',
        ),
        EditableInfo(
          key: const Key('edit-profile-phone-row'),
          label: 'Phone Number: ',
          controller: phoneController,
          keyboardType: TextInputType.number,
          hintText: 'Enter phone number',
          isPhone: true,
        ),

        ProfileInfoRow(
          key: const Key('edit-profile-email-row'),
          label: 'Email: ',
          value: email,
        ),
      ],
    );
  }
}
// class DeleteAccountDialog extends StatelessWidget {
//   const DeleteAccountDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [],);
//   }
// }
