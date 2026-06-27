// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_reviews_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileReviewsState {

 List<TripReviewEntity> get reviews; bool get isLoading; String? get errorMessage;
/// Create a copy of ProfileReviewsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileReviewsStateCopyWith<ProfileReviewsState> get copyWith => _$ProfileReviewsStateCopyWithImpl<ProfileReviewsState>(this as ProfileReviewsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileReviewsState&&const DeepCollectionEquality().equals(other.reviews, reviews)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(reviews),isLoading,errorMessage);

@override
String toString() {
  return 'ProfileReviewsState(reviews: $reviews, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ProfileReviewsStateCopyWith<$Res>  {
  factory $ProfileReviewsStateCopyWith(ProfileReviewsState value, $Res Function(ProfileReviewsState) _then) = _$ProfileReviewsStateCopyWithImpl;
@useResult
$Res call({
 List<TripReviewEntity> reviews, bool isLoading, String? errorMessage
});




}
/// @nodoc
class _$ProfileReviewsStateCopyWithImpl<$Res>
    implements $ProfileReviewsStateCopyWith<$Res> {
  _$ProfileReviewsStateCopyWithImpl(this._self, this._then);

  final ProfileReviewsState _self;
  final $Res Function(ProfileReviewsState) _then;

/// Create a copy of ProfileReviewsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reviews = null,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<TripReviewEntity>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileReviewsState].
extension ProfileReviewsStatePatterns on ProfileReviewsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileReviewsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileReviewsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileReviewsState value)  $default,){
final _that = this;
switch (_that) {
case _ProfileReviewsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileReviewsState value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileReviewsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TripReviewEntity> reviews,  bool isLoading,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileReviewsState() when $default != null:
return $default(_that.reviews,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TripReviewEntity> reviews,  bool isLoading,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ProfileReviewsState():
return $default(_that.reviews,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TripReviewEntity> reviews,  bool isLoading,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ProfileReviewsState() when $default != null:
return $default(_that.reviews,_that.isLoading,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileReviewsState implements ProfileReviewsState {
  const _ProfileReviewsState({final  List<TripReviewEntity> reviews = const [], this.isLoading = false, this.errorMessage}): _reviews = reviews;
  

 final  List<TripReviewEntity> _reviews;
@override@JsonKey() List<TripReviewEntity> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}

@override@JsonKey() final  bool isLoading;
@override final  String? errorMessage;

/// Create a copy of ProfileReviewsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileReviewsStateCopyWith<_ProfileReviewsState> get copyWith => __$ProfileReviewsStateCopyWithImpl<_ProfileReviewsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileReviewsState&&const DeepCollectionEquality().equals(other._reviews, _reviews)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_reviews),isLoading,errorMessage);

@override
String toString() {
  return 'ProfileReviewsState(reviews: $reviews, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ProfileReviewsStateCopyWith<$Res> implements $ProfileReviewsStateCopyWith<$Res> {
  factory _$ProfileReviewsStateCopyWith(_ProfileReviewsState value, $Res Function(_ProfileReviewsState) _then) = __$ProfileReviewsStateCopyWithImpl;
@override @useResult
$Res call({
 List<TripReviewEntity> reviews, bool isLoading, String? errorMessage
});




}
/// @nodoc
class __$ProfileReviewsStateCopyWithImpl<$Res>
    implements _$ProfileReviewsStateCopyWith<$Res> {
  __$ProfileReviewsStateCopyWithImpl(this._self, this._then);

  final _ProfileReviewsState _self;
  final $Res Function(_ProfileReviewsState) _then;

/// Create a copy of ProfileReviewsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reviews = null,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_ProfileReviewsState(
reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<TripReviewEntity>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
