import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/entities/banner_entity.dart';
import 'package:mindtrip/features/home/domain/repositories/home_repository.dart';

class GetBannersUseCase {
  final HomeRepository repository;

  GetBannersUseCase({required this.repository});

  Future<Result<List<BannerEntity>>> call() async {
    return await repository.getBanners();
  }
}
