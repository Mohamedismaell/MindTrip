import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/entities/tour_package_entity.dart';

abstract class ExploreRepository {
  Future<Result<List<TourPackageEntity>>> getTourPackages();
}
