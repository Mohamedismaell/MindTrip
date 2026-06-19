import 'package:mindtrip/features/explore/data/datasources/explore_local_data_source.dart';
import 'package:mindtrip/features/explore/data/datasources/explore_remote_data_source.dart';
import 'package:mindtrip/features/explore/domain/repositories/explore_repository.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  final ExploreRemoteDataSource remoteDataSource;
  final ExploreLocalDataSource localDataSource;

  ExploreRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
}
