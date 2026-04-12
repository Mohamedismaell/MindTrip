import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Result<UserEntity>> getCurrentUser();
}
