part of 'on_boarding_cubit.dart';

class OnboardingState extends Equatable {
  @override
  List<Object?> get props => [currentIndex, isLastPage];
  final int currentIndex;
  final bool isLastPage;
  const OnboardingState({this.currentIndex = 0, this.isLastPage = false});

  OnboardingState copyWith({
    int? currentIndex,
    bool? isLastPage,
  }) {
    return OnboardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }

  @override
  String toString() {
    return 'OnboardingState(currentIndex: $currentIndex, isLastPage: $isLastPage)';
  }
}
