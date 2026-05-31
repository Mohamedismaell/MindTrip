// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tour_package_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TourPackageModel {

 String get id; String get title; LocationModel get location; String get imageUrl; double get price; double get rating; int get durationDays;
/// Create a copy of TourPackageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TourPackageModelCopyWith<TourPackageModel> get copyWith => _$TourPackageModelCopyWithImpl<TourPackageModel>(this as TourPackageModel, _$identity);

  /// Serializes this TourPackageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TourPackageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.location, location) || other.location == location)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.price, price) || other.price == price)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.durationDays, durationDays) || other.durationDays == durationDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,location,imageUrl,price,rating,durationDays);

@override
String toString() {
  return 'TourPackageModel(id: $id, title: $title, location: $location, imageUrl: $imageUrl, price: $price, rating: $rating, durationDays: $durationDays)';
}


}

/// @nodoc
abstract mixin class $TourPackageModelCopyWith<$Res>  {
  factory $TourPackageModelCopyWith(TourPackageModel value, $Res Function(TourPackageModel) _then) = _$TourPackageModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, LocationModel location, String imageUrl, double price, double rating, int durationDays
});


$LocationModelCopyWith<$Res> get location;

}
/// @nodoc
class _$TourPackageModelCopyWithImpl<$Res>
    implements $TourPackageModelCopyWith<$Res> {
  _$TourPackageModelCopyWithImpl(this._self, this._then);

  final TourPackageModel _self;
  final $Res Function(TourPackageModel) _then;

/// Create a copy of TourPackageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? location = null,Object? imageUrl = null,Object? price = null,Object? rating = null,Object? durationDays = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocationModel,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,durationDays: null == durationDays ? _self.durationDays : durationDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of TourPackageModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationModelCopyWith<$Res> get location {
  
  return $LocationModelCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [TourPackageModel].
extension TourPackageModelPatterns on TourPackageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TourPackageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TourPackageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TourPackageModel value)  $default,){
final _that = this;
switch (_that) {
case _TourPackageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TourPackageModel value)?  $default,){
final _that = this;
switch (_that) {
case _TourPackageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  LocationModel location,  String imageUrl,  double price,  double rating,  int durationDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TourPackageModel() when $default != null:
return $default(_that.id,_that.title,_that.location,_that.imageUrl,_that.price,_that.rating,_that.durationDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  LocationModel location,  String imageUrl,  double price,  double rating,  int durationDays)  $default,) {final _that = this;
switch (_that) {
case _TourPackageModel():
return $default(_that.id,_that.title,_that.location,_that.imageUrl,_that.price,_that.rating,_that.durationDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  LocationModel location,  String imageUrl,  double price,  double rating,  int durationDays)?  $default,) {final _that = this;
switch (_that) {
case _TourPackageModel() when $default != null:
return $default(_that.id,_that.title,_that.location,_that.imageUrl,_that.price,_that.rating,_that.durationDays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TourPackageModel extends TourPackageModel {
  const _TourPackageModel({this.id = '', this.title = '', required this.location, this.imageUrl = '', this.price = 0.0, this.rating = 0.0, this.durationDays = 0}): super._();
  factory _TourPackageModel.fromJson(Map<String, dynamic> json) => _$TourPackageModelFromJson(json);

@override@JsonKey() final  String id;
@override@JsonKey() final  String title;
@override final  LocationModel location;
@override@JsonKey() final  String imageUrl;
@override@JsonKey() final  double price;
@override@JsonKey() final  double rating;
@override@JsonKey() final  int durationDays;

/// Create a copy of TourPackageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TourPackageModelCopyWith<_TourPackageModel> get copyWith => __$TourPackageModelCopyWithImpl<_TourPackageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TourPackageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TourPackageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.location, location) || other.location == location)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.price, price) || other.price == price)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.durationDays, durationDays) || other.durationDays == durationDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,location,imageUrl,price,rating,durationDays);

@override
String toString() {
  return 'TourPackageModel(id: $id, title: $title, location: $location, imageUrl: $imageUrl, price: $price, rating: $rating, durationDays: $durationDays)';
}


}

/// @nodoc
abstract mixin class _$TourPackageModelCopyWith<$Res> implements $TourPackageModelCopyWith<$Res> {
  factory _$TourPackageModelCopyWith(_TourPackageModel value, $Res Function(_TourPackageModel) _then) = __$TourPackageModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, LocationModel location, String imageUrl, double price, double rating, int durationDays
});


@override $LocationModelCopyWith<$Res> get location;

}
/// @nodoc
class __$TourPackageModelCopyWithImpl<$Res>
    implements _$TourPackageModelCopyWith<$Res> {
  __$TourPackageModelCopyWithImpl(this._self, this._then);

  final _TourPackageModel _self;
  final $Res Function(_TourPackageModel) _then;

/// Create a copy of TourPackageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? location = null,Object? imageUrl = null,Object? price = null,Object? rating = null,Object? durationDays = null,}) {
  return _then(_TourPackageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocationModel,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,durationDays: null == durationDays ? _self.durationDays : durationDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of TourPackageModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationModelCopyWith<$Res> get location {
  
  return $LocationModelCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}

// dart format on
