import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/home/presentation/screens/home_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/home/presentation/cubit/home_cubit.dart';

class HomeRoutes {
  static final homeRoute = GoRoute(
    path: AppRoutes.home,
    builder: (context, state) => BlocProvider<HomeCubit>(
      create: (context) => sl<HomeCubit>()..loadAllData(),
      child: const HomeScreen(),
    ),
  );
}
