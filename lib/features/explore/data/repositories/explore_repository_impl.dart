import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/features/explore/data/datasources/explore_local_data_source.dart';
import 'package:mindtrip/features/explore/domain/repositories/explore_repository.dart';
import 'package:mindtrip/features/home/domain/entity/tour_package_entity.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  final ExploreLocalDataSource localDataSource;

  ExploreRepositoryImpl({required this.localDataSource});

  @override
  Future<Result<List<TourPackageEntity>>> getTourPackages() async {
    try {
      final packages = await localDataSource.getTourPackages();
      return Result.ok(packages);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }
}
