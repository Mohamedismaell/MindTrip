// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'global_search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GlobalSearchState {

 List<PlaceEntity> get results; List<RecentSearchEntity> get recentSearches; GlobalSearchStatus get status; String? get errorMessage; int get currentPage; bool get hasReachedMax; String? get lastQuery;
/// Create a copy of GlobalSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GlobalSearchStateCopyWith<GlobalSearchState> get copyWith => _$GlobalSearchStateCopyWithImpl<GlobalSearchState>(this as GlobalSearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlobalSearchState&&const DeepCollectionEquality().equals(other.results, results)&&const DeepCollectionEquality().equals(other.recentSearches, recentSearches)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasReachedMax, hasReachedMax) || other.hasReachedMax == hasReachedMax)&&(identical(other.lastQuery, lastQuery) || other.lastQuery == lastQuery));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(results),const DeepCollectionEquality().hash(recentSearches),status,errorMessage,currentPage,hasReachedMax,lastQuery);

@override
String toString() {
  return 'GlobalSearchState(results: $results, recentSearches: $recentSearches, status: $status, errorMessage: $errorMessage, currentPage: $currentPage, hasReachedMax: $hasReachedMax, lastQuery: $lastQuery)';
}


}

/// @nodoc
abstract mixin class $GlobalSearchStateCopyWith<$Res>  {
  factory $GlobalSearchStateCopyWith(GlobalSearchState value, $Res Function(GlobalSearchState) _then) = _$GlobalSearchStateCopyWithImpl;
@useResult
$Res call({
 List<PlaceEntity> results, List<RecentSearchEntity> recentSearches, GlobalSearchStatus status, String? errorMessage, int currentPage, bool hasReachedMax, String? lastQuery
});




}
/// @nodoc
class _$GlobalSearchStateCopyWithImpl<$Res>
    implements $GlobalSearchStateCopyWith<$Res> {
  _$GlobalSearchStateCopyWithImpl(this._self, this._then);

  final GlobalSearchState _self;
  final $Res Function(GlobalSearchState) _then;

/// Create a copy of GlobalSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? results = null,Object? recentSearches = null,Object? status = null,Object? errorMessage = freezed,Object? currentPage = null,Object? hasReachedMax = null,Object? lastQuery = freezed,}) {
  return _then(_self.copyWith(
results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<PlaceEntity>,recentSearches: null == recentSearches ? _self.recentSearches : recentSearches // ignore: cast_nullable_to_non_nullable
as List<RecentSearchEntity>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GlobalSearchStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasReachedMax: null == hasReachedMax ? _self.hasReachedMax : hasReachedMax // ignore: cast_nullable_to_non_nullable
as bool,lastQuery: freezed == lastQuery ? _self.lastQuery : lastQuery // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GlobalSearchState].
extension GlobalSearchStatePatterns on GlobalSearchState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GlobalSearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GlobalSearchState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GlobalSearchState value)  $default,){
final _that = this;
switch (_that) {
case _GlobalSearchState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GlobalSearchState value)?  $default,){
final _that = this;
switch (_that) {
case _GlobalSearchState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PlaceEntity> results,  List<RecentSearchEntity> recentSearches,  GlobalSearchStatus status,  String? errorMessage,  int currentPage,  bool hasReachedMax,  String? lastQuery)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GlobalSearchState() when $default != null:
return $default(_that.results,_that.recentSearches,_that.status,_that.errorMessage,_that.currentPage,_that.hasReachedMax,_that.lastQuery);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PlaceEntity> results,  List<RecentSearchEntity> recentSearches,  GlobalSearchStatus status,  String? errorMessage,  int currentPage,  bool hasReachedMax,  String? lastQuery)  $default,) {final _that = this;
switch (_that) {
case _GlobalSearchState():
return $default(_that.results,_that.recentSearches,_that.status,_that.errorMessage,_that.currentPage,_that.hasReachedMax,_that.lastQuery);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PlaceEntity> results,  List<RecentSearchEntity> recentSearches,  GlobalSearchStatus status,  String? errorMessage,  int currentPage,  bool hasReachedMax,  String? lastQuery)?  $default,) {final _that = this;
switch (_that) {
case _GlobalSearchState() when $default != null:
return $default(_that.results,_that.recentSearches,_that.status,_that.errorMessage,_that.currentPage,_that.hasReachedMax,_that.lastQuery);case _:
  return null;

}
}

}

/// @nodoc


class _GlobalSearchState extends GlobalSearchState {
  const _GlobalSearchState({final  List<PlaceEntity> results = const [], final  List<RecentSearchEntity> recentSearches = const [], this.status = GlobalSearchStatus.initial, this.errorMessage, this.currentPage = 1, this.hasReachedMax = true, this.lastQuery}): _results = results,_recentSearches = recentSearches,super._();
  

 final  List<PlaceEntity> _results;
@override@JsonKey() List<PlaceEntity> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

 final  List<RecentSearchEntity> _recentSearches;
@override@JsonKey() List<RecentSearchEntity> get recentSearches {
  if (_recentSearches is EqualUnmodifiableListView) return _recentSearches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentSearches);
}

@override@JsonKey() final  GlobalSearchStatus status;
@override final  String? errorMessage;
@override@JsonKey() final  int currentPage;
@override@JsonKey() final  bool hasReachedMax;
@override final  String? lastQuery;

/// Create a copy of GlobalSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GlobalSearchStateCopyWith<_GlobalSearchState> get copyWith => __$GlobalSearchStateCopyWithImpl<_GlobalSearchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GlobalSearchState&&const DeepCollectionEquality().equals(other._results, _results)&&const DeepCollectionEquality().equals(other._recentSearches, _recentSearches)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasReachedMax, hasReachedMax) || other.hasReachedMax == hasReachedMax)&&(identical(other.lastQuery, lastQuery) || other.lastQuery == lastQuery));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_results),const DeepCollectionEquality().hash(_recentSearches),status,errorMessage,currentPage,hasReachedMax,lastQuery);

@override
String toString() {
  return 'GlobalSearchState(results: $results, recentSearches: $recentSearches, status: $status, errorMessage: $errorMessage, currentPage: $currentPage, hasReachedMax: $hasReachedMax, lastQuery: $lastQuery)';
}


}

/// @nodoc
abstract mixin class _$GlobalSearchStateCopyWith<$Res> implements $GlobalSearchStateCopyWith<$Res> {
  factory _$GlobalSearchStateCopyWith(_GlobalSearchState value, $Res Function(_GlobalSearchState) _then) = __$GlobalSearchStateCopyWithImpl;
@override @useResult
$Res call({
 List<PlaceEntity> results, List<RecentSearchEntity> recentSearches, GlobalSearchStatus status, String? errorMessage, int currentPage, bool hasReachedMax, String? lastQuery
});




}
/// @nodoc
class __$GlobalSearchStateCopyWithImpl<$Res>
    implements _$GlobalSearchStateCopyWith<$Res> {
  __$GlobalSearchStateCopyWithImpl(this._self, this._then);

  final _GlobalSearchState _self;
  final $Res Function(_GlobalSearchState) _then;

/// Create a copy of GlobalSearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? results = null,Object? recentSearches = null,Object? status = null,Object? errorMessage = freezed,Object? currentPage = null,Object? hasReachedMax = null,Object? lastQuery = freezed,}) {
  return _then(_GlobalSearchState(
results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<PlaceEntity>,recentSearches: null == recentSearches ? _self._recentSearches : recentSearches // ignore: cast_nullable_to_non_nullable
as List<RecentSearchEntity>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GlobalSearchStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasReachedMax: null == hasReachedMax ? _self.hasReachedMax : hasReachedMax // ignore: cast_nullable_to_non_nullable
as bool,lastQuery: freezed == lastQuery ? _self.lastQuery : lastQuery // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
