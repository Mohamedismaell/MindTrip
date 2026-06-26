// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatResponseModel {

@JsonKey(fromJson: parseString) String get status;@JsonKey(fromJson: parseString) String get output; CollectedDataModel get collected;@JsonKey(fromJson: parseStringList) List<String> get missing;
/// Create a copy of ChatResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatResponseModelCopyWith<ChatResponseModel> get copyWith => _$ChatResponseModelCopyWithImpl<ChatResponseModel>(this as ChatResponseModel, _$identity);

  /// Serializes this ChatResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatResponseModel&&(identical(other.status, status) || other.status == status)&&(identical(other.output, output) || other.output == output)&&(identical(other.collected, collected) || other.collected == collected)&&const DeepCollectionEquality().equals(other.missing, missing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,output,collected,const DeepCollectionEquality().hash(missing));

@override
String toString() {
  return 'ChatResponseModel(status: $status, output: $output, collected: $collected, missing: $missing)';
}


}

/// @nodoc
abstract mixin class $ChatResponseModelCopyWith<$Res>  {
  factory $ChatResponseModelCopyWith(ChatResponseModel value, $Res Function(ChatResponseModel) _then) = _$ChatResponseModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: parseString) String status,@JsonKey(fromJson: parseString) String output, CollectedDataModel collected,@JsonKey(fromJson: parseStringList) List<String> missing
});


$CollectedDataModelCopyWith<$Res> get collected;

}
/// @nodoc
class _$ChatResponseModelCopyWithImpl<$Res>
    implements $ChatResponseModelCopyWith<$Res> {
  _$ChatResponseModelCopyWithImpl(this._self, this._then);

  final ChatResponseModel _self;
  final $Res Function(ChatResponseModel) _then;

/// Create a copy of ChatResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? output = null,Object? collected = null,Object? missing = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,output: null == output ? _self.output : output // ignore: cast_nullable_to_non_nullable
as String,collected: null == collected ? _self.collected : collected // ignore: cast_nullable_to_non_nullable
as CollectedDataModel,missing: null == missing ? _self.missing : missing // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of ChatResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CollectedDataModelCopyWith<$Res> get collected {
  
  return $CollectedDataModelCopyWith<$Res>(_self.collected, (value) {
    return _then(_self.copyWith(collected: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatResponseModel].
extension ChatResponseModelPatterns on ChatResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: parseString)  String status, @JsonKey(fromJson: parseString)  String output,  CollectedDataModel collected, @JsonKey(fromJson: parseStringList)  List<String> missing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatResponseModel() when $default != null:
return $default(_that.status,_that.output,_that.collected,_that.missing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: parseString)  String status, @JsonKey(fromJson: parseString)  String output,  CollectedDataModel collected, @JsonKey(fromJson: parseStringList)  List<String> missing)  $default,) {final _that = this;
switch (_that) {
case _ChatResponseModel():
return $default(_that.status,_that.output,_that.collected,_that.missing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: parseString)  String status, @JsonKey(fromJson: parseString)  String output,  CollectedDataModel collected, @JsonKey(fromJson: parseStringList)  List<String> missing)?  $default,) {final _that = this;
switch (_that) {
case _ChatResponseModel() when $default != null:
return $default(_that.status,_that.output,_that.collected,_that.missing);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatResponseModel implements ChatResponseModel {
  const _ChatResponseModel({@JsonKey(fromJson: parseString) this.status = '', @JsonKey(fromJson: parseString) this.output = '', this.collected = const CollectedDataModel(), @JsonKey(fromJson: parseStringList) final  List<String> missing = const []}): _missing = missing;
  factory _ChatResponseModel.fromJson(Map<String, dynamic> json) => _$ChatResponseModelFromJson(json);

@override@JsonKey(fromJson: parseString) final  String status;
@override@JsonKey(fromJson: parseString) final  String output;
@override@JsonKey() final  CollectedDataModel collected;
 final  List<String> _missing;
@override@JsonKey(fromJson: parseStringList) List<String> get missing {
  if (_missing is EqualUnmodifiableListView) return _missing;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_missing);
}


/// Create a copy of ChatResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatResponseModelCopyWith<_ChatResponseModel> get copyWith => __$ChatResponseModelCopyWithImpl<_ChatResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatResponseModel&&(identical(other.status, status) || other.status == status)&&(identical(other.output, output) || other.output == output)&&(identical(other.collected, collected) || other.collected == collected)&&const DeepCollectionEquality().equals(other._missing, _missing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,output,collected,const DeepCollectionEquality().hash(_missing));

@override
String toString() {
  return 'ChatResponseModel(status: $status, output: $output, collected: $collected, missing: $missing)';
}


}

/// @nodoc
abstract mixin class _$ChatResponseModelCopyWith<$Res> implements $ChatResponseModelCopyWith<$Res> {
  factory _$ChatResponseModelCopyWith(_ChatResponseModel value, $Res Function(_ChatResponseModel) _then) = __$ChatResponseModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: parseString) String status,@JsonKey(fromJson: parseString) String output, CollectedDataModel collected,@JsonKey(fromJson: parseStringList) List<String> missing
});


@override $CollectedDataModelCopyWith<$Res> get collected;

}
/// @nodoc
class __$ChatResponseModelCopyWithImpl<$Res>
    implements _$ChatResponseModelCopyWith<$Res> {
  __$ChatResponseModelCopyWithImpl(this._self, this._then);

  final _ChatResponseModel _self;
  final $Res Function(_ChatResponseModel) _then;

/// Create a copy of ChatResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? output = null,Object? collected = null,Object? missing = null,}) {
  return _then(_ChatResponseModel(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,output: null == output ? _self.output : output // ignore: cast_nullable_to_non_nullable
as String,collected: null == collected ? _self.collected : collected // ignore: cast_nullable_to_non_nullable
as CollectedDataModel,missing: null == missing ? _self._missing : missing // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of ChatResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CollectedDataModelCopyWith<$Res> get collected {
  
  return $CollectedDataModelCopyWith<$Res>(_self.collected, (value) {
    return _then(_self.copyWith(collected: value));
  });
}
}

// dart format on
