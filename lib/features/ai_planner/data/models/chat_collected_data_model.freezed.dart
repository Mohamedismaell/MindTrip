// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_collected_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatCollectedDataModel {

@JsonKey(fromJson: parseString) String get destination;@JsonKey(fromJson: parseInt) int get days;@JsonKey(fromJson: parseInt) int get budget;@JsonKey(fromJson: parseStringList) List<String> get interests;@JsonKey(fromJson: parseInt) int get people;@JsonKey(name: 'mustInclude', readValue: ChatCollectedDataModel._readMustInclude, fromJson: ChatCollectedDataModel._parseMustInclude) List<String> get mustInclude;
/// Create a copy of ChatCollectedDataModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatCollectedDataModelCopyWith<ChatCollectedDataModel> get copyWith => _$ChatCollectedDataModelCopyWithImpl<ChatCollectedDataModel>(this as ChatCollectedDataModel, _$identity);

  /// Serializes this ChatCollectedDataModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatCollectedDataModel&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.days, days) || other.days == days)&&(identical(other.budget, budget) || other.budget == budget)&&const DeepCollectionEquality().equals(other.interests, interests)&&(identical(other.people, people) || other.people == people)&&const DeepCollectionEquality().equals(other.mustInclude, mustInclude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,destination,days,budget,const DeepCollectionEquality().hash(interests),people,const DeepCollectionEquality().hash(mustInclude));

@override
String toString() {
  return 'ChatCollectedDataModel(destination: $destination, days: $days, budget: $budget, interests: $interests, people: $people, mustInclude: $mustInclude)';
}


}

/// @nodoc
abstract mixin class $ChatCollectedDataModelCopyWith<$Res>  {
  factory $ChatCollectedDataModelCopyWith(ChatCollectedDataModel value, $Res Function(ChatCollectedDataModel) _then) = _$ChatCollectedDataModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: parseString) String destination,@JsonKey(fromJson: parseInt) int days,@JsonKey(fromJson: parseInt) int budget,@JsonKey(fromJson: parseStringList) List<String> interests,@JsonKey(fromJson: parseInt) int people,@JsonKey(name: 'mustInclude', readValue: ChatCollectedDataModel._readMustInclude, fromJson: ChatCollectedDataModel._parseMustInclude) List<String> mustInclude
});




}
/// @nodoc
class _$ChatCollectedDataModelCopyWithImpl<$Res>
    implements $ChatCollectedDataModelCopyWith<$Res> {
  _$ChatCollectedDataModelCopyWithImpl(this._self, this._then);

  final ChatCollectedDataModel _self;
  final $Res Function(ChatCollectedDataModel) _then;

/// Create a copy of ChatCollectedDataModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? destination = null,Object? days = null,Object? budget = null,Object? interests = null,Object? people = null,Object? mustInclude = null,}) {
  return _then(_self.copyWith(
destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as int,interests: null == interests ? _self.interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,mustInclude: null == mustInclude ? _self.mustInclude : mustInclude // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatCollectedDataModel].
extension ChatCollectedDataModelPatterns on ChatCollectedDataModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatCollectedDataModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatCollectedDataModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatCollectedDataModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatCollectedDataModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatCollectedDataModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatCollectedDataModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: parseString)  String destination, @JsonKey(fromJson: parseInt)  int days, @JsonKey(fromJson: parseInt)  int budget, @JsonKey(fromJson: parseStringList)  List<String> interests, @JsonKey(fromJson: parseInt)  int people, @JsonKey(name: 'mustInclude', readValue: ChatCollectedDataModel._readMustInclude, fromJson: ChatCollectedDataModel._parseMustInclude)  List<String> mustInclude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatCollectedDataModel() when $default != null:
return $default(_that.destination,_that.days,_that.budget,_that.interests,_that.people,_that.mustInclude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: parseString)  String destination, @JsonKey(fromJson: parseInt)  int days, @JsonKey(fromJson: parseInt)  int budget, @JsonKey(fromJson: parseStringList)  List<String> interests, @JsonKey(fromJson: parseInt)  int people, @JsonKey(name: 'mustInclude', readValue: ChatCollectedDataModel._readMustInclude, fromJson: ChatCollectedDataModel._parseMustInclude)  List<String> mustInclude)  $default,) {final _that = this;
switch (_that) {
case _ChatCollectedDataModel():
return $default(_that.destination,_that.days,_that.budget,_that.interests,_that.people,_that.mustInclude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: parseString)  String destination, @JsonKey(fromJson: parseInt)  int days, @JsonKey(fromJson: parseInt)  int budget, @JsonKey(fromJson: parseStringList)  List<String> interests, @JsonKey(fromJson: parseInt)  int people, @JsonKey(name: 'mustInclude', readValue: ChatCollectedDataModel._readMustInclude, fromJson: ChatCollectedDataModel._parseMustInclude)  List<String> mustInclude)?  $default,) {final _that = this;
switch (_that) {
case _ChatCollectedDataModel() when $default != null:
return $default(_that.destination,_that.days,_that.budget,_that.interests,_that.people,_that.mustInclude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatCollectedDataModel implements ChatCollectedDataModel {
  const _ChatCollectedDataModel({@JsonKey(fromJson: parseString) this.destination = '', @JsonKey(fromJson: parseInt) this.days = 0, @JsonKey(fromJson: parseInt) this.budget = 0, @JsonKey(fromJson: parseStringList) final  List<String> interests = const [], @JsonKey(fromJson: parseInt) this.people = 0, @JsonKey(name: 'mustInclude', readValue: ChatCollectedDataModel._readMustInclude, fromJson: ChatCollectedDataModel._parseMustInclude) final  List<String> mustInclude = const []}): _interests = interests,_mustInclude = mustInclude;
  factory _ChatCollectedDataModel.fromJson(Map<String, dynamic> json) => _$ChatCollectedDataModelFromJson(json);

@override@JsonKey(fromJson: parseString) final  String destination;
@override@JsonKey(fromJson: parseInt) final  int days;
@override@JsonKey(fromJson: parseInt) final  int budget;
 final  List<String> _interests;
@override@JsonKey(fromJson: parseStringList) List<String> get interests {
  if (_interests is EqualUnmodifiableListView) return _interests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_interests);
}

@override@JsonKey(fromJson: parseInt) final  int people;
 final  List<String> _mustInclude;
@override@JsonKey(name: 'mustInclude', readValue: ChatCollectedDataModel._readMustInclude, fromJson: ChatCollectedDataModel._parseMustInclude) List<String> get mustInclude {
  if (_mustInclude is EqualUnmodifiableListView) return _mustInclude;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mustInclude);
}


/// Create a copy of ChatCollectedDataModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatCollectedDataModelCopyWith<_ChatCollectedDataModel> get copyWith => __$ChatCollectedDataModelCopyWithImpl<_ChatCollectedDataModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatCollectedDataModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatCollectedDataModel&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.days, days) || other.days == days)&&(identical(other.budget, budget) || other.budget == budget)&&const DeepCollectionEquality().equals(other._interests, _interests)&&(identical(other.people, people) || other.people == people)&&const DeepCollectionEquality().equals(other._mustInclude, _mustInclude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,destination,days,budget,const DeepCollectionEquality().hash(_interests),people,const DeepCollectionEquality().hash(_mustInclude));

@override
String toString() {
  return 'ChatCollectedDataModel(destination: $destination, days: $days, budget: $budget, interests: $interests, people: $people, mustInclude: $mustInclude)';
}


}

/// @nodoc
abstract mixin class _$ChatCollectedDataModelCopyWith<$Res> implements $ChatCollectedDataModelCopyWith<$Res> {
  factory _$ChatCollectedDataModelCopyWith(_ChatCollectedDataModel value, $Res Function(_ChatCollectedDataModel) _then) = __$ChatCollectedDataModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: parseString) String destination,@JsonKey(fromJson: parseInt) int days,@JsonKey(fromJson: parseInt) int budget,@JsonKey(fromJson: parseStringList) List<String> interests,@JsonKey(fromJson: parseInt) int people,@JsonKey(name: 'mustInclude', readValue: ChatCollectedDataModel._readMustInclude, fromJson: ChatCollectedDataModel._parseMustInclude) List<String> mustInclude
});




}
/// @nodoc
class __$ChatCollectedDataModelCopyWithImpl<$Res>
    implements _$ChatCollectedDataModelCopyWith<$Res> {
  __$ChatCollectedDataModelCopyWithImpl(this._self, this._then);

  final _ChatCollectedDataModel _self;
  final $Res Function(_ChatCollectedDataModel) _then;

/// Create a copy of ChatCollectedDataModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? destination = null,Object? days = null,Object? budget = null,Object? interests = null,Object? people = null,Object? mustInclude = null,}) {
  return _then(_ChatCollectedDataModel(
destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as int,interests: null == interests ? _self._interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,mustInclude: null == mustInclude ? _self._mustInclude : mustInclude // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
