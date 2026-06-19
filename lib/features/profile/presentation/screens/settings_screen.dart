import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:mindtrip/core/shared/presentation/widget/appp_dialog.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_otlined_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // bool _pauseNotifications = true;

  // void _showPlaceholder(String title) {
  //   ScaffoldMessenger.of(
  //     context,
  //   ).showSnackBar(SnackBar(content: Text('$title is coming soon.')));
  // }

  @override
  Widget build(BuildContext context) {
    // final user = context.watch<UserCubit>().state.user;
    // final displayName = user?.displayName ?? 'Traveler';
    // final photoUrl = user?.profilePhotoUrl;
    // final language = user?.languagePreference ?? 'English';

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (context.canPop()) {
          context.pop();
        } else {
          context.go(AppRoutes.profile);
        }
      },
      child: Scaffold(
        backgroundColor: context.colorTheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 6.h),
                _SettingsTopBar(
                  onBackTap: () {
                    if (context.canPop()) {
                      context.pop();
                      return;
                    }

                    context.go(AppRoutes.profile);
                  },
                ),
                // SizedBox(height: 27.h),
                // _UserSummaryCard(
                //   displayName: displayName,
                //   photoUrl: photoUrl,
                //   onTap: () => _showPlaceholder('Profile details'),
                // ),

                // SizedBox(height: 22.h),
                // _SettingsGroupCard(
                //   children: [
                //     _SettingsRow(
                //       icon: Icons.notifications_off_outlined,
                //       title: 'Pause notifications',
                //       trailing: _FigmaSwitch(
                //         value: _pauseNotifications,
                //         onTap: () {
                //           setState(() {
                //             _pauseNotifications = !_pauseNotifications;
                //           });
                //         },
                //       ),
                //     ),
                //     _SettingsDivider(),
                //     _SettingsRow(
                //       icon: Icons.tune_rounded,
                //       title: 'General Settings',
                //       trailing: const _ChevronArrow(),
                //       onTap: () => _showPlaceholder('General Settings'),
                //     ),
                //     _SettingsDivider(),
                //     _SettingsRow(
                //       icon: Icons.account_balance_wallet_outlined,
                //       title: 'Wallet',
                //       trailing: const _ChevronArrow(),
                //       onTap: () => _showPlaceholder('Wallet'),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 20.h),

                // _SettingsGroupCard(
                //   children: [
                //     _SettingsRow(
                //       icon: Icons.dark_mode_outlined,
                //       title: 'Dark Mode',
                //       trailing: _FigmaSwitch(
                //         key: const Key('settings-dark-mode-switch'),
                //         value: context.isDark,
                //         isActiveBlue: false,
                //         onTap: () => context.read<ThemeCubit>().toggleTheme(),
                //       ),
                //     ),
                //     _SettingsDivider(),
                //     _SettingsRow(
                //       icon: Icons.language,
                //       title: 'Language',
                //       trailing: Row(
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //           Text(
                //             language,
                //             style: context.textTheme.bodyMedium?.copyWith(
                //               fontSize: 16.sp,
                //               color: context.colorTheme.onSurfaceVariant,
                //             ),
                //           ),
                //           SizedBox(width: 9.w),
                //           const _ChevronArrow(),
                //         ],
                //       ),
                //       onTap: () => _showPlaceholder('Language'),
                //     ),
                //   ],
                // ),
                SizedBox(height: 20.h),
                _SettingsGroupCard(
                  children: [
                    _SettingsRow(
                      icon: Icons.help_outline_rounded,
                      title: 'FAQ',
                      trailing: const _ChevronArrow(),
                      onTap: () => context.go(AppRoutes.profileFaq),
                    ),
                    _SettingsDivider(),
                    _SettingsRow(
                      icon: Icons.info_outline_rounded,
                      title: 'Terms of service',
                      trailing: const _ChevronArrow(),
                      onTap: () => context.go(AppRoutes.profileTerms),
                    ),
                    _SettingsDivider(),
                    _SettingsRow(
                      icon: Icons.policy_outlined,
                      title: 'User Policy',
                      trailing: const _ChevronArrow(),
                      onTap: () => context.go(AppRoutes.profilePolicy),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                Center(
                  child: SizedBox(
                    width: 259.w,
                    height: 55.h,
                    child: CustomOutlinedButton(
                      key: const Key('settings-logout-button'),
                      onPressed: () {
                        AppDialog.show(
                          context: context,
                          title: 'Are you sure you want to log out?',
                          primaryText: 'Cancel',
                          onPrimary: () {},
                          secondaryText: 'Log Out',
                          onSecondary: () =>
                              context.read<AppGateCubit>().logout(),
                        );
                      },
                      icon: Icons.logout_rounded,
                      color: context.colorTheme.error,
                      text: 'Log Out',
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsTopBar extends StatelessWidget {
  const _SettingsTopBar({required this.onBackTap});

  final VoidCallback onBackTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          TapScaleEffect(
            onTap: onBackTap,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryLightGray,
                ),
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: 28.sp,
                  color: context.colorTheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          Text(
            'Settings',
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

// class _UserSummaryCard extends StatelessWidget {
//   const _UserSummaryCard({
//     required this.displayName,
//     this.photoUrl,
//     required this.onTap,
//   });

//   final String displayName;
//   final String? photoUrl;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(20.r),
//       child: Container(
//         width: double.infinity,
//         padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
//         decoration: BoxDecoration(
//           color: AppColors.primaryLightGray,
//           borderRadius: BorderRadius.circular(20.r),
//         ),
//         child: Row(
//           children: [
//             ClipOval(
//               child: SizedBox(
//                 width: 54.w,
//                 height: 54.w,
//                 child: photoUrl != null
//                     ? AppCachedImage(imagePath: photoUrl!)
//                     : Image.asset(
//                         'assets/images/profile/deafult_user_cover.webp',
//                       ),
//               ),
//             ),
//             SizedBox(width: 12.w),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     displayName,
//                     style: context.textTheme.titleMedium?.copyWith(
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.w700,
//                       color: context.colorTheme.onSurface,
//                     ),
//                   ),
//                   SizedBox(height: 8.h),
//                   Text(
//                     ProfileMockData.username,
//                     style: context.textTheme.bodyMedium?.copyWith(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w500,
//                       color: context.colorTheme.onSurfaceVariant,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const _ChevronArrow(),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _SettingsGroupCard extends StatelessWidget {
  const _SettingsGroupCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLightGray,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.title,
    required this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final Widget trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TapScaleEffect(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: SizedBox(
        height: 41.h,
        child: Row(
          children: [
            Icon(icon, size: 24.sp, color: context.colorTheme.onSurfaceVariant),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.h9SemiBold.copyWith(
                  color: context.colorTheme.onSurfaceVariant,
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

class _SettingsDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 11.h),
      height: 0.5,
      color: AppColors.mediumLightGray.withValues(alpha: 0.35),
    );
  }
}

class _ChevronArrow extends StatelessWidget {
  const _ChevronArrow();

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.chevron_right_rounded,
      size: 28.sp,
      color: context.colorTheme.onSurfaceVariant,
    );
  }
}

// class _FigmaSwitch extends StatelessWidget {
//   const _FigmaSwitch({
//     super.key,
//     required this.value,
//     required this.onTap,
//     this.isActiveBlue = true,
//   });

//   final bool value;
//   final VoidCallback onTap;
//   final bool isActiveBlue;

//   @override
//   Widget build(BuildContext context) {
//     final activeColor = isActiveBlue
//         ? context.colorTheme.primary
//         : AppColors.mediumLightGray;

//     return InkWell(
//       key: key,
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(70.r),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         width: 52.w,
//         height: 30.h,
//         padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
//         decoration: BoxDecoration(
//           color: value ? activeColor : AppColors.mediumLightGray,
//           borderRadius: BorderRadius.circular(70.r),
//         ),
//         child: Align(
//           alignment: value ? Alignment.centerRight : Alignment.centerLeft,
//           child: Container(
//             width: 24.w,
//             height: 24.w,
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
