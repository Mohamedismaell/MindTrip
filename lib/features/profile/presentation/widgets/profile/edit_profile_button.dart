import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () => context.push(AppRoutes.editProfile),
        borderRadius: BorderRadius.circular(30.r),

        child: CustomGradientButton(
          width: 170.w,
          text: "Edit Profile",
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 20.w,
                child: SvgPicture.asset(ProfileAssets.editIcon),
              ),
              SizedBox(width: 10.w),
              Text(
                'Edit Profile',
                style: AppTextStyles.h8Bold.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
