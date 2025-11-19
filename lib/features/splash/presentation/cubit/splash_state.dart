part of 'splash_cubit.dart';

@immutable
class SplashState {
  final List<String>? selectedCategories;
  final List<Categories> categories;

  const SplashState({
    required this.categories,
    this.selectedCategories,
  });

  SplashState copyWith({
    List<String>? selectedCategories,
    List<Categories>? categories,
    Color? buttonColor,
    Color? textColor,
  }) {
    return SplashState(
      selectedCategories:
          selectedCategories ?? this.selectedCategories,
      categories: categories ?? this.categories,
    );
  }
}
