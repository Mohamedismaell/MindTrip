import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/search/data/datasources/search_local_data_source.dart';
import 'package:mindtrip/features/search/data/datasources/search_remote_data_source.dart';
import 'package:mindtrip/features/search/data/repositories/search_repository_impl.dart';
import 'package:mindtrip/features/search/domain/repositories/search_repository.dart';
import 'package:mindtrip/features/search/domain/use_cases/get_recent_searches_use_case.dart';
import 'package:mindtrip/features/search/domain/use_cases/save_recent_search_use_case.dart';
import 'package:mindtrip/features/search/domain/use_cases/clear_recent_searches_use_case.dart';
import 'package:mindtrip/features/search/domain/use_cases/search_places_use_case.dart';
import 'package:mindtrip/features/search/presentation/bloc/global_search_bloc.dart';
import 'package:mindtrip/features/search/presentation/cubit/voice_search_cubit.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SearchDi {
  SearchDi._();

  static void init() {
    //! DataSources
    sl.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(api: sl()),
    );
    sl.registerLazySingleton<SearchLocalDataSource>(
      () => SearchLocalDataSourceImpl(),
    );

    //! Repository
    sl.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
    );

    //! UseCases
    sl.registerLazySingleton<SearchPlacesUseCase>(
      () => SearchPlacesUseCase(sl()),
    );
    sl.registerLazySingleton<GetRecentSearchesUseCase>(
      () => GetRecentSearchesUseCase(sl()),
    );
    sl.registerLazySingleton<SaveRecentSearchUseCase>(
      () => SaveRecentSearchUseCase(sl()),
    );
    sl.registerLazySingleton<ClearRecentSearchesUseCase>(
      () => ClearRecentSearchesUseCase(sl()),
    );

    sl.registerFactory<GlobalSearchBloc>(
      () => GlobalSearchBloc(
        searchPlacesUseCase: sl(),
        getRecentSearchesUseCase: sl(),
        saveRecentSearchUseCase: sl(),
        clearRecentSearchesUseCase: sl(),
      ),
    );

    sl.registerLazySingleton<SpeechToText>(() => SpeechToText());
    sl.registerFactory<VoiceSearchCubit>(() => VoiceSearchCubit(sl()));
  }
}
