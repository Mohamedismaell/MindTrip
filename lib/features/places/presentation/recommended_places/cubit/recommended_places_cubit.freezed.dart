// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recommended_places_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecommendedPlacesState {

 RecommendedPlacesStatus get recommendedPlacesStatus; List<PlaceEntity> get places; String get error; int get currentPage; bool get hasMore; bool get isMoreLoading; int? get seed;
/// Create a copy of RecommendedPlacesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecommendedPlacesStateCopyWith<RecommendedPlacesState> get copyWith => _$RecommendedPlacesStateCopyWithImpl<RecommendedPlacesState>(this as RecommendedPlacesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecommendedPlacesState&&(identical(other.recommendedPlacesStatus, recommendedPlacesStatus) || other.recommendedPlacesStatus == recommendedPlacesStatus)&&const DeepCollectionEquality().equals(other.places, places)&&(identical(other.error, error) || other.error == error)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isMoreLoading, isMoreLoading) || other.isMoreLoading == isMoreLoading)&&(identical(other.seed, seed) || other.seed == seed));
}


@override
int get hashCode => Object.hash(runtimeType,recommendedPlacesStatus,const DeepCollectionEquality().hash(places),error,currentPage,hasMore,isMoreLoading,seed);

@override
String toString() {
  return 'RecommendedPlacesState(recommendedPlacesStatus: $recommendedPlacesStatus, places: $places, error: $error, currentPage: $currentPage, hasMore: $hasMore, isMoreLoading: $isMoreLoading, seed: $seed)';
}


}

/// @nodoc
abstract mixin class $RecommendedPlacesStateCopyWith<$Res>  {
  factory $RecommendedPlacesStateCopyWith(RecommendedPlacesState value, $Res Function(RecommendedPlacesState) _then) = _$RecommendedPlacesStateCopyWithImpl;
@useResult
$Res call({
 RecommendedPlacesStatus recommendedPlacesStatus, List<PlaceEntity> places, String error, int currentPage, bool hasMore, bool isMoreLoading, int? seed
});




}
/// @nodoc
class _$RecommendedPlacesStateCopyWithImpl<$Res>
    implements $RecommendedPlacesStateCopyWith<$Res> {
  _$RecommendedPlacesStateCopyWithImpl(this._self, this._then);

  final RecommendedPlacesState _self;
  final $Res Function(RecommendedPlacesState) _then;

/// Create a copy of RecommendedPlacesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? recommendedPlacesStatus = null,Object? places = null,Object? error = null,Object? currentPage = null,Object? hasMore = null,Object? isMoreLoading = null,Object? seed = freezed,}) {
  return _then(_self.copyWith(
recommendedPlacesStatus: null == recommendedPlacesStatus ? _self.recommendedPlacesStatus : recommendedPlacesStatus // ignore: cast_nullable_to_non_nullable
as RecommendedPlacesStatus,places: null == places ? _self.places : places // ignore: cast_nullable_to_non_nullable
as List<PlaceEntity>,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isMoreLoading: null == isMoreLoading ? _self.isMoreLoading : isMoreLoading // ignore: cast_nullable_to_non_nullable
as bool,seed: freezed == seed ? _self.seed : seed // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecommendedPlacesState].
extension RecommendedPlacesStatePatterns on RecommendedPlacesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecommendedPlacesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecommendedPlacesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecommendedPlacesState value)  $default,){
final _that = this;
switch (_that) {
case _RecommendedPlacesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecommendedPlacesState value)?  $default,){
final _that = this;
switch (_that) {
case _RecommendedPlacesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RecommendedPlacesStatus recommendedPlacesStatus,  List<PlaceEntity> places,  String error,  int currentPage,  bool hasMore,  bool isMoreLoading,  int? seed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecommendedPlacesState() when $default != null:
return $default(_that.recommendedPlacesStatus,_that.places,_that.error,_that.currentPage,_that.hasMore,_that.isMoreLoading,_that.seed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RecommendedPlacesStatus recommendedPlacesStatus,  List<PlaceEntity> places,  String error,  int currentPage,  bool hasMore,  bool isMoreLoading,  int? seed)  $default,) {final _that = this;
switch (_that) {
case _RecommendedPlacesState():
return $default(_that.recommendedPlacesStatus,_that.places,_that.error,_that.currentPage,_that.hasMore,_that.isMoreLoading,_that.seed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RecommendedPlacesStatus recommendedPlacesStatus,  List<PlaceEntity> places,  String error,  int currentPage,  bool hasMore,  bool isMoreLoading,  int? seed)?  $default,) {final _that = this;
switch (_that) {
case _RecommendedPlacesState() when $default != null:
return $default(_that.recommendedPlacesStatus,_that.places,_that.error,_that.currentPage,_that.hasMore,_that.isMoreLoading,_that.seed);case _:
  return null;

}
}

}

/// @nodoc


class _RecommendedPlacesState implements RecommendedPlacesState {
  const _RecommendedPlacesState({this.recommendedPlacesStatus = RecommendedPlacesStatus.initial, final  List<PlaceEntity> places = const [], this.error = '', this.currentPage = 1, this.hasMore = true, this.isMoreLoading = false, this.seed = null}): _places = places;
  

@override@JsonKey() final  RecommendedPlacesStatus recommendedPlacesStatus;
 final  List<PlaceEntity> _places;
@override@JsonKey() List<PlaceEntity> get places {
  if (_places is EqualUnmodifiableListView) return _places;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_places);
}

@override@JsonKey() final  String error;
@override@JsonKey() final  int currentPage;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  bool isMoreLoading;
@override@JsonKey() final  int? seed;

/// Create a copy of RecommendedPlacesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecommendedPlacesStateCopyWith<_RecommendedPlacesState> get copyWith => __$RecommendedPlacesStateCopyWithImpl<_RecommendedPlacesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecommendedPlacesState&&(identical(other.recommendedPlacesStatus, recommendedPlacesStatus) || other.recommendedPlacesStatus == recommendedPlacesStatus)&&const DeepCollectionEquality().equals(other._places, _places)&&(identical(other.error, error) || other.error == error)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isMoreLoading, isMoreLoading) || other.isMoreLoading == isMoreLoading)&&(identical(other.seed, seed) || other.seed == seed));
}


@override
int get hashCode => Object.hash(runtimeType,recommendedPlacesStatus,const DeepCollectionEquality().hash(_places),error,currentPage,hasMore,isMoreLoading,seed);

@override
String toString() {
  return 'RecommendedPlacesState(recommendedPlacesStatus: $recommendedPlacesStatus, places: $places, error: $error, currentPage: $currentPage, hasMore: $hasMore, isMoreLoading: $isMoreLoading, seed: $seed)';
}


}

/// @nodoc
abstract mixin class _$RecommendedPlacesStateCopyWith<$Res> implements $RecommendedPlacesStateCopyWith<$Res> {
  factory _$RecommendedPlacesStateCopyWith(_RecommendedPlacesState value, $Res Function(_RecommendedPlacesState) _then) = __$RecommendedPlacesStateCopyWithImpl;
@override @useResult
$Res call({
 RecommendedPlacesStatus recommendedPlacesStatus, List<PlaceEntity> places, String error, int currentPage, bool hasMore, bool isMoreLoading, int? seed
});




}
/// @nodoc
class __$RecommendedPlacesStateCopyWithImpl<$Res>
    implements _$RecommendedPlacesStateCopyWith<$Res> {
  __$RecommendedPlacesStateCopyWithImpl(this._self, this._then);

  final _RecommendedPlacesState _self;
  final $Res Function(_RecommendedPlacesState) _then;

/// Create a copy of RecommendedPlacesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? recommendedPlacesStatus = null,Object? places = null,Object? error = null,Object? currentPage = null,Object? hasMore = null,Object? isMoreLoading = null,Object? seed = freezed,}) {
  return _then(_RecommendedPlacesState(
recommendedPlacesStatus: null == recommendedPlacesStatus ? _self.recommendedPlacesStatus : recommendedPlacesStatus // ignore: cast_nullable_to_non_nullable
as RecommendedPlacesStatus,places: null == places ? _self._places : places // ignore: cast_nullable_to_non_nullable
as List<PlaceEntity>,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isMoreLoading: null == isMoreLoading ? _self.isMoreLoading : isMoreLoading // ignore: cast_nullable_to_non_nullable
as bool,seed: freezed == seed ? _self.seed : seed // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
