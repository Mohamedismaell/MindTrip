import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/user/domain/usecases/get_current_user.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetCurrentUser _getCurrentUser;

  UserCubit({required GetCurrentUser getCurrentUser})
    : _getCurrentUser = getCurrentUser,
      super(const UserState());

  Future<void> loadUser() async {
    emit(state.copyWith(status: UserStatus.loading));

    final result = await _getCurrentUser.call();

    result.when(
      success: (user) =>
          emit(state.copyWith(user: user, status: UserStatus.loaded)),
      failure: (f) =>
          emit(state.copyWith(status: UserStatus.error, message: f.message)),
    );
  }

  void setUser(UserEntity user) {
    emit(state.copyWith(user: user, status: UserStatus.loaded));
  }

  void clear() {
    emit(const UserState());
  }
}
