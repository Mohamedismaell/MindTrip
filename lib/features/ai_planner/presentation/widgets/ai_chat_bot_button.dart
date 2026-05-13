import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/chat_bot_image.dart';

class AiChatBotButton extends StatelessWidget {
  const AiChatBotButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.aiPlannerChat);
      },
      child: ChatBotImage(width: 62, height: 62, isButton: true),
    );
  }
}
