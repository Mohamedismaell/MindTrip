import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';

class ForgetPasswordUseCase {
  final AuthRepository _repository;

  const ForgetPasswordUseCase({required AuthRepository repository})
    : _repository = repository;

  Future<Result<void>> call({required String email}) {
    return _repository.forgetPassword(email: email);
  }
}
