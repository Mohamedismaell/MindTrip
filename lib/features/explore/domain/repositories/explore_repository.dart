import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/home/domain/entity/tour_package_entity.dart';

abstract class ExploreRepository {
  Future<Result<List<TourPackageEntity>>> getTourPackages();
}
