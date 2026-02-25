// import 'package:flutter/material.dart';

// class NavigatorObserverTest extends NavigatorObserver {
//   NavigatorObserverTest._();
//   static final NavigatorObserverTest _instance = NavigatorObserverTest._();
//   static NavigatorObserverTest get instance => _instance;
// }

import 'package:flutter/material.dart';

class NavigatorObserverTest extends NavigatorObserver {
  /// The [Navigator] pushed `route`.
  ///
  /// The route immediately below that one, and thus the previously active
  /// route, is `previousRoute`.
  @override
  void didPush(Route route, Route? previousRoute) {
    // print("PUSHED: ${route.settings.name}");
  }

  /// The [Navigator] popped `route`.
  ///
  /// The route immediately below that one, and thus the newly active
  /// route, is `previousRoute`.
  @override
  void didPop(Route route, Route? previousRoute) {
    // print("POPPED: ${route.settings.name}");
  }

  /// The [Navigator] removed `route`.
  ///
  /// If only one route is being removed, then the route immediately below
  /// that one, if any, is `previousRoute`.
  ///
  /// If multiple routes are being removed, then the route below the
  /// bottommost route being removed, if any, is `previousRoute`, and this
  /// method will be called once for each removed route, from the topmost route
  /// to the bottommost route.
  @override
  void didRemove(Route route, Route? previousRoute) {
    // print("REMOVED: ${route.settings.name}");
  }

  /// The [Navigator] replaced `oldRoute` with `newRoute`.
  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    // print("REPLACED: ${oldRoute?.settings.name} → ${newRoute?.settings.name}");
  }

  /// The top most route has changed.
  ///
  /// The `topRoute` is the new top most route. This can be a new route pushed
  /// on top of the screen, or an existing route that becomes the new top-most
  /// route because the previous top-most route has been popped.
  ///
  /// The `previousTopRoute` was the top most route before the change. This can
  /// be a route that was popped off the screen, or a route that will be covered
  /// by the `topRoute`. This can also be null if this is the first build.
  @override
  void didChangeTop(Route<dynamic> topRoute, Route<dynamic>? previousTopRoute) {
    // print("CHANGED TOP: ${topRoute.settings.name}");
  }

  /// The [Navigator]'s routes are being moved by a user gesture.
  ///
  /// For example, this is called when an iOS back gesture starts, and is used
  /// to disable hero animations during such interactions.
  @override
  void didStartUserGesture(
      Route<dynamic> route, Route<dynamic>? previousRoute) {
    // print("STARTED USER GESTURE: ${route.settings.name}");
  }

  /// User gesture is no longer controlling the [Navigator].
  ///
  /// Paired with an earlier call to [didStartUserGesture].
  @override
  void didStopUserGesture() {
    // print("STOPPED USER GESTURE");
  }
}
