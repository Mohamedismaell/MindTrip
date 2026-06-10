import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/entities/tour_package_entity.dart';
import 'package:mindtrip/features/explore/domain/repositories/explore_repository.dart';

class GetTourPackagesUseCase {
  final ExploreRepository repository;

  GetTourPackagesUseCase({required this.repository});

  Future<Result<List<TourPackageEntity>>> call() async {
    return await repository.getTourPackages();
  }
}
