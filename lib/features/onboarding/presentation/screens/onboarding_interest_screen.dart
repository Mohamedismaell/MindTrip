import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:mindtrip/core/shared/presentation/widget/interest_selectoin.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/features/onboarding/presentation/manager/cubit/on_boarding_cubit.dart';

class OnboardingInterestScreen extends StatelessWidget {
  const OnboardingInterestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listener: (context, onboardingState) {
        if (onboardingState.status == OnboardingStatus.success) {
          context.read<AppGateCubit>().interestsComplete();
        }

        if (onboardingState.status == OnboardingStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(onboardingState.errorMessage ?? 'Error')),
          );
        }
      },
      child: InterestSelectoin(
        onTap: () {
          context.read<OnboardingCubit>().submitInterests(
            context.read<UserCubit>(),
          );
        },
      ),
    );
  }
}
