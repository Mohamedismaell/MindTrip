import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/features/onboarding/presentation/manager/cubit/on_boarding_cubit.dart';
import 'package:mindtrip/core/utils/app_strings.dart';
import 'package:mindtrip/features/onboarding/presentation/widgets/interest_buttons.dart';
import 'package:mindtrip/features/onboarding/presentation/widgets/interest_header.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.5.w, vertical: 46.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InterestsHeader(),
              Expanded(child: InterestesButton()),
              SizedBox(height: 34.h),
              Center(
                child: CustomGradientButton(
                  text: AppStrings.save,
                  onTap: () async {
                    final cubit = context.read<OnboardingCubit>();
                    final categories = cubit.state.selectedCategories ?? [];
                    if (categories.isEmpty) return; // Might want to show a snackbar here

                    // We are using the Authenticated flow
                    final userCubit = context.read<UserCubit>();
                    final result = await userCubit.updateUserInterests(categories);

                    result.when(
                      success: (_) {
                        // Let AppGate know we finished setting interests
                        context.read<AppGateCubit>().interestsComplete();
                      },
                      failure: (failure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(failure.message)),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
