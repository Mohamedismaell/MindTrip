// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explore_all_places_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExploreAllPlacesState {

 ExploreAllPlacesStatus get status; PaginationState<PlaceEntity> get places; String get error; String get searchQuery; List<String> get selectedCategories; Map<String, dynamic> get filters;
/// Create a copy of ExploreAllPlacesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreAllPlacesStateCopyWith<ExploreAllPlacesState> get copyWith => _$ExploreAllPlacesStateCopyWithImpl<ExploreAllPlacesState>(this as ExploreAllPlacesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreAllPlacesState&&(identical(other.status, status) || other.status == status)&&(identical(other.places, places) || other.places == places)&&(identical(other.error, error) || other.error == error)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&const DeepCollectionEquality().equals(other.selectedCategories, selectedCategories)&&const DeepCollectionEquality().equals(other.filters, filters));
}


@override
int get hashCode => Object.hash(runtimeType,status,places,error,searchQuery,const DeepCollectionEquality().hash(selectedCategories),const DeepCollectionEquality().hash(filters));

@override
String toString() {
  return 'ExploreAllPlacesState(status: $status, places: $places, error: $error, searchQuery: $searchQuery, selectedCategories: $selectedCategories, filters: $filters)';
}


}

/// @nodoc
abstract mixin class $ExploreAllPlacesStateCopyWith<$Res>  {
  factory $ExploreAllPlacesStateCopyWith(ExploreAllPlacesState value, $Res Function(ExploreAllPlacesState) _then) = _$ExploreAllPlacesStateCopyWithImpl;
@useResult
$Res call({
 ExploreAllPlacesStatus status, PaginationState<PlaceEntity> places, String error, String searchQuery, List<String> selectedCategories, Map<String, dynamic> filters
});


$PaginationStateCopyWith<PlaceEntity, $Res> get places;

}
/// @nodoc
class _$ExploreAllPlacesStateCopyWithImpl<$Res>
    implements $ExploreAllPlacesStateCopyWith<$Res> {
  _$ExploreAllPlacesStateCopyWithImpl(this._self, this._then);

  final ExploreAllPlacesState _self;
  final $Res Function(ExploreAllPlacesState) _then;

/// Create a copy of ExploreAllPlacesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? places = null,Object? error = null,Object? searchQuery = null,Object? selectedCategories = null,Object? filters = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ExploreAllPlacesStatus,places: null == places ? _self.places : places // ignore: cast_nullable_to_non_nullable
as PaginationState<PlaceEntity>,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedCategories: null == selectedCategories ? _self.selectedCategories : selectedCategories // ignore: cast_nullable_to_non_nullable
as List<String>,filters: null == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}
/// Create a copy of ExploreAllPlacesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationStateCopyWith<PlaceEntity, $Res> get places {
  
  return $PaginationStateCopyWith<PlaceEntity, $Res>(_self.places, (value) {
    return _then(_self.copyWith(places: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExploreAllPlacesState].
extension ExploreAllPlacesStatePatterns on ExploreAllPlacesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExploreAllPlacesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExploreAllPlacesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExploreAllPlacesState value)  $default,){
final _that = this;
switch (_that) {
case _ExploreAllPlacesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExploreAllPlacesState value)?  $default,){
final _that = this;
switch (_that) {
case _ExploreAllPlacesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ExploreAllPlacesStatus status,  PaginationState<PlaceEntity> places,  String error,  String searchQuery,  List<String> selectedCategories,  Map<String, dynamic> filters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExploreAllPlacesState() when $default != null:
return $default(_that.status,_that.places,_that.error,_that.searchQuery,_that.selectedCategories,_that.filters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ExploreAllPlacesStatus status,  PaginationState<PlaceEntity> places,  String error,  String searchQuery,  List<String> selectedCategories,  Map<String, dynamic> filters)  $default,) {final _that = this;
switch (_that) {
case _ExploreAllPlacesState():
return $default(_that.status,_that.places,_that.error,_that.searchQuery,_that.selectedCategories,_that.filters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ExploreAllPlacesStatus status,  PaginationState<PlaceEntity> places,  String error,  String searchQuery,  List<String> selectedCategories,  Map<String, dynamic> filters)?  $default,) {final _that = this;
switch (_that) {
case _ExploreAllPlacesState() when $default != null:
return $default(_that.status,_that.places,_that.error,_that.searchQuery,_that.selectedCategories,_that.filters);case _:
  return null;

}
}

}

/// @nodoc


class _ExploreAllPlacesState implements ExploreAllPlacesState {
  const _ExploreAllPlacesState({this.status = ExploreAllPlacesStatus.initial, this.places = const PaginationState<PlaceEntity>(), this.error = '', this.searchQuery = '', final  List<String> selectedCategories = const [], final  Map<String, dynamic> filters = const {}}): _selectedCategories = selectedCategories,_filters = filters;
  

@override@JsonKey() final  ExploreAllPlacesStatus status;
@override@JsonKey() final  PaginationState<PlaceEntity> places;
@override@JsonKey() final  String error;
@override@JsonKey() final  String searchQuery;
 final  List<String> _selectedCategories;
@override@JsonKey() List<String> get selectedCategories {
  if (_selectedCategories is EqualUnmodifiableListView) return _selectedCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedCategories);
}

 final  Map<String, dynamic> _filters;
@override@JsonKey() Map<String, dynamic> get filters {
  if (_filters is EqualUnmodifiableMapView) return _filters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_filters);
}


/// Create a copy of ExploreAllPlacesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExploreAllPlacesStateCopyWith<_ExploreAllPlacesState> get copyWith => __$ExploreAllPlacesStateCopyWithImpl<_ExploreAllPlacesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExploreAllPlacesState&&(identical(other.status, status) || other.status == status)&&(identical(other.places, places) || other.places == places)&&(identical(other.error, error) || other.error == error)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&const DeepCollectionEquality().equals(other._selectedCategories, _selectedCategories)&&const DeepCollectionEquality().equals(other._filters, _filters));
}


@override
int get hashCode => Object.hash(runtimeType,status,places,error,searchQuery,const DeepCollectionEquality().hash(_selectedCategories),const DeepCollectionEquality().hash(_filters));

@override
String toString() {
  return 'ExploreAllPlacesState(status: $status, places: $places, error: $error, searchQuery: $searchQuery, selectedCategories: $selectedCategories, filters: $filters)';
}


}

/// @nodoc
abstract mixin class _$ExploreAllPlacesStateCopyWith<$Res> implements $ExploreAllPlacesStateCopyWith<$Res> {
  factory _$ExploreAllPlacesStateCopyWith(_ExploreAllPlacesState value, $Res Function(_ExploreAllPlacesState) _then) = __$ExploreAllPlacesStateCopyWithImpl;
@override @useResult
$Res call({
 ExploreAllPlacesStatus status, PaginationState<PlaceEntity> places, String error, String searchQuery, List<String> selectedCategories, Map<String, dynamic> filters
});


@override $PaginationStateCopyWith<PlaceEntity, $Res> get places;

}
/// @nodoc
class __$ExploreAllPlacesStateCopyWithImpl<$Res>
    implements _$ExploreAllPlacesStateCopyWith<$Res> {
  __$ExploreAllPlacesStateCopyWithImpl(this._self, this._then);

  final _ExploreAllPlacesState _self;
  final $Res Function(_ExploreAllPlacesState) _then;

/// Create a copy of ExploreAllPlacesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? places = null,Object? error = null,Object? searchQuery = null,Object? selectedCategories = null,Object? filters = null,}) {
  return _then(_ExploreAllPlacesState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ExploreAllPlacesStatus,places: null == places ? _self.places : places // ignore: cast_nullable_to_non_nullable
as PaginationState<PlaceEntity>,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,selectedCategories: null == selectedCategories ? _self._selectedCategories : selectedCategories // ignore: cast_nullable_to_non_nullable
as List<String>,filters: null == filters ? _self._filters : filters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

/// Create a copy of ExploreAllPlacesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationStateCopyWith<PlaceEntity, $Res> get places {
  
  return $PaginationStateCopyWith<PlaceEntity, $Res>(_self.places, (value) {
    return _then(_self.copyWith(places: value));
  });
}
}

// dart format on
