import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;
import 'package:mindtrip/core/connections/retry_runner.dart';
import 'package:mindtrip/core/database/cache/app_hive.dart';
import 'package:mindtrip/core/helper/hydrated_storage.dart';
import 'package:mindtrip/core/shared/data/datasources/places_local_data_source.dart';
import 'package:mindtrip/core/shared/favorite/cubit/favorite_cubit.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/location/cubit/location_cubit.dart';
import 'package:mindtrip/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:mindtrip/core/shared/presentation/manager/connection_cubit/connection_cubit.dart';
import 'package:mindtrip/core/shared/presentation/widget/connection_listener.dart';
import 'package:mindtrip/core/shared/routes/app_router.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/theme_data_/light_theme_data.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_cubit.dart';
import 'package:mindtrip/features/explore/presentation/data/explore_mock_data.dart';
import 'package:mindtrip/features/home/presentation/data/home_mock_data.dart';
import 'core/observers/app_bloc_observer.dart';
import 'core/theme/cubit/theme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('Step 1: ensureInitialized done');
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await GoogleAuthProvider.initialize();
  // print('Firebase initialized');
  Bloc.observer = AppBlocObserver();
  print('Step 2: Bloc observer set');
  HydratedBloc.storage = await buildHydratedStorage();
  print('Step 3: HydratedStorage built');
  await AppHive.init();

  await initializeDependencies();
  print('Step 4: Service Locator initialized');
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  //! do we need it ?
  //map
  const token = String.fromEnvironment("ACCESS_TOKEN");
  mapbox.MapboxOptions.setAccessToken(token);
  //Todo: remove later
  print('Step 5: Bootstrapping Mock Places Cache');
  final placesCache = sl<PlacesLocalDataSource>();
  await placesCache.cachePlaces(HomeMockData.popularDestinations);
  await placesCache.cachePlaces(HomeMockData.recommendedDestinations);
  await placesCache.cachePlaces(ExploreMockData.trendingPlaces);
  await placesCache.cachePlaces(ExploreMockData.otherPlaces);
  const accessToken = String.fromEnvironment('ACCESS_TOKEN');
  const googlePlacesKey = String.fromEnvironment('GOOGLE_PLACES_KEY');
  const googleWebClientId = String.fromEnvironment('GOOGLE_WEB_CLIENT_ID');

  debugPrint('TOKEN => $accessToken');
  debugPrint('GOOGLE_PLACES_KEY => $googlePlacesKey');
  debugPrint('GOOGLE_WEB_CLIENT_ID => $googleWebClientId');

  runApp(
    // DevicePreview(enabled: !kReleaseMode, builder: (context) => AppBootstrap()),
    AppBootstrap(),
  );
}

//!providers
class AppBootstrap extends StatelessWidget {
  const AppBootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppConnectionCubit>(
          create: (_) =>
              AppConnectionCubit(sl<InternetConnection>(), sl<RetryRunner>()),
        ),
        BlocProvider<ThemeCubit>(create: (_) => sl<ThemeCubit>()),
        BlocProvider<AppGateCubit>(create: (_) => sl<AppGateCubit>()),
        BlocProvider<UserCubit>(create: (_) => sl<UserCubit>()),
        BlocProvider<AuthCubit>(create: (_) => sl<AuthCubit>()),
        BlocProvider<FavoriteCubit>(create: (_) => sl<FavoriteCubit>()),
        BlocProvider<LocationCubit>(create: (_) => sl<LocationCubit>()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // if (kDebugMode) {
    //   print(
    //     "USER EMAIL ===> **** ${sl<SupabaseClient>().auth.currentUser?.email} ****",
    //   );
    // }
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, mode) {
        return ScreenUtilInit(
          designSize: const Size(393, 852),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => MaterialApp.router(
            // locale: DevicePreview.locale(context),
            // builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            theme: getLightTheme(),
            darkTheme: getLightTheme(),
            themeMode: mode.themeMode,
            routerConfig: sl<AppRouter>().appRouter,
            builder: (context, child) {
              child = DevicePreview.appBuilder(context, child);
              return ConnectionListener(child: child);
            },
          ),
        );
      },
    );
  }
}
