// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripModel {

 String get id; String get title; String get subtitle; String get imageUrl; List<PlaceModel> get places; DateTime? get startDate; DateTime? get endDate; bool get isFavorite; bool get isAiGenerated;
/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripModelCopyWith<TripModel> get copyWith => _$TripModelCopyWithImpl<TripModel>(this as TripModel, _$identity);

  /// Serializes this TripModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.places, places)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.isAiGenerated, isAiGenerated) || other.isAiGenerated == isAiGenerated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,subtitle,imageUrl,const DeepCollectionEquality().hash(places),startDate,endDate,isFavorite,isAiGenerated);

@override
String toString() {
  return 'TripModel(id: $id, title: $title, subtitle: $subtitle, imageUrl: $imageUrl, places: $places, startDate: $startDate, endDate: $endDate, isFavorite: $isFavorite, isAiGenerated: $isAiGenerated)';
}


}

/// @nodoc
abstract mixin class $TripModelCopyWith<$Res>  {
  factory $TripModelCopyWith(TripModel value, $Res Function(TripModel) _then) = _$TripModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String subtitle, String imageUrl, List<PlaceModel> places, DateTime? startDate, DateTime? endDate, bool isFavorite, bool isAiGenerated
});




}
/// @nodoc
class _$TripModelCopyWithImpl<$Res>
    implements $TripModelCopyWith<$Res> {
  _$TripModelCopyWithImpl(this._self, this._then);

  final TripModel _self;
  final $Res Function(TripModel) _then;

/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? subtitle = null,Object? imageUrl = null,Object? places = null,Object? startDate = freezed,Object? endDate = freezed,Object? isFavorite = null,Object? isAiGenerated = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,places: null == places ? _self.places : places // ignore: cast_nullable_to_non_nullable
as List<PlaceModel>,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,isAiGenerated: null == isAiGenerated ? _self.isAiGenerated : isAiGenerated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TripModel].
extension TripModelPatterns on TripModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripModel value)  $default,){
final _that = this;
switch (_that) {
case _TripModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripModel value)?  $default,){
final _that = this;
switch (_that) {
case _TripModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String subtitle,  String imageUrl,  List<PlaceModel> places,  DateTime? startDate,  DateTime? endDate,  bool isFavorite,  bool isAiGenerated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripModel() when $default != null:
return $default(_that.id,_that.title,_that.subtitle,_that.imageUrl,_that.places,_that.startDate,_that.endDate,_that.isFavorite,_that.isAiGenerated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String subtitle,  String imageUrl,  List<PlaceModel> places,  DateTime? startDate,  DateTime? endDate,  bool isFavorite,  bool isAiGenerated)  $default,) {final _that = this;
switch (_that) {
case _TripModel():
return $default(_that.id,_that.title,_that.subtitle,_that.imageUrl,_that.places,_that.startDate,_that.endDate,_that.isFavorite,_that.isAiGenerated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String subtitle,  String imageUrl,  List<PlaceModel> places,  DateTime? startDate,  DateTime? endDate,  bool isFavorite,  bool isAiGenerated)?  $default,) {final _that = this;
switch (_that) {
case _TripModel() when $default != null:
return $default(_that.id,_that.title,_that.subtitle,_that.imageUrl,_that.places,_that.startDate,_that.endDate,_that.isFavorite,_that.isAiGenerated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripModel extends TripModel {
  const _TripModel({this.id = '', this.title = '', this.subtitle = '', this.imageUrl = '', final  List<PlaceModel> places = const [], this.startDate, this.endDate, this.isFavorite = false, this.isAiGenerated = false}): _places = places,super._();
  factory _TripModel.fromJson(Map<String, dynamic> json) => _$TripModelFromJson(json);

@override@JsonKey() final  String id;
@override@JsonKey() final  String title;
@override@JsonKey() final  String subtitle;
@override@JsonKey() final  String imageUrl;
 final  List<PlaceModel> _places;
@override@JsonKey() List<PlaceModel> get places {
  if (_places is EqualUnmodifiableListView) return _places;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_places);
}

@override final  DateTime? startDate;
@override final  DateTime? endDate;
@override@JsonKey() final  bool isFavorite;
@override@JsonKey() final  bool isAiGenerated;

/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripModelCopyWith<_TripModel> get copyWith => __$TripModelCopyWithImpl<_TripModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other._places, _places)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.isAiGenerated, isAiGenerated) || other.isAiGenerated == isAiGenerated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,subtitle,imageUrl,const DeepCollectionEquality().hash(_places),startDate,endDate,isFavorite,isAiGenerated);

@override
String toString() {
  return 'TripModel(id: $id, title: $title, subtitle: $subtitle, imageUrl: $imageUrl, places: $places, startDate: $startDate, endDate: $endDate, isFavorite: $isFavorite, isAiGenerated: $isAiGenerated)';
}


}

/// @nodoc
abstract mixin class _$TripModelCopyWith<$Res> implements $TripModelCopyWith<$Res> {
  factory _$TripModelCopyWith(_TripModel value, $Res Function(_TripModel) _then) = __$TripModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String subtitle, String imageUrl, List<PlaceModel> places, DateTime? startDate, DateTime? endDate, bool isFavorite, bool isAiGenerated
});




}
/// @nodoc
class __$TripModelCopyWithImpl<$Res>
    implements _$TripModelCopyWith<$Res> {
  __$TripModelCopyWithImpl(this._self, this._then);

  final _TripModel _self;
  final $Res Function(_TripModel) _then;

/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? subtitle = null,Object? imageUrl = null,Object? places = null,Object? startDate = freezed,Object? endDate = freezed,Object? isFavorite = null,Object? isAiGenerated = null,}) {
  return _then(_TripModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,places: null == places ? _self._places : places // ignore: cast_nullable_to_non_nullable
as List<PlaceModel>,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,isAiGenerated: null == isAiGenerated ? _self.isAiGenerated : isAiGenerated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
