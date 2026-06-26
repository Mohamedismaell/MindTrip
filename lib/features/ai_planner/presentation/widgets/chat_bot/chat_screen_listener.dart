import 'package:flutter/material.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner_status_listener.dart';

class ChatScreenListener extends StatelessWidget {
  const ChatScreenListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AiPlannerStatusListener(child: child);
  }
}
