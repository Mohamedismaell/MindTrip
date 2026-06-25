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
mixin _$GeneratePlanRequestModel {

 String get city; int get days; int get budget; int get people; List<String> get interests; String? get mustInclude;
/// Create a copy of GeneratePlanRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeneratePlanRequestModelCopyWith<GeneratePlanRequestModel> get copyWith => _$GeneratePlanRequestModelCopyWithImpl<GeneratePlanRequestModel>(this as GeneratePlanRequestModel, _$identity);

  /// Serializes this GeneratePlanRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeneratePlanRequestModel&&(identical(other.city, city) || other.city == city)&&(identical(other.days, days) || other.days == days)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.people, people) || other.people == people)&&const DeepCollectionEquality().equals(other.interests, interests)&&(identical(other.mustInclude, mustInclude) || other.mustInclude == mustInclude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,city,days,budget,people,const DeepCollectionEquality().hash(interests),mustInclude);

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
 String city, int days, int budget, int people, List<String> interests, String? mustInclude
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
@pragma('vm:prefer-inline') @override $Res call({Object? city = null,Object? days = null,Object? budget = null,Object? people = null,Object? interests = null,Object? mustInclude = freezed,}) {
  return _then(_self.copyWith(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as int,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,interests: null == interests ? _self.interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,mustInclude: freezed == mustInclude ? _self.mustInclude : mustInclude // ignore: cast_nullable_to_non_nullable
as String?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String city,  int days,  int budget,  int people,  List<String> interests,  String? mustInclude)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String city,  int days,  int budget,  int people,  List<String> interests,  String? mustInclude)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String city,  int days,  int budget,  int people,  List<String> interests,  String? mustInclude)?  $default,) {final _that = this;
switch (_that) {
case _GeneratePlanRequestModel() when $default != null:
return $default(_that.city,_that.days,_that.budget,_that.people,_that.interests,_that.mustInclude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GeneratePlanRequestModel implements GeneratePlanRequestModel {
  const _GeneratePlanRequestModel({required this.city, required this.days, required this.budget, required this.people, required final  List<String> interests, this.mustInclude}): _interests = interests;
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

@override final  String? mustInclude;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeneratePlanRequestModel&&(identical(other.city, city) || other.city == city)&&(identical(other.days, days) || other.days == days)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.people, people) || other.people == people)&&const DeepCollectionEquality().equals(other._interests, _interests)&&(identical(other.mustInclude, mustInclude) || other.mustInclude == mustInclude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,city,days,budget,people,const DeepCollectionEquality().hash(_interests),mustInclude);

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
 String city, int days, int budget, int people, List<String> interests, String? mustInclude
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
@override @pragma('vm:prefer-inline') $Res call({Object? city = null,Object? days = null,Object? budget = null,Object? people = null,Object? interests = null,Object? mustInclude = freezed,}) {
  return _then(_GeneratePlanRequestModel(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as int,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,interests: null == interests ? _self._interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,mustInclude: freezed == mustInclude ? _self.mustInclude : mustInclude // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
