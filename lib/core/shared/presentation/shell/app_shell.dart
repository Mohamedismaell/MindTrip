import 'package:flutter/material.dart';
import 'package:mindtrip/core/shared/presentation/widget/connection_banner.dart';
// import 'package:news_app/core/connection/connection_visibility.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  final String location;

  const AppShell({super.key, required this.child, required this.location});

  @override
  Widget build(BuildContext context) {
    // final showBanner = shouldShowConnectionBanner(location);
    return Scaffold(
      // backgroundColor: Colors.transparent,
      // extendBody: true,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Stack(
              children: [
                child,
                // if (showBanner)
                const Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: ConnectionBanner(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
