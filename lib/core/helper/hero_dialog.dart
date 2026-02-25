// import 'package:flutter/material.dart';

// /// A custom Route that allows Hero animations to work with Dialogs.
// /// It keeps the background transparent so it looks like a popup.
// class HeroDialogRoute<T> extends PageRoute<T> {
//   final WidgetBuilder builder;

//   HeroDialogRoute({
//     required this.builder,
//     super.settings,
//     super.fullscreenDialog,
//   });

//   @override
//   bool get opaque => false; // Essential: makes the background transparent

//   @override
//   bool get barrierDismissible => true; // Allows clicking outside to close

//   @override
//   Duration get transitionDuration => const Duration(milliseconds: 300);

//   @override
//   bool get maintainState => true;

//   @override
//   Color get barrierColor => Colors.black54; // Dimmed background color

//   @override
//   Widget buildTransitions(
//     BuildContext context,
//     Animation<double> animation,
//     Animation<double> secondaryAnimation,
//     Widget child,
//   ) {
//     return FadeTransition(
//       opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
//       child: child,
//     );
//   }

//   @override
//   Widget buildPage(
//     BuildContext context,
//     Animation<double> animation,
//     Animation<double> secondaryAnimation,
//   ) {
//     return builder(context);
//   }

//   @override
//   String? get barrierLabel => 'Dismiss';
// }
