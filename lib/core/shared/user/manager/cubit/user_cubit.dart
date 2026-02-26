// import 'package:bloc/bloc.dart';
// import 'package:mindtrip/core/shared/user/data/models/user_model.dart';
// import 'package:mindtrip/core/shared/user/domain/usecases/get_current_user.dart';
// import 'package:equatable/equatable.dart';

// part 'user_state.dart';

// class UserCubit extends Cubit<UserState> {
//   UserCubit(this.getCurrentUser) : super(const UserState());
//   final GetCurrentUser getCurrentUser;

//   Future<void> loadUser() async {
//     emit(state.copyWith(status: LoadStatus.loading));

//     final result = await getCurrentUser.call();

//     result.when(
//       success: (user) =>
//           emit(state.copyWith(user: user, status: LoadStatus.loaded)),
//       failure: (f) =>
//           emit(state.copyWith(status: LoadStatus.error, message: f.message)),
//     );
//   }
// }
