part of 'on_boarding_cubit.dart';

enum OnboardingStatus { initial, loading, success, error }

class OnboardingState extends Equatable {
  final int currentIndex;
  final bool isLastPage;
  final List<String>? selectedCategories;
  final OnboardingStatus status;
  final String? errorMessage;
  // final List<InterestCategories> categories;
  const OnboardingState({
    this.currentIndex = 0,
    this.isLastPage = false,
    this.selectedCategories = const [],
    this.status = OnboardingStatus.initial,
    this.errorMessage,
    // this.categories = const [],
  });
  OnboardingState copyWith({
    int? currentIndex,
    bool? isLastPage,
    List<String>? selectedCategories,
    OnboardingStatus? status,
    String? errorMessage,
  }) {
    return OnboardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      isLastPage: isLastPage ?? this.isLastPage,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
    currentIndex,
    isLastPage,
    selectedCategories,
    status,
    errorMessage,
  ];
}
