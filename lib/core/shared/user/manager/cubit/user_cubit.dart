import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/user/domain/usecases/get_current_user.dart';
import 'package:mindtrip/core/shared/user/domain/usecases/update_user_interests_use_case.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';
import 'package:mindtrip/core/connections/result.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetCurrentUser _getCurrentUser;
  final UpdateUserInterestsUseCase _updateUserInterests;

  UserCubit({
    required GetCurrentUser getCurrentUser,
    required UpdateUserInterestsUseCase updateUserInterests,
  }) : _getCurrentUser = getCurrentUser,
       _updateUserInterests = updateUserInterests,
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

  Future<Result<void>> updateUserInterests(List<String> interests) async {
    final result = await _updateUserInterests(interests);
    result.when(
      success: (_) {
        if (state.user != null) {
          final updatedUser = UserEntity(
            userId: state.user!.userId,
            displayName: state.user!.displayName,
            email: state.user!.email,
            profilePhotoUrl: state.user!.profilePhotoUrl,
            languagePreference: state.user!.languagePreference,
            interests: interests,
          );
          emit(state.copyWith(user: updatedUser));
        }
      },
      failure: (_) {},
    );
    return result;
  }

  void clear() {
    emit(const UserState());
  }
}
