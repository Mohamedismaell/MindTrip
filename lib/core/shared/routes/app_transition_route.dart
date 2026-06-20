import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef AppTransitionBuilder =
    Widget Function(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    );

class AppTransitionRoute {
  AppTransitionRoute._();

  static GoRoute custom({
    required String path,
    required Widget Function(BuildContext, GoRouterState) builder,
    required AppTransitionBuilder transition,
    Duration duration = const Duration(milliseconds: 300),
    bool opaque = true,
    List<RouteBase> routes = const [],
  }) {
    return GoRoute(
      path: path,
      routes: routes,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          opaque: opaque,
          transitionDuration: duration,
          transitionsBuilder: transition,
          child: builder(context, state),
        );
      },
    );
  }

  // Transitions

  static Widget fade(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }

  static Widget slideRight(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
      child: child,
    );
  }

  static Widget slideBottom(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
      child: child,
    );
  }

  static Widget slideTop(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, -1),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
      child: child,
    );
  }

  static Widget scale(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return ScaleTransition(
      scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
      child: child,
    );
  }

  static Widget fadeSlide(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final slide = Tween<Offset>(
      begin: const Offset(.04, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(position: slide, child: child),
    );
  }
}

class BottomSheetPage extends CustomTransitionPage<void> {
  const BottomSheetPage({required super.child, super.key})
    : super(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: AppTransitionRoute.slideBottom,
      );
}
