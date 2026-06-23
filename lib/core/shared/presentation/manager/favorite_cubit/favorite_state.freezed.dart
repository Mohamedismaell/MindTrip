// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FavoriteState {

 Set<String> get favoriteIds; List<PlaceEntity> get favoritePlaces; FavoritesStatus get status; String? get errorMessage; PlaceCategory get selectedCategory;
/// Create a copy of FavoriteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteStateCopyWith<FavoriteState> get copyWith => _$FavoriteStateCopyWithImpl<FavoriteState>(this as FavoriteState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteState&&const DeepCollectionEquality().equals(other.favoriteIds, favoriteIds)&&const DeepCollectionEquality().equals(other.favoritePlaces, favoritePlaces)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(favoriteIds),const DeepCollectionEquality().hash(favoritePlaces),status,errorMessage,selectedCategory);

@override
String toString() {
  return 'FavoriteState(favoriteIds: $favoriteIds, favoritePlaces: $favoritePlaces, status: $status, errorMessage: $errorMessage, selectedCategory: $selectedCategory)';
}


}

/// @nodoc
abstract mixin class $FavoriteStateCopyWith<$Res>  {
  factory $FavoriteStateCopyWith(FavoriteState value, $Res Function(FavoriteState) _then) = _$FavoriteStateCopyWithImpl;
@useResult
$Res call({
 Set<String> favoriteIds, List<PlaceEntity> favoritePlaces, FavoritesStatus status, String? errorMessage, PlaceCategory selectedCategory
});




}
/// @nodoc
class _$FavoriteStateCopyWithImpl<$Res>
    implements $FavoriteStateCopyWith<$Res> {
  _$FavoriteStateCopyWithImpl(this._self, this._then);

  final FavoriteState _self;
  final $Res Function(FavoriteState) _then;

/// Create a copy of FavoriteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? favoriteIds = null,Object? favoritePlaces = null,Object? status = null,Object? errorMessage = freezed,Object? selectedCategory = null,}) {
  return _then(_self.copyWith(
favoriteIds: null == favoriteIds ? _self.favoriteIds : favoriteIds // ignore: cast_nullable_to_non_nullable
as Set<String>,favoritePlaces: null == favoritePlaces ? _self.favoritePlaces : favoritePlaces // ignore: cast_nullable_to_non_nullable
as List<PlaceEntity>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FavoritesStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,selectedCategory: null == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as PlaceCategory,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoriteState].
extension FavoriteStatePatterns on FavoriteState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoriteState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoriteState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoriteState value)  $default,){
final _that = this;
switch (_that) {
case _FavoriteState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoriteState value)?  $default,){
final _that = this;
switch (_that) {
case _FavoriteState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Set<String> favoriteIds,  List<PlaceEntity> favoritePlaces,  FavoritesStatus status,  String? errorMessage,  PlaceCategory selectedCategory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoriteState() when $default != null:
return $default(_that.favoriteIds,_that.favoritePlaces,_that.status,_that.errorMessage,_that.selectedCategory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Set<String> favoriteIds,  List<PlaceEntity> favoritePlaces,  FavoritesStatus status,  String? errorMessage,  PlaceCategory selectedCategory)  $default,) {final _that = this;
switch (_that) {
case _FavoriteState():
return $default(_that.favoriteIds,_that.favoritePlaces,_that.status,_that.errorMessage,_that.selectedCategory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Set<String> favoriteIds,  List<PlaceEntity> favoritePlaces,  FavoritesStatus status,  String? errorMessage,  PlaceCategory selectedCategory)?  $default,) {final _that = this;
switch (_that) {
case _FavoriteState() when $default != null:
return $default(_that.favoriteIds,_that.favoritePlaces,_that.status,_that.errorMessage,_that.selectedCategory);case _:
  return null;

}
}

}

/// @nodoc


class _FavoriteState extends FavoriteState {
  const _FavoriteState({final  Set<String> favoriteIds = const <String>{}, final  List<PlaceEntity> favoritePlaces = const <PlaceEntity>[], this.status = FavoritesStatus.initial, this.errorMessage, this.selectedCategory = PlaceCategory.all}): _favoriteIds = favoriteIds,_favoritePlaces = favoritePlaces,super._();
  

 final  Set<String> _favoriteIds;
@override@JsonKey() Set<String> get favoriteIds {
  if (_favoriteIds is EqualUnmodifiableSetView) return _favoriteIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_favoriteIds);
}

 final  List<PlaceEntity> _favoritePlaces;
@override@JsonKey() List<PlaceEntity> get favoritePlaces {
  if (_favoritePlaces is EqualUnmodifiableListView) return _favoritePlaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favoritePlaces);
}

@override@JsonKey() final  FavoritesStatus status;
@override final  String? errorMessage;
@override@JsonKey() final  PlaceCategory selectedCategory;

/// Create a copy of FavoriteState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoriteStateCopyWith<_FavoriteState> get copyWith => __$FavoriteStateCopyWithImpl<_FavoriteState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoriteState&&const DeepCollectionEquality().equals(other._favoriteIds, _favoriteIds)&&const DeepCollectionEquality().equals(other._favoritePlaces, _favoritePlaces)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_favoriteIds),const DeepCollectionEquality().hash(_favoritePlaces),status,errorMessage,selectedCategory);

@override
String toString() {
  return 'FavoriteState(favoriteIds: $favoriteIds, favoritePlaces: $favoritePlaces, status: $status, errorMessage: $errorMessage, selectedCategory: $selectedCategory)';
}


}

/// @nodoc
abstract mixin class _$FavoriteStateCopyWith<$Res> implements $FavoriteStateCopyWith<$Res> {
  factory _$FavoriteStateCopyWith(_FavoriteState value, $Res Function(_FavoriteState) _then) = __$FavoriteStateCopyWithImpl;
@override @useResult
$Res call({
 Set<String> favoriteIds, List<PlaceEntity> favoritePlaces, FavoritesStatus status, String? errorMessage, PlaceCategory selectedCategory
});




}
/// @nodoc
class __$FavoriteStateCopyWithImpl<$Res>
    implements _$FavoriteStateCopyWith<$Res> {
  __$FavoriteStateCopyWithImpl(this._self, this._then);

  final _FavoriteState _self;
  final $Res Function(_FavoriteState) _then;

/// Create a copy of FavoriteState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? favoriteIds = null,Object? favoritePlaces = null,Object? status = null,Object? errorMessage = freezed,Object? selectedCategory = null,}) {
  return _then(_FavoriteState(
favoriteIds: null == favoriteIds ? _self._favoriteIds : favoriteIds // ignore: cast_nullable_to_non_nullable
as Set<String>,favoritePlaces: null == favoritePlaces ? _self._favoritePlaces : favoritePlaces // ignore: cast_nullable_to_non_nullable
as List<PlaceEntity>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FavoritesStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,selectedCategory: null == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as PlaceCategory,
  ));
}


}

// dart format on
