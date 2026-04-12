part of 'user_cubit.dart';

enum UserStatus { initial, loading, loaded, error }

class UserState extends Equatable {
  final UserEntity? user;
  final UserStatus status;
  final String? message;

  const UserState({
    this.user,
    this.status = UserStatus.initial,
    this.message,
  });

  UserState copyWith({UserEntity? user, UserStatus? status, String? message}) {
    return UserState(
      user: user ?? this.user,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [user, status, message];
}
