import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/presentation/widget/bottom_nav.dart';

class TabsShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const TabsShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    // final bool isKeyboardVisible = MediaQuery.viewInsetsOf(context).bottom > 0;
    // print(
    // 'MediaQuery.of(context).viewInsets.bottom ${MediaQuery.of(context).viewInsets.bottom}',
    // );
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: SafeArea(child: navigationShell),
      // bottomNavigationBar: isKeyboardVisible
      // ? const SizedBox.shrink()
      bottomNavigationBar: BottomNav(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
