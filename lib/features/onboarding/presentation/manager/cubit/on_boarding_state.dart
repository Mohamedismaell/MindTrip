// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'on_boarding_cubit.dart';

class OnboardingState extends Equatable {
  final int currentIndex;
  final bool isLastPage;
  final List<String>? selectedCategories;
  // final List<InterestCategories> categories;
  const OnboardingState({
    this.currentIndex = 0,
    this.isLastPage = false,
    this.selectedCategories = const [],
    // this.categories = const [],
  });
  OnboardingState copyWith({
    int? currentIndex,
    bool? isLastPage,
    List<String>? selectedCategories,
  }) {
    return OnboardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      isLastPage: isLastPage ?? this.isLastPage,
      selectedCategories: selectedCategories ?? this.selectedCategories,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [currentIndex, isLastPage, selectedCategories];
}
