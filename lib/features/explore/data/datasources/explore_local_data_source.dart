import 'package:mindtrip/core/shared/domain/entities/tour_package_entity.dart';
import 'package:mindtrip/features/home/presentation/data/home_mock_data.dart';

abstract class ExploreLocalDataSource {
  Future<List<TourPackageEntity>> getTourPackages();
}

class ExploreLocalDataSourceImpl implements ExploreLocalDataSource {
  @override
  Future<List<TourPackageEntity>> getTourPackages() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return HomeMockData.tourPackages;
  }
}
