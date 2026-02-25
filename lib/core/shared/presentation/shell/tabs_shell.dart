import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TabsShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const TabsShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(child: navigationShell),
      // bottomNavigationBar: BottomNav(
      //   currentIndex: navigationShell.currentIndex,
      //   onTap: (index) {
      //     navigationShell.goBranch(
      //       index,
      //       initialLocation: index == navigationShell.currentIndex,
      //     );
      //   },
      // ),
    );
  }
}
