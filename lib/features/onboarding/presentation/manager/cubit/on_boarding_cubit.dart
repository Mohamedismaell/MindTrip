import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ttproj/features/onboarding/domain/usecases/complete_onboarding_use_case.dart';

part 'on_boarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this.completeOnboarding) : super(const OnboardingState());
  final CompleteOnboardingUseCase completeOnboarding;

  void updateIndex(int index) {
    if (index == 0) {
      emit(state.copyWith(currentIndex: index, isLastPage: true));
      finishOnboarding(index);
      return;
    }
    emit(state.copyWith(currentIndex: index));
    // print(state.isLastPage);
  }

  Future<void> finishOnboarding(int index) async {
    await completeOnboarding.call();
  }
}
