import 'package:flutter/material.dart';
import 'package:ttproj/core/theme/app_colors.dart';

class OnboardingProgress extends StatelessWidget {
  final int currentPage;

  const OnboardingProgress({
    super.key,
    required this.currentPage,
  });
  //! Edit animation later
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        final bool isActive = index == currentPage;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(right: 8),
          height: 7,
          width: isActive ? 45.29 : 25.88,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primaryBlue
                : AppColors.primaryLightBlue1,
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}
