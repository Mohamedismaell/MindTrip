import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/onboarding/domain/usecases/complete_onboarding_use_case.dart';

part 'on_boarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({required this.completeOnboarding})
    : super(const OnboardingState());

  final CompleteOnboardingUseCase completeOnboarding;

  void updateIndex(int index) {
    if (index == 3) {
      emit(state.copyWith(currentIndex: index, isLastPage: true));
      return;
    }
    emit(state.copyWith(currentIndex: index, isLastPage: false));
  }

  Future<void> finishOnboarding() async {
    await completeOnboarding.call();
  }
}
