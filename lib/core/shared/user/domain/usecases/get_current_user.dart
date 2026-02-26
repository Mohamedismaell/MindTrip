import 'package:mindtrip/core/shared/user/domain/repositories/user_repository.dart';

class GetCurrentUser {
  final UserRepository repository;

  GetCurrentUser({required this.repository});

  // Future<Result<UserModel>> call() {
  //   return repository.getCurrentUser();
  // }
}
