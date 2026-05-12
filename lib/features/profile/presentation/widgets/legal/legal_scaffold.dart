import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class LegalScaffold extends StatelessWidget {
  const LegalScaffold({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            _ProfileLegalTopBar(title: title),
            SizedBox(height: 28.h),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class _ProfileLegalTopBar extends StatelessWidget {
  const _ProfileLegalTopBar({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: IconButton(
                key: Key('${title.toLowerCase().replaceAll(' ', '-')}-back'),
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go(AppRoutes.profileSettings);
                  }
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  size: 32.sp,
                  color: context.colorTheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          Text(
            title,
            style: context.textTheme.headlineSmall?.copyWith(
              color: AppColors.pureBlack,
            ),
          ),
        ],
      ),
    );
  }
}
