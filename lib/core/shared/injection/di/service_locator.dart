// import 'package:mindtrip/core/connections/retry_queue.dart';
// import 'package:mindtrip/core/connections/retry_runner.dart';
// import 'package:mindtrip/core/database/api/api_interceptor.dart';
// import 'package:mindtrip/core/theme/cubit/theme_cubit.dart';
// import 'package:mindtrip/features/auth/domain/usecases/login_email.dart';
// import 'package:mindtrip/features/auth/domain/usecases/otp.dart';
// import 'package:mindtrip/features/auth/domain/usecases/sign_up_email.dart';
// import 'package:mindtrip/features/auth/domain/usecases/update_passwords.dart';
// import 'package:mindtrip/features/book/data/datasources/books_remote_data_source.dart';
// import 'package:mindtrip/features/book/data/repositories/book_repository_impl.dart';
// import 'package:mindtrip/features/book/domain/repositories/book_repository.dart';
// import 'package:mindtrip/features/book/domain/usecases/avatar_usecase.dart';
// import 'package:mindtrip/features/book/domain/usecases/book_marks.dart';
// import 'package:mindtrip/features/book/domain/usecases/books_usecase.dart';
// import 'package:mindtrip/features/book/domain/usecases/chapters_usecase.dart';
// import 'package:mindtrip/features/book/domain/usecases/progress_usecase.dart';
// import 'package:mindtrip/features/book/domain/usecases/user_profile_usecase.dart';
// import 'package:mindtrip/features/book/domain/usecases/user_stats_usecase.dart';
// import 'package:mindtrip/features/book/presentation/cubit/all_books/books_cubit.dart';
// import 'package:mindtrip/features/book/presentation/cubit/book_id/book_cubit.dart';
// import 'package:mindtrip/features/book/presentation/cubit/book_marks/book_marks_cubit.dart';
// import 'package:mindtrip/features/book/presentation/cubit/chapters_id/chapters_cubit.dart';
// import 'package:mindtrip/features/book/presentation/cubit/profile/profile_cubit.dart';
// import 'package:mindtrip/features/book/presentation/cubit/reading_pregress/reading_progress_cubit.dart';
// import 'package:mindtrip/features/book/presentation/cubit/user_stats/user_stats_cubit.dart';
// import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// import '../../../../features/auth/data/repositories/auth_repository_impl.dart';
// import '../../../../features/auth/data/sources/auth_remote_data_source.dart';
// import '../../../../features/auth/domain/repositories/auth_repository.dart';
// import '../../../../features/auth/domain/usecases/forget_password.dart';
// import '../../../../features/auth/domain/usecases/login_google.dart';
// import '../../../../features/auth/domain/usecases/logout.dart';
// import '../../../../features/auth/presentation/cubit/cubit/auth_cubit.dart';
// import '../../routes/auth_notifier.dart';
// import '../../../connections/network_info.dart';
// import '../../../database/api/dio_consumer.dart';

// final sl = GetIt.instance;

// Future<void> initServiceLocator() async {
//   sl.registerLazySingleton(() => ThemeCubit());
//   sl.registerLazySingleton(() => Dio());
//   sl.registerLazySingleton(() => InternetConnection());

//   //! Core
//   sl.registerLazySingleton<NetworkInfo>(
//     () => NetworkInfoImpl(sl<InternetConnection>()),
//   );
//   sl.registerLazySingleton(() => RetryQueue());
//   sl.registerLazySingleton(() => RetryRunner(sl<Dio>(), sl<RetryQueue>()));

//   sl.registerLazySingleton(
//     () => ApiInterceptor(sl<NetworkInfo>(), sl<RetryQueue>()),
//   );
//   sl.registerLazySingleton(() => DioConsumer(sl<Dio>(), sl<ApiInterceptor>()));
//   sl.registerLazySingleton(() => AuthNotifier());

//   //! Data Sources
//   //* Books
//   sl.registerLazySingleton<BooksRemoteDataSource>(
//     () => BooksRemoteDataSource(supabase: sl<SupabaseClient>()),
//   );
//   //! Repositories

//   sl.registerLazySingleton<BookRepository>(
//     () => BookRepositoryImpl(
//       remoteDataSource: sl<BooksRemoteDataSource>(),
//       networkInfo: sl<NetworkInfo>(),
//     ),
//   );

//   //! Use Cases

//   //* Books
//   sl.registerLazySingleton(
//     () => GetBooksUseCase(repository: sl<BookRepository>()),
//   );
//   sl.registerLazySingleton(
//     () => GetChaptersUseCase(repository: sl<BookRepository>()),
//   );
//   sl.registerLazySingleton(
//     () => GetBooksIdUseCase(repository: sl<BookRepository>()),
//   );
//   sl.registerLazySingleton(
//     () => InsertReadingPregress(repository: sl<BookRepository>()),
//   );
//   sl.registerLazySingleton(
//     () => GetReadingProgress(repository: sl<BookRepository>()),
//   );
//   sl.registerLazySingleton(
//     () => UpdateUserStats(repository: sl<BookRepository>()),
//   );
//   sl.registerLazySingleton(
//     () => GetUserStats(repository: sl<BookRepository>()),
//   );
//   sl.registerLazySingleton(
//     () => GetUserProfile(repository: sl<BookRepository>()),
//   );
//   sl.registerLazySingleton(
//     () => UpdateUserProfile(repository: sl<BookRepository>()),
//   );
//   sl.registerLazySingleton(
//     () => UploadAvatar(repository: sl<BookRepository>()),
//   );
//   sl.registerLazySingleton(
//     () => InsertBookMarks(repository: sl<BookRepository>()),
//   );
//   sl.registerLazySingleton(
//     () => RemoveBookMarks(repository: sl<BookRepository>()),
//   );
//   sl.registerLazySingleton(
//     () => GetBookMarks(repository: sl<BookRepository>()),
//   );
//   //Todo Edit the cubit to registerFactory rather than registerLazySingleton if its not widly used and need to be reset
//   //! Cubits

//   sl.registerLazySingleton(() => BooksCubit(sl<GetBooksUseCase>()));
//   sl.registerLazySingleton(() => BookCubit(sl<GetBooksIdUseCase>()));

//   sl.registerLazySingleton(() => ChaptersCubit(sl<GetChaptersUseCase>()));
//   sl.registerLazySingleton(
//     () => ReadingProgressCubit(
//       sl<InsertReadingPregress>(),
//       sl<GetReadingProgress>(),
//     ),
//   );
//   sl.registerLazySingleton(
//     () => UserStatsCubit(sl<UpdateUserStats>(), sl<GetUserStats>()),
//   );
//   sl.registerLazySingleton(
//     () => ProfileCubit(
//       sl<GetUserProfile>(),
//       sl<UpdateUserProfile>(),
//       sl<UploadAvatar>(),
//       // sl<GetAvatar>(),
//     ),
//   );
//   sl.registerLazySingleton(
//     () => BookMarksCubit(
//       sl<InsertBookMarks>(),
//       sl<RemoveBookMarks>(),
//       sl<GetBookMarks>(),
//     ),
//   );
//   sl.registerLazySingleton(() => ThemeCubit());
// }
