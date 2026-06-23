import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/onboarding/domain/usecases/complete_onboarding_use_case.dart';

part 'on_boarding_state.dart';

class OnboardingCubit extends SafeCubit<OnboardingState> {
  OnboardingCubit({required this.completeOnboarding})
    : super(const OnboardingState());

  final CompleteOnboardingUseCase completeOnboarding;

  void updateIndex(int index) {
    if (index == 3) {
      emitSafe(state.copyWith(currentIndex: index, isLastPage: true));
      return;
    }
    emitSafe(state.copyWith(currentIndex: index, isLastPage: false));
  }

  Future<void> finishOnboarding() async {
    await completeOnboarding.call();
  }
}
