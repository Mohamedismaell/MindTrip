import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SafeCubit<S> extends Cubit<S> {
  SafeCubit(super.initialState);

  @protected
  void emitSafe(S state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
