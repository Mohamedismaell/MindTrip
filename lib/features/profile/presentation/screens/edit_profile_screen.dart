import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/edit_bio_section.dart';
import 'package:mindtrip/features/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/utils/image_pick_crop_service.dart';
import 'package:mindtrip/core/shared/presentation/widget/appp_dialog.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_otlined_button.dart';
import 'package:mindtrip/features/profile/presentation/manager/edit_profile_cubit.dart';
import 'package:mindtrip/features/profile/presentation/manager/edit_profile_state.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/edit_avatar.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/edit_profile_listeners.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/edit_top_bar.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/editable_info.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/image_source_bottom_sheet.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/info_card.dart';
import 'package:mindtrip/features/profile/presentation/widgets/edit/profile_info_row.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _bioController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final EditProfileCubit _cubit;
  Timer? _phoneDebounce;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _bioController = TextEditingController();

    _cubit = sl<EditProfileCubit>();

    final user = sl<UserCubit>().state.user;
    if (user != null) {
      _cubit.init(user);
      _nameController.text = user.displayName;
      _phoneController.text = user.phoneNumber ?? '';
      _bioController.text = user.bio ?? '';
    }

    _nameController.addListener(_onNameChanged);
    _phoneController.addListener(_onPhoneChanged);
    _bioController.addListener(_onBioChanged);
  }

  void _onNameChanged() {
    _cubit.updateDisplayName(_nameController.text);
  }

  void _onPhoneChanged() {
    _phoneDebounce?.cancel();
    _phoneDebounce = Timer(const Duration(milliseconds: 250), () {
      _cubit.updatePhoneNumber(_phoneController.text);
    });
  }

  void _onBioChanged() {
    _cubit.updateBio(_bioController.text);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _phoneDebounce?.cancel();
    _cubit.close();
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
    if (context.mounted) {
      context.read<EditProfileCubit>().pickPhoto(file.path);
    }
  }

  Future<void> _handleBack(BuildContext context, EditProfileState state) async {
    if (context.canPop()) {
      if (state.hasChanges && state.saveStatus != EditSaveStatus.saving) {
        await AppDialog.show(
          context: context,
          title: "Save",
          description: "You have unsaved changes. Do you want to save them?",
          primaryText: "Save Changes",
          onPrimary: () {
            FocusScope.of(context).unfocus();
            if (_formKey.currentState?.validate() ?? false) {
              context.read<EditProfileCubit>().saveChanges();
              context.pop();
            } else {
              //! If validation fails, close the dialog so the user can see the error
              context.pop();
            }
          },
          secondaryText: "Discard changes",
          onSecondary: () {
            context.pop();
          },
          iconColor: AppColors.errorRed.withValues(alpha: 0.9),
        );
      } else if (!state.hasChanges) {
        context.pop();
      }
    } else {
      context.go(AppRoutes.profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserCubit>().state.user;

    return BlocProvider.value(
      value: _cubit,
      child: EditProfileListeners(
        child: BlocBuilder<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
            final photoUrl = user?.profilePhotoUrl;
            final email = user?.email ?? 'traveler@mindtrip.app';
            final isSaving = state.saveStatus == EditSaveStatus.saving;
            final isDeleting =
                state.deleteStatus == DeleteAccountStatus.deleting;
            return PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) async {
                if (didPop) return;
                await _handleBack(context, state);
              },
              child: Scaffold(
                backgroundColor: context.colorTheme.surface,
                body: SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
                        EditTopBar(
                          onBackTap: () => _handleBack(context, state),
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
                        Form(
                          key: _formKey,
                          child: _EditableInfoCard(
                            nameController: _nameController,
                            phoneController: _phoneController,
                            email: email,
                          ),
                        ),
                        SizedBox(height: 28.h),
                        EditBioSection(controller: _bioController),
                        SizedBox(height: 38.h),
                        // Save Button
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: CustomOutlinedButton(
                            onPressed: (isSaving || !state.hasChanges)
                                ? null
                                : () {
                                    FocusScope.of(context).unfocus();
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      context
                                          .read<EditProfileCubit>()
                                          .saveChanges();
                                    }
                                  },
                            text: "Save Changes",
                            color: context.colorTheme.primary,
                            isLoading: isSaving,
                          ),
                        ),

                        SizedBox(height: 32.h),

                        // Delete Account
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: CustomOutlinedButton(
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
                  ),
                ),
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
          keyboardType: TextInputType.phone,
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
