import 'package:freezed_annotation/freezed_annotation.dart';
part 'pagination_state.freezed.dart';

@freezed
abstract class PaginationState<T> with _$PaginationState<T> {
  const factory PaginationState({
    @Default([]) List<T> items,
    @Default(1) int currentPage,
    @Default(true) bool hasMore,
    @Default(false) bool isMoreLoading,
  }) = _PaginationState<T>;
}
