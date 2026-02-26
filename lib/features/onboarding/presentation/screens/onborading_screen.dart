import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttproj/features/onboarding/presentation/manager/cubit/on_boarding_cubit.dart';
import 'package:ttproj/features/onboarding/presentation/widgets/onboarding_content.dart';
import 'package:ttproj/features/onboarding/presentation/widgets/onboarding_pages.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            top: false,
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                OnboardingPages(pageController: pageController),
                OnboardingContent(pageController: pageController, state: state),
              ],
            ),
          ),
        );
      },
    );
  }
}
