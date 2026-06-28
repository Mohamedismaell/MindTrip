// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_trip_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FavoriteTripModel {

@HiveField(0) String get favoriteTripId;@HiveField(1) String get tripId;@HiveField(2) String get destination;@HiveField(3) DateTime get startDate;@HiveField(4) DateTime get endDate;@HiveField(5) int get durationDays;@HiveField(6) String get status;@HiveField(7) DateTime get createdAt;
/// Create a copy of FavoriteTripModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteTripModelCopyWith<FavoriteTripModel> get copyWith => _$FavoriteTripModelCopyWithImpl<FavoriteTripModel>(this as FavoriteTripModel, _$identity);

  /// Serializes this FavoriteTripModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteTripModel&&(identical(other.favoriteTripId, favoriteTripId) || other.favoriteTripId == favoriteTripId)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.durationDays, durationDays) || other.durationDays == durationDays)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,favoriteTripId,tripId,destination,startDate,endDate,durationDays,status,createdAt);

@override
String toString() {
  return 'FavoriteTripModel(favoriteTripId: $favoriteTripId, tripId: $tripId, destination: $destination, startDate: $startDate, endDate: $endDate, durationDays: $durationDays, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $FavoriteTripModelCopyWith<$Res>  {
  factory $FavoriteTripModelCopyWith(FavoriteTripModel value, $Res Function(FavoriteTripModel) _then) = _$FavoriteTripModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String favoriteTripId,@HiveField(1) String tripId,@HiveField(2) String destination,@HiveField(3) DateTime startDate,@HiveField(4) DateTime endDate,@HiveField(5) int durationDays,@HiveField(6) String status,@HiveField(7) DateTime createdAt
});




}
/// @nodoc
class _$FavoriteTripModelCopyWithImpl<$Res>
    implements $FavoriteTripModelCopyWith<$Res> {
  _$FavoriteTripModelCopyWithImpl(this._self, this._then);

  final FavoriteTripModel _self;
  final $Res Function(FavoriteTripModel) _then;

/// Create a copy of FavoriteTripModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? favoriteTripId = null,Object? tripId = null,Object? destination = null,Object? startDate = null,Object? endDate = null,Object? durationDays = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
favoriteTripId: null == favoriteTripId ? _self.favoriteTripId : favoriteTripId // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,durationDays: null == durationDays ? _self.durationDays : durationDays // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoriteTripModel].
extension FavoriteTripModelPatterns on FavoriteTripModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoriteTripModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoriteTripModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoriteTripModel value)  $default,){
final _that = this;
switch (_that) {
case _FavoriteTripModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoriteTripModel value)?  $default,){
final _that = this;
switch (_that) {
case _FavoriteTripModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String favoriteTripId, @HiveField(1)  String tripId, @HiveField(2)  String destination, @HiveField(3)  DateTime startDate, @HiveField(4)  DateTime endDate, @HiveField(5)  int durationDays, @HiveField(6)  String status, @HiveField(7)  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoriteTripModel() when $default != null:
return $default(_that.favoriteTripId,_that.tripId,_that.destination,_that.startDate,_that.endDate,_that.durationDays,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String favoriteTripId, @HiveField(1)  String tripId, @HiveField(2)  String destination, @HiveField(3)  DateTime startDate, @HiveField(4)  DateTime endDate, @HiveField(5)  int durationDays, @HiveField(6)  String status, @HiveField(7)  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _FavoriteTripModel():
return $default(_that.favoriteTripId,_that.tripId,_that.destination,_that.startDate,_that.endDate,_that.durationDays,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String favoriteTripId, @HiveField(1)  String tripId, @HiveField(2)  String destination, @HiveField(3)  DateTime startDate, @HiveField(4)  DateTime endDate, @HiveField(5)  int durationDays, @HiveField(6)  String status, @HiveField(7)  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _FavoriteTripModel() when $default != null:
return $default(_that.favoriteTripId,_that.tripId,_that.destination,_that.startDate,_that.endDate,_that.durationDays,_that.status,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FavoriteTripModel extends FavoriteTripModel {
  const _FavoriteTripModel({@HiveField(0) required this.favoriteTripId, @HiveField(1) required this.tripId, @HiveField(2) required this.destination, @HiveField(3) required this.startDate, @HiveField(4) required this.endDate, @HiveField(5) required this.durationDays, @HiveField(6) required this.status, @HiveField(7) required this.createdAt}): super._();
  factory _FavoriteTripModel.fromJson(Map<String, dynamic> json) => _$FavoriteTripModelFromJson(json);

@override@HiveField(0) final  String favoriteTripId;
@override@HiveField(1) final  String tripId;
@override@HiveField(2) final  String destination;
@override@HiveField(3) final  DateTime startDate;
@override@HiveField(4) final  DateTime endDate;
@override@HiveField(5) final  int durationDays;
@override@HiveField(6) final  String status;
@override@HiveField(7) final  DateTime createdAt;

/// Create a copy of FavoriteTripModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoriteTripModelCopyWith<_FavoriteTripModel> get copyWith => __$FavoriteTripModelCopyWithImpl<_FavoriteTripModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FavoriteTripModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoriteTripModel&&(identical(other.favoriteTripId, favoriteTripId) || other.favoriteTripId == favoriteTripId)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.durationDays, durationDays) || other.durationDays == durationDays)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,favoriteTripId,tripId,destination,startDate,endDate,durationDays,status,createdAt);

@override
String toString() {
  return 'FavoriteTripModel(favoriteTripId: $favoriteTripId, tripId: $tripId, destination: $destination, startDate: $startDate, endDate: $endDate, durationDays: $durationDays, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$FavoriteTripModelCopyWith<$Res> implements $FavoriteTripModelCopyWith<$Res> {
  factory _$FavoriteTripModelCopyWith(_FavoriteTripModel value, $Res Function(_FavoriteTripModel) _then) = __$FavoriteTripModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String favoriteTripId,@HiveField(1) String tripId,@HiveField(2) String destination,@HiveField(3) DateTime startDate,@HiveField(4) DateTime endDate,@HiveField(5) int durationDays,@HiveField(6) String status,@HiveField(7) DateTime createdAt
});




}
/// @nodoc
class __$FavoriteTripModelCopyWithImpl<$Res>
    implements _$FavoriteTripModelCopyWith<$Res> {
  __$FavoriteTripModelCopyWithImpl(this._self, this._then);

  final _FavoriteTripModel _self;
  final $Res Function(_FavoriteTripModel) _then;

/// Create a copy of FavoriteTripModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? favoriteTripId = null,Object? tripId = null,Object? destination = null,Object? startDate = null,Object? endDate = null,Object? durationDays = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_FavoriteTripModel(
favoriteTripId: null == favoriteTripId ? _self.favoriteTripId : favoriteTripId // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,durationDays: null == durationDays ? _self.durationDays : durationDays // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
