// import 'package:flutter/material.dart';
// import '../app_colors.dart';

// class CustomColors {
//   final Color secondaryColor;
//   final Color buttonSelected;
//   final Color buttonUnselected;
//   final Color buttonTextSelected;
//   final Color buttonTextUnselected;
//   final Color searchBarUnseected;
//   final Color bottomAppbar;
//   const CustomColors._(
//       {required this.secondaryColor,
//       required this.buttonSelected,
//       required this.buttonUnselected,
//       required this.buttonTextSelected,
//       required this.buttonTextUnselected,
//       required this.searchBarUnseected,
//       required this.bottomAppbar});

//   factory CustomColors._light() {
//     return const CustomColors._(
//         secondaryColor: AppColors.blackDarker,
//         buttonSelected: AppColors.purplePrimary,
//         buttonUnselected: AppColors.greyLighter,
//         buttonTextSelected: AppColors.white,
//         buttonTextUnselected: AppColors.greyPrimary,
//         searchBarUnseected: AppColors.greyLighter,
//         bottomAppbar: AppColors.white
//         );
//   }

//   factory CustomColors._dark() {
//     return const CustomColors._(
//         secondaryColor: AppColors.greyLighter,
//         buttonSelected: Color(0xFF6C7FFF),
//         buttonUnselected: Color(0xFF2A2A2A),
//         buttonTextSelected: AppColors.white,
//         buttonTextUnselected: Color(0xFFB0B0B0),
//         searchBarUnseected: AppColors.greyLight,
//         bottomAppbar: AppColors.backGroundDark);
//   }
// }

// extension CustomColorExtension on ThemeData {
//   CustomColors get customColors => brightness == Brightness.dark
//       ? CustomColors._dark()
//       : CustomColors._light();
// }
