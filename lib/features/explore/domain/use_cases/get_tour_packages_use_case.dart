import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/explore/domain/repositories/explore_repository.dart';
import 'package:mindtrip/features/home/domain/entity/tour_package_entity.dart';

class GetTourPackagesUseCase {
  final ExploreRepository repository;

  GetTourPackagesUseCase({required this.repository});

  Future<Result<List<TourPackageEntity>>> call() async {
    return await repository.getTourPackages();
  }
}
