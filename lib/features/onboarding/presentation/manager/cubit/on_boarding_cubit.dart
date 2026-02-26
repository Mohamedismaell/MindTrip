import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/onboarding/domain/usecases/complete_onboarding_use_case.dart';
import 'package:mindtrip/features/onboarding/domain/usecases/save_selected_categories.dart';

part 'on_boarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({
    required this.completeOnboarding,
    required this.saveSelectedCategories,
  }) : super(const OnboardingState());
  final CompleteOnboardingUseCase completeOnboarding;
  final SaveSelectedCategories saveSelectedCategories;
  void updateIndex(int index) {
    if (index == 2) {
      emit(state.copyWith(currentIndex: index, isLastPage: true));
      // finishOnboarding(index);
      return;
    }
    emit(state.copyWith(currentIndex: index, isLastPage: false));
    // print(state.isLastPage);
  }

  Future<void> finishOnboarding(int index) async {
    await completeOnboarding.call();
  }

  void editSelectedCategory(String category) {
    final currentSelected = List<String>.from(state.selectedCategories ?? []);

    if (currentSelected.contains(category)) {
      currentSelected.remove(category);
    } else {
      currentSelected.add(category);
    }
    emit(state.copyWith(selectedCategories: currentSelected));
    print('$currentSelected');
  }

  void storeSelectedCategories() {
    saveSelectedCategories.call(state.selectedCategories!);
  }
}
