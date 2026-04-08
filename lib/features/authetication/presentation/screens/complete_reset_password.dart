import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/app_strings.dart';
import 'package:mindtrip/core/widget/custom_otlined_button.dart';

class CompleteResetPassword extends StatelessWidget {
  const CompleteResetPassword({
    super.key,
    // required this.actionText,
  });
  // final String actionText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(AppAssets.completeSvg),
        Text('Congratulations !', style: AppTextStyles.h5Bold),
        Text(AppStrings.passwordResetSuccessfuly),
        CustomOtlinedButton(
          onPressed: () => context.go(AppRoutes.login),
          text: AppStrings.backToLogin,
        ),
      ],
    );
  }
}
