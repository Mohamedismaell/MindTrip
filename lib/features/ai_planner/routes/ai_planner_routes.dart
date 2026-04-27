import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/screens/ai_planner_flow_screen.dart';
import 'package:mindtrip/features/ai_planner/presentation/screens/ai_planner_intro_screen.dart';

class AiPlannerRoutes {
  static final aiPlannerRoute = GoRoute(
    path: AppRoutes.aiPlannerIntro,
    builder: (context, state) => const AiPlannerIntroScreen(),
  );
  static final aiPlannerFlow = GoRoute(
    path: AppRoutes.aiPlannerFlow,
    builder: (context, state) => BlocProvider(
      create: (context) => sl<AiPlannerCubit>(),
      child: const AiPlannerFlowScreen(),
    ),
  );
}
