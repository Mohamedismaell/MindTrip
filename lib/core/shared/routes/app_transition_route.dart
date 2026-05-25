import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppTransitionRoute {
  //! Fade
  static GoRoute fade({
    required String path,
    required Widget page,
    List<RouteBase> routes = const [],
  }) {
    return GoRoute(
      path: path,
      routes: routes,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: page,
          transitionDuration: const Duration(milliseconds: 350),

          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    );
  }

  //! Slide From Right
  static GoRoute slideRight({
    required String path,
    required Widget page,
    List<RouteBase> routes = const [],
  }) {
    return GoRoute(
      path: path,
      routes: routes,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: page,
          transitionDuration: const Duration(milliseconds: 350),

          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                  ),
              child: child,
            );
          },
        );
      },
    );
  }

  //! Slide From Bottom
  static GoRoute slideBottom({
    required String path,
    required Widget page,
    List<RouteBase> routes = const [],
  }) {
    return GoRoute(
      path: path,
      routes: routes,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: page,
          transitionDuration: const Duration(milliseconds: 400),

          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
              child: child,
            );
          },
        );
      },
    );
  }

  //! Scale
  static GoRoute scale({
    required String path,
    required Widget page,
    List<RouteBase> routes = const [],
  }) {
    return GoRoute(
      path: path,
      routes: routes,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: page,
          transitionDuration: const Duration(milliseconds: 350),

          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return ScaleTransition(
              scale: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutBack,
              ),
              child: child,
            );
          },
        );
      },
    );
  }

  //! Fade + Slide (Best Modern One)
  static GoRoute fadeSlide({
    required String path,
    required Widget page,
    List<RouteBase> routes = const [],
  }) {
    return GoRoute(
      path: path,
      routes: routes,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: page,
          transitionDuration: const Duration(milliseconds: 250),

          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final slideAnimation =
                Tween<Offset>(
                  begin: const Offset(0.04, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                );

            return FadeTransition(
              opacity: animation,
              child: SlideTransition(position: slideAnimation, child: child),
            );
          },
        );
      },
    );
  }

  //! Fade + Slide with Builder
  static GoRoute fadeSlideBuilder({
    required String path,
    required Widget Function(BuildContext, GoRouterState) builder,
    List<RouteBase> routes = const [],
  }) {
    return GoRoute(
      path: path,
      routes: routes,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: builder(context, state),
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final slideAnimation =
                Tween<Offset>(
                  begin: const Offset(0.04, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                );
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(position: slideAnimation, child: child),
            );
          },
        );
      },
    );
  }

  //! Slide From Top with Builder
  static GoRoute slideTopBuilder({
    required String path,
    required Widget Function(BuildContext, GoRouterState) builder,
    List<RouteBase> routes = const [],
  }) {
    return GoRoute(
      path: path,
      routes: routes,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: builder(context, state),
          transitionDuration: const Duration(milliseconds: 300),

          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final slideAnimation =
                Tween<Offset>(
                  begin: const Offset(0, -1),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                );

            return SlideTransition(position: slideAnimation, child: child);
          },
        );
      },
    );
  }
}
