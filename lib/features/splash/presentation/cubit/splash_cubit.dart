import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:ttproj/features/splash/domain/entities/Categories.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit()
    : super(
        SplashState(
          categories: [
            Categories(name: '☕ Cafés'),
            Categories(name: '🥐 Bakeries'),
            Categories(name: '🎵 Music'),
            Categories(name: '🍢 Street Food Spots'),
            Categories(name: '🎳 Bowling'),
            Categories(name: '🍽️ Restaurants'),
          ],
        ),
      );

  void editSelectedCategory(String category) {
    final currentSelected = List<String>.from(
      state.selectedCategories ?? [],
    );

    if (currentSelected.contains(category)) {
      currentSelected.remove(category);
    } else {
      currentSelected.add(category);
    }
    emit(
      state.copyWith(selectedCategories: currentSelected),
    );
    debugPrint('$currentSelected');
  }
}
