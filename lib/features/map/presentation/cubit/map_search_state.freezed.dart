// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MapSearchState {

 List<PlacePrediction> get autocompletePredictions; bool get isSearchLoading; String? get searchError; GooglePlaceEntity? get resolvedSearchPlace; bool get clearResolvedSearchPlace; bool get clearSearchError; List<GooglePlaceEntity> get nearbyPlaces;
/// Create a copy of MapSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapSearchStateCopyWith<MapSearchState> get copyWith => _$MapSearchStateCopyWithImpl<MapSearchState>(this as MapSearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapSearchState&&const DeepCollectionEquality().equals(other.autocompletePredictions, autocompletePredictions)&&(identical(other.isSearchLoading, isSearchLoading) || other.isSearchLoading == isSearchLoading)&&(identical(other.searchError, searchError) || other.searchError == searchError)&&(identical(other.resolvedSearchPlace, resolvedSearchPlace) || other.resolvedSearchPlace == resolvedSearchPlace)&&(identical(other.clearResolvedSearchPlace, clearResolvedSearchPlace) || other.clearResolvedSearchPlace == clearResolvedSearchPlace)&&(identical(other.clearSearchError, clearSearchError) || other.clearSearchError == clearSearchError)&&const DeepCollectionEquality().equals(other.nearbyPlaces, nearbyPlaces));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(autocompletePredictions),isSearchLoading,searchError,resolvedSearchPlace,clearResolvedSearchPlace,clearSearchError,const DeepCollectionEquality().hash(nearbyPlaces));

@override
String toString() {
  return 'MapSearchState(autocompletePredictions: $autocompletePredictions, isSearchLoading: $isSearchLoading, searchError: $searchError, resolvedSearchPlace: $resolvedSearchPlace, clearResolvedSearchPlace: $clearResolvedSearchPlace, clearSearchError: $clearSearchError, nearbyPlaces: $nearbyPlaces)';
}


}

/// @nodoc
abstract mixin class $MapSearchStateCopyWith<$Res>  {
  factory $MapSearchStateCopyWith(MapSearchState value, $Res Function(MapSearchState) _then) = _$MapSearchStateCopyWithImpl;
@useResult
$Res call({
 List<PlacePrediction> autocompletePredictions, bool isSearchLoading, String? searchError, GooglePlaceEntity? resolvedSearchPlace, bool clearResolvedSearchPlace, bool clearSearchError, List<GooglePlaceEntity> nearbyPlaces
});




}
/// @nodoc
class _$MapSearchStateCopyWithImpl<$Res>
    implements $MapSearchStateCopyWith<$Res> {
  _$MapSearchStateCopyWithImpl(this._self, this._then);

  final MapSearchState _self;
  final $Res Function(MapSearchState) _then;

/// Create a copy of MapSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? autocompletePredictions = null,Object? isSearchLoading = null,Object? searchError = freezed,Object? resolvedSearchPlace = freezed,Object? clearResolvedSearchPlace = null,Object? clearSearchError = null,Object? nearbyPlaces = null,}) {
  return _then(_self.copyWith(
autocompletePredictions: null == autocompletePredictions ? _self.autocompletePredictions : autocompletePredictions // ignore: cast_nullable_to_non_nullable
as List<PlacePrediction>,isSearchLoading: null == isSearchLoading ? _self.isSearchLoading : isSearchLoading // ignore: cast_nullable_to_non_nullable
as bool,searchError: freezed == searchError ? _self.searchError : searchError // ignore: cast_nullable_to_non_nullable
as String?,resolvedSearchPlace: freezed == resolvedSearchPlace ? _self.resolvedSearchPlace : resolvedSearchPlace // ignore: cast_nullable_to_non_nullable
as GooglePlaceEntity?,clearResolvedSearchPlace: null == clearResolvedSearchPlace ? _self.clearResolvedSearchPlace : clearResolvedSearchPlace // ignore: cast_nullable_to_non_nullable
as bool,clearSearchError: null == clearSearchError ? _self.clearSearchError : clearSearchError // ignore: cast_nullable_to_non_nullable
as bool,nearbyPlaces: null == nearbyPlaces ? _self.nearbyPlaces : nearbyPlaces // ignore: cast_nullable_to_non_nullable
as List<GooglePlaceEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [MapSearchState].
extension MapSearchStatePatterns on MapSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapSearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapSearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapSearchState value)  $default,){
final _that = this;
switch (_that) {
case _MapSearchState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapSearchState value)?  $default,){
final _that = this;
switch (_that) {
case _MapSearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PlacePrediction> autocompletePredictions,  bool isSearchLoading,  String? searchError,  GooglePlaceEntity? resolvedSearchPlace,  bool clearResolvedSearchPlace,  bool clearSearchError,  List<GooglePlaceEntity> nearbyPlaces)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapSearchState() when $default != null:
return $default(_that.autocompletePredictions,_that.isSearchLoading,_that.searchError,_that.resolvedSearchPlace,_that.clearResolvedSearchPlace,_that.clearSearchError,_that.nearbyPlaces);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PlacePrediction> autocompletePredictions,  bool isSearchLoading,  String? searchError,  GooglePlaceEntity? resolvedSearchPlace,  bool clearResolvedSearchPlace,  bool clearSearchError,  List<GooglePlaceEntity> nearbyPlaces)  $default,) {final _that = this;
switch (_that) {
case _MapSearchState():
return $default(_that.autocompletePredictions,_that.isSearchLoading,_that.searchError,_that.resolvedSearchPlace,_that.clearResolvedSearchPlace,_that.clearSearchError,_that.nearbyPlaces);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PlacePrediction> autocompletePredictions,  bool isSearchLoading,  String? searchError,  GooglePlaceEntity? resolvedSearchPlace,  bool clearResolvedSearchPlace,  bool clearSearchError,  List<GooglePlaceEntity> nearbyPlaces)?  $default,) {final _that = this;
switch (_that) {
case _MapSearchState() when $default != null:
return $default(_that.autocompletePredictions,_that.isSearchLoading,_that.searchError,_that.resolvedSearchPlace,_that.clearResolvedSearchPlace,_that.clearSearchError,_that.nearbyPlaces);case _:
  return null;

}
}

}

/// @nodoc


class _MapSearchState extends MapSearchState {
  const _MapSearchState({final  List<PlacePrediction> autocompletePredictions = const [], this.isSearchLoading = false, this.searchError, this.resolvedSearchPlace, this.clearResolvedSearchPlace = false, this.clearSearchError = false, final  List<GooglePlaceEntity> nearbyPlaces = const []}): _autocompletePredictions = autocompletePredictions,_nearbyPlaces = nearbyPlaces,super._();
  

 final  List<PlacePrediction> _autocompletePredictions;
@override@JsonKey() List<PlacePrediction> get autocompletePredictions {
  if (_autocompletePredictions is EqualUnmodifiableListView) return _autocompletePredictions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_autocompletePredictions);
}

@override@JsonKey() final  bool isSearchLoading;
@override final  String? searchError;
@override final  GooglePlaceEntity? resolvedSearchPlace;
@override@JsonKey() final  bool clearResolvedSearchPlace;
@override@JsonKey() final  bool clearSearchError;
 final  List<GooglePlaceEntity> _nearbyPlaces;
@override@JsonKey() List<GooglePlaceEntity> get nearbyPlaces {
  if (_nearbyPlaces is EqualUnmodifiableListView) return _nearbyPlaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nearbyPlaces);
}


/// Create a copy of MapSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapSearchStateCopyWith<_MapSearchState> get copyWith => __$MapSearchStateCopyWithImpl<_MapSearchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapSearchState&&const DeepCollectionEquality().equals(other._autocompletePredictions, _autocompletePredictions)&&(identical(other.isSearchLoading, isSearchLoading) || other.isSearchLoading == isSearchLoading)&&(identical(other.searchError, searchError) || other.searchError == searchError)&&(identical(other.resolvedSearchPlace, resolvedSearchPlace) || other.resolvedSearchPlace == resolvedSearchPlace)&&(identical(other.clearResolvedSearchPlace, clearResolvedSearchPlace) || other.clearResolvedSearchPlace == clearResolvedSearchPlace)&&(identical(other.clearSearchError, clearSearchError) || other.clearSearchError == clearSearchError)&&const DeepCollectionEquality().equals(other._nearbyPlaces, _nearbyPlaces));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_autocompletePredictions),isSearchLoading,searchError,resolvedSearchPlace,clearResolvedSearchPlace,clearSearchError,const DeepCollectionEquality().hash(_nearbyPlaces));

@override
String toString() {
  return 'MapSearchState(autocompletePredictions: $autocompletePredictions, isSearchLoading: $isSearchLoading, searchError: $searchError, resolvedSearchPlace: $resolvedSearchPlace, clearResolvedSearchPlace: $clearResolvedSearchPlace, clearSearchError: $clearSearchError, nearbyPlaces: $nearbyPlaces)';
}


}

/// @nodoc
abstract mixin class _$MapSearchStateCopyWith<$Res> implements $MapSearchStateCopyWith<$Res> {
  factory _$MapSearchStateCopyWith(_MapSearchState value, $Res Function(_MapSearchState) _then) = __$MapSearchStateCopyWithImpl;
@override @useResult
$Res call({
 List<PlacePrediction> autocompletePredictions, bool isSearchLoading, String? searchError, GooglePlaceEntity? resolvedSearchPlace, bool clearResolvedSearchPlace, bool clearSearchError, List<GooglePlaceEntity> nearbyPlaces
});




}
/// @nodoc
class __$MapSearchStateCopyWithImpl<$Res>
    implements _$MapSearchStateCopyWith<$Res> {
  __$MapSearchStateCopyWithImpl(this._self, this._then);

  final _MapSearchState _self;
  final $Res Function(_MapSearchState) _then;

/// Create a copy of MapSearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? autocompletePredictions = null,Object? isSearchLoading = null,Object? searchError = freezed,Object? resolvedSearchPlace = freezed,Object? clearResolvedSearchPlace = null,Object? clearSearchError = null,Object? nearbyPlaces = null,}) {
  return _then(_MapSearchState(
autocompletePredictions: null == autocompletePredictions ? _self._autocompletePredictions : autocompletePredictions // ignore: cast_nullable_to_non_nullable
as List<PlacePrediction>,isSearchLoading: null == isSearchLoading ? _self.isSearchLoading : isSearchLoading // ignore: cast_nullable_to_non_nullable
as bool,searchError: freezed == searchError ? _self.searchError : searchError // ignore: cast_nullable_to_non_nullable
as String?,resolvedSearchPlace: freezed == resolvedSearchPlace ? _self.resolvedSearchPlace : resolvedSearchPlace // ignore: cast_nullable_to_non_nullable
as GooglePlaceEntity?,clearResolvedSearchPlace: null == clearResolvedSearchPlace ? _self.clearResolvedSearchPlace : clearResolvedSearchPlace // ignore: cast_nullable_to_non_nullable
as bool,clearSearchError: null == clearSearchError ? _self.clearSearchError : clearSearchError // ignore: cast_nullable_to_non_nullable
as bool,nearbyPlaces: null == nearbyPlaces ? _self._nearbyPlaces : nearbyPlaces // ignore: cast_nullable_to_non_nullable
as List<GooglePlaceEntity>,
  ));
}


}

// dart format on
