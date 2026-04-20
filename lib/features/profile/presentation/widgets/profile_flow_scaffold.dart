import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class ProfileFlowScaffold extends StatelessWidget {
  const ProfileFlowScaffold({
    super.key,
    required this.routeLocation,
    required this.child,
    this.title,
    this.leading,
    this.trailing,
    this.showHeader = true,
    this.showBackButton = false,
    this.horizontalPadding,
  });

  final String routeLocation;
  final Widget child;
  final String? title;
  final Widget? leading;
  final Widget? trailing;
  final bool showHeader;
  final bool showBackButton;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final sidePadding = horizontalPadding ?? 20.w;

    return Scaffold(
      backgroundColor: context.colorTheme.surface,
      // bottomNavigationBar: BottomNav(
      //   currentIndex: BottomNavRouteHelper.currentIndexForLocation(
      //     routeLocation,
      //   ),
      //   onTap: (index) => BottomNavRouteHelper.onTap(context, index),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            if (showHeader)
              Padding(
                padding: EdgeInsets.fromLTRB(
                  sidePadding,
                  14.h,
                  sidePadding,
                  8.h,
                ),
                child: SizedBox(
                  height: 50.w,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      //! there is no showBackButton or leading used for now
                      if (showBackButton || leading != null)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _HeaderCircleButton(
                            child: showBackButton
                                ? IconButton(
                                    key: Key('$title-back-button'),
                                    onPressed: () {
                                      if (context.canPop()) {
                                        context.pop();
                                        return;
                                      }

                                      context.go(AppRoutes.profile);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      color: context.colorTheme.onSurface,
                                      size: 18.sp,
                                    ),
                                  )
                                : leading!,
                          ),
                        ),
                      if (title != null)
                        Center(
                          child: Text(
                            title!,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.h8Bold.copyWith(
                              color: context.colorTheme.onSurface,
                            ),
                          ),
                        ),
                      // if (trailing != null)
                      //   Align(
                      //     alignment: Alignment.centerRight,
                      //     child: _HeaderCircleButton(child: trailing!),
                      //   ),
                    ],
                  ),
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderCircleButton extends StatelessWidget {
  const _HeaderCircleButton({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 50.w,
      decoration: const BoxDecoration(
        color: AppColors.primaryLightGray,
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}
