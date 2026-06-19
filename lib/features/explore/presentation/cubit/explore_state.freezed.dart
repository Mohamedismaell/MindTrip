// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explore_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExploreState {

 ExploreDataStatus get trendingPlacesStatus; PaginationState<PlaceEntity> get trendingPlaces; String get trendingPlacesError; ExploreDataStatus get filteredPlacesStatus; PaginationState<PlaceEntity> get filteredPlaces; String get filteredPlacesError; Set<PlaceCategory> get selectedCategories; GetPlacesRequestModel? get advancedFilters;
/// Create a copy of ExploreState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreStateCopyWith<ExploreState> get copyWith => _$ExploreStateCopyWithImpl<ExploreState>(this as ExploreState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreState&&(identical(other.trendingPlacesStatus, trendingPlacesStatus) || other.trendingPlacesStatus == trendingPlacesStatus)&&(identical(other.trendingPlaces, trendingPlaces) || other.trendingPlaces == trendingPlaces)&&(identical(other.trendingPlacesError, trendingPlacesError) || other.trendingPlacesError == trendingPlacesError)&&(identical(other.filteredPlacesStatus, filteredPlacesStatus) || other.filteredPlacesStatus == filteredPlacesStatus)&&(identical(other.filteredPlaces, filteredPlaces) || other.filteredPlaces == filteredPlaces)&&(identical(other.filteredPlacesError, filteredPlacesError) || other.filteredPlacesError == filteredPlacesError)&&const DeepCollectionEquality().equals(other.selectedCategories, selectedCategories)&&(identical(other.advancedFilters, advancedFilters) || other.advancedFilters == advancedFilters));
}


@override
int get hashCode => Object.hash(runtimeType,trendingPlacesStatus,trendingPlaces,trendingPlacesError,filteredPlacesStatus,filteredPlaces,filteredPlacesError,const DeepCollectionEquality().hash(selectedCategories),advancedFilters);

@override
String toString() {
  return 'ExploreState(trendingPlacesStatus: $trendingPlacesStatus, trendingPlaces: $trendingPlaces, trendingPlacesError: $trendingPlacesError, filteredPlacesStatus: $filteredPlacesStatus, filteredPlaces: $filteredPlaces, filteredPlacesError: $filteredPlacesError, selectedCategories: $selectedCategories, advancedFilters: $advancedFilters)';
}


}

/// @nodoc
abstract mixin class $ExploreStateCopyWith<$Res>  {
  factory $ExploreStateCopyWith(ExploreState value, $Res Function(ExploreState) _then) = _$ExploreStateCopyWithImpl;
@useResult
$Res call({
 ExploreDataStatus trendingPlacesStatus, PaginationState<PlaceEntity> trendingPlaces, String trendingPlacesError, ExploreDataStatus filteredPlacesStatus, PaginationState<PlaceEntity> filteredPlaces, String filteredPlacesError, Set<PlaceCategory> selectedCategories, GetPlacesRequestModel? advancedFilters
});


$PaginationStateCopyWith<PlaceEntity, $Res> get trendingPlaces;$PaginationStateCopyWith<PlaceEntity, $Res> get filteredPlaces;

}
/// @nodoc
class _$ExploreStateCopyWithImpl<$Res>
    implements $ExploreStateCopyWith<$Res> {
  _$ExploreStateCopyWithImpl(this._self, this._then);

  final ExploreState _self;
  final $Res Function(ExploreState) _then;

/// Create a copy of ExploreState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? trendingPlacesStatus = null,Object? trendingPlaces = null,Object? trendingPlacesError = null,Object? filteredPlacesStatus = null,Object? filteredPlaces = null,Object? filteredPlacesError = null,Object? selectedCategories = null,Object? advancedFilters = freezed,}) {
  return _then(_self.copyWith(
trendingPlacesStatus: null == trendingPlacesStatus ? _self.trendingPlacesStatus : trendingPlacesStatus // ignore: cast_nullable_to_non_nullable
as ExploreDataStatus,trendingPlaces: null == trendingPlaces ? _self.trendingPlaces : trendingPlaces // ignore: cast_nullable_to_non_nullable
as PaginationState<PlaceEntity>,trendingPlacesError: null == trendingPlacesError ? _self.trendingPlacesError : trendingPlacesError // ignore: cast_nullable_to_non_nullable
as String,filteredPlacesStatus: null == filteredPlacesStatus ? _self.filteredPlacesStatus : filteredPlacesStatus // ignore: cast_nullable_to_non_nullable
as ExploreDataStatus,filteredPlaces: null == filteredPlaces ? _self.filteredPlaces : filteredPlaces // ignore: cast_nullable_to_non_nullable
as PaginationState<PlaceEntity>,filteredPlacesError: null == filteredPlacesError ? _self.filteredPlacesError : filteredPlacesError // ignore: cast_nullable_to_non_nullable
as String,selectedCategories: null == selectedCategories ? _self.selectedCategories : selectedCategories // ignore: cast_nullable_to_non_nullable
as Set<PlaceCategory>,advancedFilters: freezed == advancedFilters ? _self.advancedFilters : advancedFilters // ignore: cast_nullable_to_non_nullable
as GetPlacesRequestModel?,
  ));
}
/// Create a copy of ExploreState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationStateCopyWith<PlaceEntity, $Res> get trendingPlaces {
  
  return $PaginationStateCopyWith<PlaceEntity, $Res>(_self.trendingPlaces, (value) {
    return _then(_self.copyWith(trendingPlaces: value));
  });
}/// Create a copy of ExploreState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationStateCopyWith<PlaceEntity, $Res> get filteredPlaces {
  
  return $PaginationStateCopyWith<PlaceEntity, $Res>(_self.filteredPlaces, (value) {
    return _then(_self.copyWith(filteredPlaces: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExploreState].
extension ExploreStatePatterns on ExploreState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExploreState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExploreState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExploreState value)  $default,){
final _that = this;
switch (_that) {
case _ExploreState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExploreState value)?  $default,){
final _that = this;
switch (_that) {
case _ExploreState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ExploreDataStatus trendingPlacesStatus,  PaginationState<PlaceEntity> trendingPlaces,  String trendingPlacesError,  ExploreDataStatus filteredPlacesStatus,  PaginationState<PlaceEntity> filteredPlaces,  String filteredPlacesError,  Set<PlaceCategory> selectedCategories,  GetPlacesRequestModel? advancedFilters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExploreState() when $default != null:
return $default(_that.trendingPlacesStatus,_that.trendingPlaces,_that.trendingPlacesError,_that.filteredPlacesStatus,_that.filteredPlaces,_that.filteredPlacesError,_that.selectedCategories,_that.advancedFilters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ExploreDataStatus trendingPlacesStatus,  PaginationState<PlaceEntity> trendingPlaces,  String trendingPlacesError,  ExploreDataStatus filteredPlacesStatus,  PaginationState<PlaceEntity> filteredPlaces,  String filteredPlacesError,  Set<PlaceCategory> selectedCategories,  GetPlacesRequestModel? advancedFilters)  $default,) {final _that = this;
switch (_that) {
case _ExploreState():
return $default(_that.trendingPlacesStatus,_that.trendingPlaces,_that.trendingPlacesError,_that.filteredPlacesStatus,_that.filteredPlaces,_that.filteredPlacesError,_that.selectedCategories,_that.advancedFilters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ExploreDataStatus trendingPlacesStatus,  PaginationState<PlaceEntity> trendingPlaces,  String trendingPlacesError,  ExploreDataStatus filteredPlacesStatus,  PaginationState<PlaceEntity> filteredPlaces,  String filteredPlacesError,  Set<PlaceCategory> selectedCategories,  GetPlacesRequestModel? advancedFilters)?  $default,) {final _that = this;
switch (_that) {
case _ExploreState() when $default != null:
return $default(_that.trendingPlacesStatus,_that.trendingPlaces,_that.trendingPlacesError,_that.filteredPlacesStatus,_that.filteredPlaces,_that.filteredPlacesError,_that.selectedCategories,_that.advancedFilters);case _:
  return null;

}
}

}

/// @nodoc


class _ExploreState extends ExploreState {
  const _ExploreState({this.trendingPlacesStatus = ExploreDataStatus.initial, this.trendingPlaces = const PaginationState<PlaceEntity>(), this.trendingPlacesError = '', this.filteredPlacesStatus = ExploreDataStatus.initial, this.filteredPlaces = const PaginationState<PlaceEntity>(), this.filteredPlacesError = '', final  Set<PlaceCategory> selectedCategories = const {PlaceCategory.all}, this.advancedFilters}): _selectedCategories = selectedCategories,super._();
  

@override@JsonKey() final  ExploreDataStatus trendingPlacesStatus;
@override@JsonKey() final  PaginationState<PlaceEntity> trendingPlaces;
@override@JsonKey() final  String trendingPlacesError;
@override@JsonKey() final  ExploreDataStatus filteredPlacesStatus;
@override@JsonKey() final  PaginationState<PlaceEntity> filteredPlaces;
@override@JsonKey() final  String filteredPlacesError;
 final  Set<PlaceCategory> _selectedCategories;
@override@JsonKey() Set<PlaceCategory> get selectedCategories {
  if (_selectedCategories is EqualUnmodifiableSetView) return _selectedCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedCategories);
}

@override final  GetPlacesRequestModel? advancedFilters;

/// Create a copy of ExploreState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExploreStateCopyWith<_ExploreState> get copyWith => __$ExploreStateCopyWithImpl<_ExploreState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExploreState&&(identical(other.trendingPlacesStatus, trendingPlacesStatus) || other.trendingPlacesStatus == trendingPlacesStatus)&&(identical(other.trendingPlaces, trendingPlaces) || other.trendingPlaces == trendingPlaces)&&(identical(other.trendingPlacesError, trendingPlacesError) || other.trendingPlacesError == trendingPlacesError)&&(identical(other.filteredPlacesStatus, filteredPlacesStatus) || other.filteredPlacesStatus == filteredPlacesStatus)&&(identical(other.filteredPlaces, filteredPlaces) || other.filteredPlaces == filteredPlaces)&&(identical(other.filteredPlacesError, filteredPlacesError) || other.filteredPlacesError == filteredPlacesError)&&const DeepCollectionEquality().equals(other._selectedCategories, _selectedCategories)&&(identical(other.advancedFilters, advancedFilters) || other.advancedFilters == advancedFilters));
}


@override
int get hashCode => Object.hash(runtimeType,trendingPlacesStatus,trendingPlaces,trendingPlacesError,filteredPlacesStatus,filteredPlaces,filteredPlacesError,const DeepCollectionEquality().hash(_selectedCategories),advancedFilters);

@override
String toString() {
  return 'ExploreState(trendingPlacesStatus: $trendingPlacesStatus, trendingPlaces: $trendingPlaces, trendingPlacesError: $trendingPlacesError, filteredPlacesStatus: $filteredPlacesStatus, filteredPlaces: $filteredPlaces, filteredPlacesError: $filteredPlacesError, selectedCategories: $selectedCategories, advancedFilters: $advancedFilters)';
}


}

/// @nodoc
abstract mixin class _$ExploreStateCopyWith<$Res> implements $ExploreStateCopyWith<$Res> {
  factory _$ExploreStateCopyWith(_ExploreState value, $Res Function(_ExploreState) _then) = __$ExploreStateCopyWithImpl;
@override @useResult
$Res call({
 ExploreDataStatus trendingPlacesStatus, PaginationState<PlaceEntity> trendingPlaces, String trendingPlacesError, ExploreDataStatus filteredPlacesStatus, PaginationState<PlaceEntity> filteredPlaces, String filteredPlacesError, Set<PlaceCategory> selectedCategories, GetPlacesRequestModel? advancedFilters
});


@override $PaginationStateCopyWith<PlaceEntity, $Res> get trendingPlaces;@override $PaginationStateCopyWith<PlaceEntity, $Res> get filteredPlaces;

}
/// @nodoc
class __$ExploreStateCopyWithImpl<$Res>
    implements _$ExploreStateCopyWith<$Res> {
  __$ExploreStateCopyWithImpl(this._self, this._then);

  final _ExploreState _self;
  final $Res Function(_ExploreState) _then;

/// Create a copy of ExploreState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? trendingPlacesStatus = null,Object? trendingPlaces = null,Object? trendingPlacesError = null,Object? filteredPlacesStatus = null,Object? filteredPlaces = null,Object? filteredPlacesError = null,Object? selectedCategories = null,Object? advancedFilters = freezed,}) {
  return _then(_ExploreState(
trendingPlacesStatus: null == trendingPlacesStatus ? _self.trendingPlacesStatus : trendingPlacesStatus // ignore: cast_nullable_to_non_nullable
as ExploreDataStatus,trendingPlaces: null == trendingPlaces ? _self.trendingPlaces : trendingPlaces // ignore: cast_nullable_to_non_nullable
as PaginationState<PlaceEntity>,trendingPlacesError: null == trendingPlacesError ? _self.trendingPlacesError : trendingPlacesError // ignore: cast_nullable_to_non_nullable
as String,filteredPlacesStatus: null == filteredPlacesStatus ? _self.filteredPlacesStatus : filteredPlacesStatus // ignore: cast_nullable_to_non_nullable
as ExploreDataStatus,filteredPlaces: null == filteredPlaces ? _self.filteredPlaces : filteredPlaces // ignore: cast_nullable_to_non_nullable
as PaginationState<PlaceEntity>,filteredPlacesError: null == filteredPlacesError ? _self.filteredPlacesError : filteredPlacesError // ignore: cast_nullable_to_non_nullable
as String,selectedCategories: null == selectedCategories ? _self._selectedCategories : selectedCategories // ignore: cast_nullable_to_non_nullable
as Set<PlaceCategory>,advancedFilters: freezed == advancedFilters ? _self.advancedFilters : advancedFilters // ignore: cast_nullable_to_non_nullable
as GetPlacesRequestModel?,
  ));
}

/// Create a copy of ExploreState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationStateCopyWith<PlaceEntity, $Res> get trendingPlaces {
  
  return $PaginationStateCopyWith<PlaceEntity, $Res>(_self.trendingPlaces, (value) {
    return _then(_self.copyWith(trendingPlaces: value));
  });
}/// Create a copy of ExploreState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationStateCopyWith<PlaceEntity, $Res> get filteredPlaces {
  
  return $PaginationStateCopyWith<PlaceEntity, $Res>(_self.filteredPlaces, (value) {
    return _then(_self.copyWith(filteredPlaces: value));
  });
}
}

// dart format on
