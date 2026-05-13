import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/chat_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/screens/ai_planner_chat_screen.dart';
import 'package:mindtrip/features/ai_planner/presentation/screens/ai_planner_flow_screen.dart';
import 'package:mindtrip/features/ai_planner/presentation/screens/ai_planner_intro_screen.dart';

class AiPlannerRoutes {
  static final aiPlannerRoute = GoRoute(
    path: AppRoutes.aiPlannerIntro,
    builder: (context, state) => const AiPlannerIntroScreen(),
  );
  static final aiPlannerFlowRoutes = [
    ShellRoute(
      builder: (context, state, child) {
        return MultiBlocProvider(
          providers: [BlocProvider(create: (context) => sl<AiPlannerCubit>())],
          child: child,
        );
      },

      routes: [
        GoRoute(
          path: AppRoutes.aiPlannerFlow,
          builder: (context, state) => const AiPlannerFlowScreen(),
          routes: [
            GoRoute(
              path: "chat",
              builder: (context, state) => BlocProvider(
                create: (_) => sl<ChatCubit>(),
                child: const AiPlannerChatScreen(),
              ),
            ),
          ],
        ),
      ],
    ),
  ];
}
