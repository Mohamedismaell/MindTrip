import 'package:flutter/material.dart';
// import 'package:news_app/core/connection/connection_visibility.dart';

class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: child,
      ),
    );
    // Scaffold(
    //   // backgroundColor: Colors.transparent,
    //   // extendBody: true,
    //   body: BlocListener<AppConnectionCubit, AppConnectionState>(
    //     listener: (context, state) {
    //       if (state is Connected) {
    //         context.read<FavoriteCubit>().syncPendingFavorites();
    //       }
    //     },
    //     child: SafeArea(
    //       bottom: false,
    //       child: Stack(
    //         children: [
    //           child,
    //           // if (showBanner)
    //           const Positioned(
    //             bottom: 10,
    //             left: 0,
    //             right: 0,
    //             child: ConnectionBanner(),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
