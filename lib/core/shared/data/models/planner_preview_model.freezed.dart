// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planner_preview_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlannerStopModel {

@HiveField(0) String get time;@HiveField(1) String get label;
/// Create a copy of PlannerStopModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlannerStopModelCopyWith<PlannerStopModel> get copyWith => _$PlannerStopModelCopyWithImpl<PlannerStopModel>(this as PlannerStopModel, _$identity);

  /// Serializes this PlannerStopModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlannerStopModel&&(identical(other.time, time) || other.time == time)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,label);

@override
String toString() {
  return 'PlannerStopModel(time: $time, label: $label)';
}


}

/// @nodoc
abstract mixin class $PlannerStopModelCopyWith<$Res>  {
  factory $PlannerStopModelCopyWith(PlannerStopModel value, $Res Function(PlannerStopModel) _then) = _$PlannerStopModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String time,@HiveField(1) String label
});




}
/// @nodoc
class _$PlannerStopModelCopyWithImpl<$Res>
    implements $PlannerStopModelCopyWith<$Res> {
  _$PlannerStopModelCopyWithImpl(this._self, this._then);

  final PlannerStopModel _self;
  final $Res Function(PlannerStopModel) _then;

/// Create a copy of PlannerStopModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? time = null,Object? label = null,}) {
  return _then(_self.copyWith(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PlannerStopModel].
extension PlannerStopModelPatterns on PlannerStopModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlannerStopModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlannerStopModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlannerStopModel value)  $default,){
final _that = this;
switch (_that) {
case _PlannerStopModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlannerStopModel value)?  $default,){
final _that = this;
switch (_that) {
case _PlannerStopModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String time, @HiveField(1)  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlannerStopModel() when $default != null:
return $default(_that.time,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String time, @HiveField(1)  String label)  $default,) {final _that = this;
switch (_that) {
case _PlannerStopModel():
return $default(_that.time,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String time, @HiveField(1)  String label)?  $default,) {final _that = this;
switch (_that) {
case _PlannerStopModel() when $default != null:
return $default(_that.time,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 12)
class _PlannerStopModel extends PlannerStopModel {
  const _PlannerStopModel({@HiveField(0) required this.time, @HiveField(1) required this.label}): super._();
  factory _PlannerStopModel.fromJson(Map<String, dynamic> json) => _$PlannerStopModelFromJson(json);

@override@HiveField(0) final  String time;
@override@HiveField(1) final  String label;

/// Create a copy of PlannerStopModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlannerStopModelCopyWith<_PlannerStopModel> get copyWith => __$PlannerStopModelCopyWithImpl<_PlannerStopModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlannerStopModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlannerStopModel&&(identical(other.time, time) || other.time == time)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,label);

@override
String toString() {
  return 'PlannerStopModel(time: $time, label: $label)';
}


}

/// @nodoc
abstract mixin class _$PlannerStopModelCopyWith<$Res> implements $PlannerStopModelCopyWith<$Res> {
  factory _$PlannerStopModelCopyWith(_PlannerStopModel value, $Res Function(_PlannerStopModel) _then) = __$PlannerStopModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String time,@HiveField(1) String label
});




}
/// @nodoc
class __$PlannerStopModelCopyWithImpl<$Res>
    implements _$PlannerStopModelCopyWith<$Res> {
  __$PlannerStopModelCopyWithImpl(this._self, this._then);

  final _PlannerStopModel _self;
  final $Res Function(_PlannerStopModel) _then;

/// Create a copy of PlannerStopModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? time = null,Object? label = null,}) {
  return _then(_PlannerStopModel(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PlannerPreviewModel {

@HiveField(0) String get title;@HiveField(1) String get imageUrl;@HiveField(2) List<PlannerStopModel> get stops;@HiveField(3) String get badge;
/// Create a copy of PlannerPreviewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlannerPreviewModelCopyWith<PlannerPreviewModel> get copyWith => _$PlannerPreviewModelCopyWithImpl<PlannerPreviewModel>(this as PlannerPreviewModel, _$identity);

  /// Serializes this PlannerPreviewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlannerPreviewModel&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.stops, stops)&&(identical(other.badge, badge) || other.badge == badge));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,imageUrl,const DeepCollectionEquality().hash(stops),badge);

@override
String toString() {
  return 'PlannerPreviewModel(title: $title, imageUrl: $imageUrl, stops: $stops, badge: $badge)';
}


}

/// @nodoc
abstract mixin class $PlannerPreviewModelCopyWith<$Res>  {
  factory $PlannerPreviewModelCopyWith(PlannerPreviewModel value, $Res Function(PlannerPreviewModel) _then) = _$PlannerPreviewModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String title,@HiveField(1) String imageUrl,@HiveField(2) List<PlannerStopModel> stops,@HiveField(3) String badge
});




}
/// @nodoc
class _$PlannerPreviewModelCopyWithImpl<$Res>
    implements $PlannerPreviewModelCopyWith<$Res> {
  _$PlannerPreviewModelCopyWithImpl(this._self, this._then);

  final PlannerPreviewModel _self;
  final $Res Function(PlannerPreviewModel) _then;

/// Create a copy of PlannerPreviewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? imageUrl = null,Object? stops = null,Object? badge = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,stops: null == stops ? _self.stops : stops // ignore: cast_nullable_to_non_nullable
as List<PlannerStopModel>,badge: null == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PlannerPreviewModel].
extension PlannerPreviewModelPatterns on PlannerPreviewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlannerPreviewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlannerPreviewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlannerPreviewModel value)  $default,){
final _that = this;
switch (_that) {
case _PlannerPreviewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlannerPreviewModel value)?  $default,){
final _that = this;
switch (_that) {
case _PlannerPreviewModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String title, @HiveField(1)  String imageUrl, @HiveField(2)  List<PlannerStopModel> stops, @HiveField(3)  String badge)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlannerPreviewModel() when $default != null:
return $default(_that.title,_that.imageUrl,_that.stops,_that.badge);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String title, @HiveField(1)  String imageUrl, @HiveField(2)  List<PlannerStopModel> stops, @HiveField(3)  String badge)  $default,) {final _that = this;
switch (_that) {
case _PlannerPreviewModel():
return $default(_that.title,_that.imageUrl,_that.stops,_that.badge);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String title, @HiveField(1)  String imageUrl, @HiveField(2)  List<PlannerStopModel> stops, @HiveField(3)  String badge)?  $default,) {final _that = this;
switch (_that) {
case _PlannerPreviewModel() when $default != null:
return $default(_that.title,_that.imageUrl,_that.stops,_that.badge);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 13)
class _PlannerPreviewModel extends PlannerPreviewModel {
  const _PlannerPreviewModel({@HiveField(0) required this.title, @HiveField(1) required this.imageUrl, @HiveField(2) required final  List<PlannerStopModel> stops, @HiveField(3) required this.badge}): _stops = stops,super._();
  factory _PlannerPreviewModel.fromJson(Map<String, dynamic> json) => _$PlannerPreviewModelFromJson(json);

@override@HiveField(0) final  String title;
@override@HiveField(1) final  String imageUrl;
 final  List<PlannerStopModel> _stops;
@override@HiveField(2) List<PlannerStopModel> get stops {
  if (_stops is EqualUnmodifiableListView) return _stops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stops);
}

@override@HiveField(3) final  String badge;

/// Create a copy of PlannerPreviewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlannerPreviewModelCopyWith<_PlannerPreviewModel> get copyWith => __$PlannerPreviewModelCopyWithImpl<_PlannerPreviewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlannerPreviewModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlannerPreviewModel&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other._stops, _stops)&&(identical(other.badge, badge) || other.badge == badge));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,imageUrl,const DeepCollectionEquality().hash(_stops),badge);

@override
String toString() {
  return 'PlannerPreviewModel(title: $title, imageUrl: $imageUrl, stops: $stops, badge: $badge)';
}


}

/// @nodoc
abstract mixin class _$PlannerPreviewModelCopyWith<$Res> implements $PlannerPreviewModelCopyWith<$Res> {
  factory _$PlannerPreviewModelCopyWith(_PlannerPreviewModel value, $Res Function(_PlannerPreviewModel) _then) = __$PlannerPreviewModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String title,@HiveField(1) String imageUrl,@HiveField(2) List<PlannerStopModel> stops,@HiveField(3) String badge
});




}
/// @nodoc
class __$PlannerPreviewModelCopyWithImpl<$Res>
    implements _$PlannerPreviewModelCopyWith<$Res> {
  __$PlannerPreviewModelCopyWithImpl(this._self, this._then);

  final _PlannerPreviewModel _self;
  final $Res Function(_PlannerPreviewModel) _then;

/// Create a copy of PlannerPreviewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? imageUrl = null,Object? stops = null,Object? badge = null,}) {
  return _then(_PlannerPreviewModel(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,stops: null == stops ? _self._stops : stops // ignore: cast_nullable_to_non_nullable
as List<PlannerStopModel>,badge: null == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
