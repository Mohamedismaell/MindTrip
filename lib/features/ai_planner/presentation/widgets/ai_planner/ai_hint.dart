import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';

class AiHint extends StatefulWidget {
  const AiHint({super.key, required this.message, required this.actionMessage});

  final String message;
  final String actionMessage;

  @override
  State<AiHint> createState() => _AiHintState();
}

class _AiHintState extends State<AiHint> {
  late TapGestureRecognizer _termsRecognizer;

  @override
  void initState() {
    super.initState();
    _termsRecognizer = TapGestureRecognizer()..onTap = _onTap;
  }

  void _onTap() {
    context.push(AppRoutes.aiPlannerChat);
  }

  @override
  void dispose() {
    _termsRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: widget.message,
            style: AppTextStyles.h9Medium.copyWith(
              color: context.colorTheme.onSurface,
            ),
          ),
          TextSpan(
            text: widget.actionMessage,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorTheme.primary,
            ),

            recognizer: _termsRecognizer,
          ),
        ],
      ),
    );
  }
}
