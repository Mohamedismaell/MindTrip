import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/presentation/widget/bottom_nav.dart';
import 'package:mindtrip/core/shared/presentation/widget/bottom_nav_route_helper.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class ProfileFlowScaffold extends StatelessWidget {
  const ProfileFlowScaffold({
    super.key,
    required this.routeLocation,
    required this.child,
    this.title,
    this.headdingIcon,
    this.trailingIcon,
    this.showBackButton = false,
  });

  final String routeLocation;
  final Widget child;
  final String? title;
  final Widget? headdingIcon;
  final Widget? trailingIcon;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.surface,
      bottomNavigationBar: BottomNav(
        currentIndex: BottomNavRouteHelper.currentIndexForLocation(
          routeLocation,
        ),
        onTap: (index) => BottomNavRouteHelper.onTap(context, index),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 8.h),
              child: Row(
                children: [
                  //! change to svg pic
                  headdingIcon != null
                      ? Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryLightGray,
                            shape: BoxShape.circle,
                          ),
                          width: 50.w,
                          height: 50.w,
                          child: headdingIcon,
                        )
                      : const SizedBox(),
                  //!edit the place of the head title
                  SizedBox(
                    width: 44.w,
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
                        : const SizedBox.shrink(),
                  ),
                  Expanded(
                    child: Text(
                      title ?? '',
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleLarge?.copyWith(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        color: context.colorTheme.onSurface,
                      ),
                    ),
                  ),

                  trailingIcon != null
                      ? Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryLightGray,
                            shape: BoxShape.circle,
                          ),
                          width: 50.w,
                          height: 50.w,
                          child: trailingIcon,
                        )
                      : const SizedBox(),
                ],
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
