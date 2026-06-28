// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generate_plan_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GeneratePlanMustIncludeItem {

 String get name;@JsonKey(name: 'place_id', includeIfNull: false) String? get placeId;@JsonKey(includeIfNull: false) String? get type;
/// Create a copy of GeneratePlanMustIncludeItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeneratePlanMustIncludeItemCopyWith<GeneratePlanMustIncludeItem> get copyWith => _$GeneratePlanMustIncludeItemCopyWithImpl<GeneratePlanMustIncludeItem>(this as GeneratePlanMustIncludeItem, _$identity);

  /// Serializes this GeneratePlanMustIncludeItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeneratePlanMustIncludeItem&&(identical(other.name, name) || other.name == name)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,placeId,type);

@override
String toString() {
  return 'GeneratePlanMustIncludeItem(name: $name, placeId: $placeId, type: $type)';
}


}

/// @nodoc
abstract mixin class $GeneratePlanMustIncludeItemCopyWith<$Res>  {
  factory $GeneratePlanMustIncludeItemCopyWith(GeneratePlanMustIncludeItem value, $Res Function(GeneratePlanMustIncludeItem) _then) = _$GeneratePlanMustIncludeItemCopyWithImpl;
@useResult
$Res call({
 String name,@JsonKey(name: 'place_id', includeIfNull: false) String? placeId,@JsonKey(includeIfNull: false) String? type
});




}
/// @nodoc
class _$GeneratePlanMustIncludeItemCopyWithImpl<$Res>
    implements $GeneratePlanMustIncludeItemCopyWith<$Res> {
  _$GeneratePlanMustIncludeItemCopyWithImpl(this._self, this._then);

  final GeneratePlanMustIncludeItem _self;
  final $Res Function(GeneratePlanMustIncludeItem) _then;

/// Create a copy of GeneratePlanMustIncludeItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? placeId = freezed,Object? type = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GeneratePlanMustIncludeItem].
extension GeneratePlanMustIncludeItemPatterns on GeneratePlanMustIncludeItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeneratePlanMustIncludeItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeneratePlanMustIncludeItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeneratePlanMustIncludeItem value)  $default,){
final _that = this;
switch (_that) {
case _GeneratePlanMustIncludeItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeneratePlanMustIncludeItem value)?  $default,){
final _that = this;
switch (_that) {
case _GeneratePlanMustIncludeItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'place_id', includeIfNull: false)  String? placeId, @JsonKey(includeIfNull: false)  String? type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeneratePlanMustIncludeItem() when $default != null:
return $default(_that.name,_that.placeId,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @JsonKey(name: 'place_id', includeIfNull: false)  String? placeId, @JsonKey(includeIfNull: false)  String? type)  $default,) {final _that = this;
switch (_that) {
case _GeneratePlanMustIncludeItem():
return $default(_that.name,_that.placeId,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @JsonKey(name: 'place_id', includeIfNull: false)  String? placeId, @JsonKey(includeIfNull: false)  String? type)?  $default,) {final _that = this;
switch (_that) {
case _GeneratePlanMustIncludeItem() when $default != null:
return $default(_that.name,_that.placeId,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GeneratePlanMustIncludeItem implements GeneratePlanMustIncludeItem {
  const _GeneratePlanMustIncludeItem({required this.name, @JsonKey(name: 'place_id', includeIfNull: false) this.placeId, @JsonKey(includeIfNull: false) this.type});
  factory _GeneratePlanMustIncludeItem.fromJson(Map<String, dynamic> json) => _$GeneratePlanMustIncludeItemFromJson(json);

@override final  String name;
@override@JsonKey(name: 'place_id', includeIfNull: false) final  String? placeId;
@override@JsonKey(includeIfNull: false) final  String? type;

/// Create a copy of GeneratePlanMustIncludeItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeneratePlanMustIncludeItemCopyWith<_GeneratePlanMustIncludeItem> get copyWith => __$GeneratePlanMustIncludeItemCopyWithImpl<_GeneratePlanMustIncludeItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GeneratePlanMustIncludeItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeneratePlanMustIncludeItem&&(identical(other.name, name) || other.name == name)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,placeId,type);

@override
String toString() {
  return 'GeneratePlanMustIncludeItem(name: $name, placeId: $placeId, type: $type)';
}


}

/// @nodoc
abstract mixin class _$GeneratePlanMustIncludeItemCopyWith<$Res> implements $GeneratePlanMustIncludeItemCopyWith<$Res> {
  factory _$GeneratePlanMustIncludeItemCopyWith(_GeneratePlanMustIncludeItem value, $Res Function(_GeneratePlanMustIncludeItem) _then) = __$GeneratePlanMustIncludeItemCopyWithImpl;
@override @useResult
$Res call({
 String name,@JsonKey(name: 'place_id', includeIfNull: false) String? placeId,@JsonKey(includeIfNull: false) String? type
});




}
/// @nodoc
class __$GeneratePlanMustIncludeItemCopyWithImpl<$Res>
    implements _$GeneratePlanMustIncludeItemCopyWith<$Res> {
  __$GeneratePlanMustIncludeItemCopyWithImpl(this._self, this._then);

  final _GeneratePlanMustIncludeItem _self;
  final $Res Function(_GeneratePlanMustIncludeItem) _then;

/// Create a copy of GeneratePlanMustIncludeItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? placeId = freezed,Object? type = freezed,}) {
  return _then(_GeneratePlanMustIncludeItem(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$GeneratePlanRequestModel {

 String get city; int get days; int get budget; int get people; List<String> get interests;@JsonKey(name: 'must_include') List<GeneratePlanMustIncludeItem> get mustInclude;
/// Create a copy of GeneratePlanRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeneratePlanRequestModelCopyWith<GeneratePlanRequestModel> get copyWith => _$GeneratePlanRequestModelCopyWithImpl<GeneratePlanRequestModel>(this as GeneratePlanRequestModel, _$identity);

  /// Serializes this GeneratePlanRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeneratePlanRequestModel&&(identical(other.city, city) || other.city == city)&&(identical(other.days, days) || other.days == days)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.people, people) || other.people == people)&&const DeepCollectionEquality().equals(other.interests, interests)&&const DeepCollectionEquality().equals(other.mustInclude, mustInclude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,city,days,budget,people,const DeepCollectionEquality().hash(interests),const DeepCollectionEquality().hash(mustInclude));

@override
String toString() {
  return 'GeneratePlanRequestModel(city: $city, days: $days, budget: $budget, people: $people, interests: $interests, mustInclude: $mustInclude)';
}


}

/// @nodoc
abstract mixin class $GeneratePlanRequestModelCopyWith<$Res>  {
  factory $GeneratePlanRequestModelCopyWith(GeneratePlanRequestModel value, $Res Function(GeneratePlanRequestModel) _then) = _$GeneratePlanRequestModelCopyWithImpl;
@useResult
$Res call({
 String city, int days, int budget, int people, List<String> interests,@JsonKey(name: 'must_include') List<GeneratePlanMustIncludeItem> mustInclude
});




}
/// @nodoc
class _$GeneratePlanRequestModelCopyWithImpl<$Res>
    implements $GeneratePlanRequestModelCopyWith<$Res> {
  _$GeneratePlanRequestModelCopyWithImpl(this._self, this._then);

  final GeneratePlanRequestModel _self;
  final $Res Function(GeneratePlanRequestModel) _then;

/// Create a copy of GeneratePlanRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? city = null,Object? days = null,Object? budget = null,Object? people = null,Object? interests = null,Object? mustInclude = null,}) {
  return _then(_self.copyWith(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as int,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,interests: null == interests ? _self.interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,mustInclude: null == mustInclude ? _self.mustInclude : mustInclude // ignore: cast_nullable_to_non_nullable
as List<GeneratePlanMustIncludeItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [GeneratePlanRequestModel].
extension GeneratePlanRequestModelPatterns on GeneratePlanRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeneratePlanRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeneratePlanRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeneratePlanRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _GeneratePlanRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeneratePlanRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _GeneratePlanRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String city,  int days,  int budget,  int people,  List<String> interests, @JsonKey(name: 'must_include')  List<GeneratePlanMustIncludeItem> mustInclude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeneratePlanRequestModel() when $default != null:
return $default(_that.city,_that.days,_that.budget,_that.people,_that.interests,_that.mustInclude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String city,  int days,  int budget,  int people,  List<String> interests, @JsonKey(name: 'must_include')  List<GeneratePlanMustIncludeItem> mustInclude)  $default,) {final _that = this;
switch (_that) {
case _GeneratePlanRequestModel():
return $default(_that.city,_that.days,_that.budget,_that.people,_that.interests,_that.mustInclude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String city,  int days,  int budget,  int people,  List<String> interests, @JsonKey(name: 'must_include')  List<GeneratePlanMustIncludeItem> mustInclude)?  $default,) {final _that = this;
switch (_that) {
case _GeneratePlanRequestModel() when $default != null:
return $default(_that.city,_that.days,_that.budget,_that.people,_that.interests,_that.mustInclude);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _GeneratePlanRequestModel implements GeneratePlanRequestModel {
  const _GeneratePlanRequestModel({required this.city, required this.days, required this.budget, required this.people, required final  List<String> interests, @JsonKey(name: 'must_include') final  List<GeneratePlanMustIncludeItem> mustInclude = const []}): _interests = interests,_mustInclude = mustInclude;
  factory _GeneratePlanRequestModel.fromJson(Map<String, dynamic> json) => _$GeneratePlanRequestModelFromJson(json);

@override final  String city;
@override final  int days;
@override final  int budget;
@override final  int people;
 final  List<String> _interests;
@override List<String> get interests {
  if (_interests is EqualUnmodifiableListView) return _interests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_interests);
}

 final  List<GeneratePlanMustIncludeItem> _mustInclude;
@override@JsonKey(name: 'must_include') List<GeneratePlanMustIncludeItem> get mustInclude {
  if (_mustInclude is EqualUnmodifiableListView) return _mustInclude;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mustInclude);
}


/// Create a copy of GeneratePlanRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeneratePlanRequestModelCopyWith<_GeneratePlanRequestModel> get copyWith => __$GeneratePlanRequestModelCopyWithImpl<_GeneratePlanRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GeneratePlanRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeneratePlanRequestModel&&(identical(other.city, city) || other.city == city)&&(identical(other.days, days) || other.days == days)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.people, people) || other.people == people)&&const DeepCollectionEquality().equals(other._interests, _interests)&&const DeepCollectionEquality().equals(other._mustInclude, _mustInclude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,city,days,budget,people,const DeepCollectionEquality().hash(_interests),const DeepCollectionEquality().hash(_mustInclude));

@override
String toString() {
  return 'GeneratePlanRequestModel(city: $city, days: $days, budget: $budget, people: $people, interests: $interests, mustInclude: $mustInclude)';
}


}

/// @nodoc
abstract mixin class _$GeneratePlanRequestModelCopyWith<$Res> implements $GeneratePlanRequestModelCopyWith<$Res> {
  factory _$GeneratePlanRequestModelCopyWith(_GeneratePlanRequestModel value, $Res Function(_GeneratePlanRequestModel) _then) = __$GeneratePlanRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String city, int days, int budget, int people, List<String> interests,@JsonKey(name: 'must_include') List<GeneratePlanMustIncludeItem> mustInclude
});




}
/// @nodoc
class __$GeneratePlanRequestModelCopyWithImpl<$Res>
    implements _$GeneratePlanRequestModelCopyWith<$Res> {
  __$GeneratePlanRequestModelCopyWithImpl(this._self, this._then);

  final _GeneratePlanRequestModel _self;
  final $Res Function(_GeneratePlanRequestModel) _then;

/// Create a copy of GeneratePlanRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? city = null,Object? days = null,Object? budget = null,Object? people = null,Object? interests = null,Object? mustInclude = null,}) {
  return _then(_GeneratePlanRequestModel(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as int,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,interests: null == interests ? _self._interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,mustInclude: null == mustInclude ? _self._mustInclude : mustInclude // ignore: cast_nullable_to_non_nullable
as List<GeneratePlanMustIncludeItem>,
  ));
}


}

// dart format on
