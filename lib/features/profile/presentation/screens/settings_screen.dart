import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/cubit/theme_cubit.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_mock_data.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile_flow_scaffold.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showPlaceholder(BuildContext context, String title) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$title is coming soon.')));
  }

  @override
  Widget build(BuildContext context) {
    final language = context.watch<UserCubit>().state.user?.languagePreference;

    return ProfileFlowScaffold(
      routeLocation: AppRoutes.profileSettings,
      title: 'Settings',
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SettingsSection(
            title: 'Appearance',
            children: [
              _SettingsSwitchTile(
                title: 'Dark Mode',
                value: context.isDark,
                switchKey: const Key('settings-dark-mode-switch'),
                onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          _SettingsSection(
            title: 'Preferences',
            children: [
              _SettingsTile(
                title: 'Language',
                subtitle: language ?? 'English',
                onTap: () => _showPlaceholder(context, 'Language'),
              ),
              ...ProfileMockData.settingsPlaceholders
                  .where((item) => item != 'Language')
                  .map(
                    (item) => _SettingsTile(
                      title: item,
                      onTap: () => _showPlaceholder(context, item),
                    ),
                  ),
            ],
          ),
          SizedBox(height: 26.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              key: const Key('settings-logout-button'),
              onPressed: () => context.read<AppGateCubit>().logout(),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                side: BorderSide(color: context.colorTheme.error, width: 1.4),
                foregroundColor: context.colorTheme.error,
              ),
              child: const Text('Log Out'),
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => _showPlaceholder(context, 'Delete account'),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                side: BorderSide(color: context.colorTheme.error, width: 1.0),
                foregroundColor: context.colorTheme.error.withOpacity(0.75),
              ),
              child: const Text('Delete Account'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: AppColors.primaryLightGray,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.titleMedium?.copyWith(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              color: context.colorTheme.onSurface,
            ),
          ),
          SizedBox(height: 10.h),
          ...children,
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.title,
    required this.onTap,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: context.textTheme.bodyLarge?.copyWith(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          color: context.colorTheme.onSurface,
        ),
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle!,
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 12.sp,
                color: context.colorTheme.onSurfaceVariant,
              ),
            ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: context.colorTheme.onSurfaceVariant,
        size: 22.sp,
      ),
      onTap: onTap,
    );
  }
}

class _SettingsSwitchTile extends StatelessWidget {
  const _SettingsSwitchTile({
    required this.title,
    required this.value,
    required this.onChanged,
    required this.switchKey,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Key switchKey;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: context.textTheme.bodyLarge?.copyWith(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          color: context.colorTheme.onSurface,
        ),
      ),
      trailing: Switch.adaptive(
        key: switchKey,
        value: value,
        activeColor: context.colorTheme.primary,
        onChanged: onChanged,
      ),
    );
  }
}
