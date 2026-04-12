import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_mock_data.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile_flow_scaffold.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile_user_avatar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _displayNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _usernameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _languageController;

  @override
  void initState() {
    super.initState();
    final user = context.read<UserCubit>().state.user;
    _displayNameController = TextEditingController(
      text: user?.displayName ?? 'Traveler',
    );
    _emailController = TextEditingController(
      text: user?.email ?? 'traveler@mindtrip.app',
    );
    _usernameController = TextEditingController(text: ProfileMockData.username);
    _phoneController = TextEditingController(text: ProfileMockData.phoneNumber);
    _languageController = TextEditingController(
      text: user?.languagePreference ?? 'English',
    );
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _languageController.dispose();
    super.dispose();
  }

  void _showLocalOnlyMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state.user;
    final displayName = user?.displayName ?? _displayNameController.text;
    final photoUrl = user?.profilePhotoUrl;

    return ProfileFlowScaffold(
      routeLocation: AppRoutes.editProfile,
      title: 'Edit Profile',
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                ProfileUserAvatar(
                  displayName: displayName,
                  imageUrl: photoUrl,
                  radius: 36,
                ),
                SizedBox(height: 10.h),
                Text(
                  'Profile photo is read-only in this phase',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 12.sp,
                    color: context.colorTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          _ProfileField(
            key: const Key('edit-profile-display-name-field'),
            label: 'Display Name',
            controller: _displayNameController,
          ),
          SizedBox(height: 14.h),
          _ProfileField(
            key: const Key('edit-profile-email-field'),
            label: 'Email',
            controller: _emailController,
            readOnly: true,
          ),
          SizedBox(height: 14.h),
          _ProfileField(
            key: const Key('edit-profile-username-field'),
            label: 'Username',
            controller: _usernameController,
          ),
          SizedBox(height: 14.h),
          _ProfileField(
            key: const Key('edit-profile-phone-field'),
            label: 'Phone Number',
            controller: _phoneController,
          ),
          SizedBox(height: 14.h),
          _ProfileField(
            key: const Key('edit-profile-language-field'),
            label: 'Language',
            controller: _languageController,
            readOnly: true,
          ),
          SizedBox(height: 18.h),
          Text(
            'Interests',
            style: context.textTheme.titleMedium?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: context.colorTheme.onSurface,
            ),
          ),
          SizedBox(height: 10.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: ProfileMockData.interests
                .map((interest) => _InterestPill(label: interest.toString()))
                .toList(),
          ),
          SizedBox(height: 26.h),
          CustomGradientButton(
            width: double.infinity,
            text: 'Save Changes',
            onTap: () =>
                _showLocalOnlyMessage('Changes stay local only in this phase.'),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              key: const Key('edit-profile-delete-account-button'),
              onPressed: () =>
                  _showLocalOnlyMessage('Delete account is coming soon.'),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                side: BorderSide(color: context.colorTheme.error, width: 1.4),
                foregroundColor: context.colorTheme.error,
              ),
              child: const Text('Delete Account'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  const _ProfileField({
    super.key,
    required this.label,
    required this.controller,
    this.readOnly = false,
  });

  final String label;
  final TextEditingController controller;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: context.colorTheme.onSurface,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: 14.sp,
            color: context.colorTheme.onSurface,
          ),
          decoration: const InputDecoration().copyWith(
            filled: true,
            fillColor: AppColors.primaryLightGray,
            hintText: label,
          ),
        ),
      ],
    );
  }
}

class _InterestPill extends StatelessWidget {
  const _InterestPill({required this.label});

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
