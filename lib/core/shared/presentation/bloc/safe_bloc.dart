import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SafeBloc<E, S> extends Bloc<E, S> {
  SafeBloc(super.initialState);

  @protected
  void emitSafe(Emitter<S> emit, S state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
