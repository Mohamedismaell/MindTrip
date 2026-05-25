import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mindtrip/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/extension.dart';
// import 'package:mindtrip/features/onboarding/data/sources/on_boarding_local_data_source.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // // TODO: remove this after testing
  // late OnboardingLocalDataSourceImpl onboardingLocalDataSourceImpl =
  //     OnboardingLocalDataSourceImpl();
  @override
  void initState() {
    super.initState();
    // // TODO: remove this after testing
    // onboardingLocalDataSourceImpl.clearOnboardingBox();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      context.read<AppGateCubit>().start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        alignment: AlignmentGeometry.center,
        children: [
          Center(
            child: SizedBox(
              width: 240.w,
              height: 240.h,
              child: Image.asset(
                'assets/images/splash/nativelogo.png',
                fit: BoxFit.contain,
                // color: Colors.white,
                // colorBlendMode: BlendMode.srcIn,
              ),
            ),
          ),
          Opacity(
            opacity: 0.12,
            child: Image.asset(AppAssets.splashPattern, fit: BoxFit.cover),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 310.h,
            child: Center(
              child: Text(
                'Mind Trip',
                style: AppTextStyles.h4Bold.copyWith(
                  color: context.colorTheme.primary,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 230.h,
            child: Lottie.asset(
              AppAssets.loadingAnimation,
              fit: BoxFit.contain,
              // width: 100.w,
              height: 100.h,
            ),
          ),
        ],
      ),
    );
  }
}
