import 'package:flutter/material.dart';
import 'package:mindtrip/core/utils/extension.dart';

class AppRefreshIndicator extends StatelessWidget {
  const AppRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  final Future<void> Function() onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: context.colorTheme.primary,
      backgroundColor: Colors.white,
      strokeWidth: 3,
      displacement: 20,
      edgeOffset: 10,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
