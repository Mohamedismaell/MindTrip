// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_review_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripReviewModel {

 String get tripReviewId; String get tripId; String get destination; double get rating; String get comment; DateTime get createdAt;
/// Create a copy of TripReviewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripReviewModelCopyWith<TripReviewModel> get copyWith => _$TripReviewModelCopyWithImpl<TripReviewModel>(this as TripReviewModel, _$identity);

  /// Serializes this TripReviewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripReviewModel&&(identical(other.tripReviewId, tripReviewId) || other.tripReviewId == tripReviewId)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tripReviewId,tripId,destination,rating,comment,createdAt);

@override
String toString() {
  return 'TripReviewModel(tripReviewId: $tripReviewId, tripId: $tripId, destination: $destination, rating: $rating, comment: $comment, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TripReviewModelCopyWith<$Res>  {
  factory $TripReviewModelCopyWith(TripReviewModel value, $Res Function(TripReviewModel) _then) = _$TripReviewModelCopyWithImpl;
@useResult
$Res call({
 String tripReviewId, String tripId, String destination, double rating, String comment, DateTime createdAt
});




}
/// @nodoc
class _$TripReviewModelCopyWithImpl<$Res>
    implements $TripReviewModelCopyWith<$Res> {
  _$TripReviewModelCopyWithImpl(this._self, this._then);

  final TripReviewModel _self;
  final $Res Function(TripReviewModel) _then;

/// Create a copy of TripReviewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripReviewId = null,Object? tripId = null,Object? destination = null,Object? rating = null,Object? comment = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
tripReviewId: null == tripReviewId ? _self.tripReviewId : tripReviewId // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TripReviewModel].
extension TripReviewModelPatterns on TripReviewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripReviewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripReviewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripReviewModel value)  $default,){
final _that = this;
switch (_that) {
case _TripReviewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripReviewModel value)?  $default,){
final _that = this;
switch (_that) {
case _TripReviewModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tripReviewId,  String tripId,  String destination,  double rating,  String comment,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripReviewModel() when $default != null:
return $default(_that.tripReviewId,_that.tripId,_that.destination,_that.rating,_that.comment,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tripReviewId,  String tripId,  String destination,  double rating,  String comment,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _TripReviewModel():
return $default(_that.tripReviewId,_that.tripId,_that.destination,_that.rating,_that.comment,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tripReviewId,  String tripId,  String destination,  double rating,  String comment,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _TripReviewModel() when $default != null:
return $default(_that.tripReviewId,_that.tripId,_that.destination,_that.rating,_that.comment,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripReviewModel implements TripReviewModel {
  const _TripReviewModel({required this.tripReviewId, required this.tripId, required this.destination, required this.rating, required this.comment, required this.createdAt});
  factory _TripReviewModel.fromJson(Map<String, dynamic> json) => _$TripReviewModelFromJson(json);

@override final  String tripReviewId;
@override final  String tripId;
@override final  String destination;
@override final  double rating;
@override final  String comment;
@override final  DateTime createdAt;

/// Create a copy of TripReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripReviewModelCopyWith<_TripReviewModel> get copyWith => __$TripReviewModelCopyWithImpl<_TripReviewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripReviewModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripReviewModel&&(identical(other.tripReviewId, tripReviewId) || other.tripReviewId == tripReviewId)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tripReviewId,tripId,destination,rating,comment,createdAt);

@override
String toString() {
  return 'TripReviewModel(tripReviewId: $tripReviewId, tripId: $tripId, destination: $destination, rating: $rating, comment: $comment, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TripReviewModelCopyWith<$Res> implements $TripReviewModelCopyWith<$Res> {
  factory _$TripReviewModelCopyWith(_TripReviewModel value, $Res Function(_TripReviewModel) _then) = __$TripReviewModelCopyWithImpl;
@override @useResult
$Res call({
 String tripReviewId, String tripId, String destination, double rating, String comment, DateTime createdAt
});




}
/// @nodoc
class __$TripReviewModelCopyWithImpl<$Res>
    implements _$TripReviewModelCopyWith<$Res> {
  __$TripReviewModelCopyWithImpl(this._self, this._then);

  final _TripReviewModel _self;
  final $Res Function(_TripReviewModel) _then;

/// Create a copy of TripReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripReviewId = null,Object? tripId = null,Object? destination = null,Object? rating = null,Object? comment = null,Object? createdAt = null,}) {
  return _then(_TripReviewModel(
tripReviewId: null == tripReviewId ? _self.tripReviewId : tripReviewId // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
