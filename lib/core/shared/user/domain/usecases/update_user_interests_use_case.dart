import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/user/domain/repositories/user_repository.dart';

class UpdateUserInterestsUseCase {
  final UserRepository repository;

  UpdateUserInterestsUseCase(this.repository);

  Future<Result<void>> call(List<String> interests) async {
    return await repository.updateInterests(interests);
  }
}
