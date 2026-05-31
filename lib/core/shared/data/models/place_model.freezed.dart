// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlaceModel {

@HiveField(0) String get id;@HiveField(1) String get name;@HiveField(2) String? get description;@HiveField(3) LocationModel get location;@HiveField(4) List<String>? get coverImage;@HiveField(5) List<String>? get imageUrls;@HiveField(6) PlaceCategory get category;@HiveField(7) double? get rating;@HiveField(8) int? get reviewCount;@HiveField(9) double? get price;@HiveField(10) bool get isFavorite;@HiveField(11) PlaceBadge get badge;
/// Create a copy of PlaceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceModelCopyWith<PlaceModel> get copyWith => _$PlaceModelCopyWithImpl<PlaceModel>(this as PlaceModel, _$identity);

  /// Serializes this PlaceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other.coverImage, coverImage)&&const DeepCollectionEquality().equals(other.imageUrls, imageUrls)&&(identical(other.category, category) || other.category == category)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.price, price) || other.price == price)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.badge, badge) || other.badge == badge));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,location,const DeepCollectionEquality().hash(coverImage),const DeepCollectionEquality().hash(imageUrls),category,rating,reviewCount,price,isFavorite,badge);

@override
String toString() {
  return 'PlaceModel(id: $id, name: $name, description: $description, location: $location, coverImage: $coverImage, imageUrls: $imageUrls, category: $category, rating: $rating, reviewCount: $reviewCount, price: $price, isFavorite: $isFavorite, badge: $badge)';
}


}

/// @nodoc
abstract mixin class $PlaceModelCopyWith<$Res>  {
  factory $PlaceModelCopyWith(PlaceModel value, $Res Function(PlaceModel) _then) = _$PlaceModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String name,@HiveField(2) String? description,@HiveField(3) LocationModel location,@HiveField(4) List<String>? coverImage,@HiveField(5) List<String>? imageUrls,@HiveField(6) PlaceCategory category,@HiveField(7) double? rating,@HiveField(8) int? reviewCount,@HiveField(9) double? price,@HiveField(10) bool isFavorite,@HiveField(11) PlaceBadge badge
});


$LocationModelCopyWith<$Res> get location;

}
/// @nodoc
class _$PlaceModelCopyWithImpl<$Res>
    implements $PlaceModelCopyWith<$Res> {
  _$PlaceModelCopyWithImpl(this._self, this._then);

  final PlaceModel _self;
  final $Res Function(PlaceModel) _then;

/// Create a copy of PlaceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? location = null,Object? coverImage = freezed,Object? imageUrls = freezed,Object? category = null,Object? rating = freezed,Object? reviewCount = freezed,Object? price = freezed,Object? isFavorite = null,Object? badge = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocationModel,coverImage: freezed == coverImage ? _self.coverImage : coverImage // ignore: cast_nullable_to_non_nullable
as List<String>?,imageUrls: freezed == imageUrls ? _self.imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as PlaceCategory,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,reviewCount: freezed == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,badge: null == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as PlaceBadge,
  ));
}
/// Create a copy of PlaceModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationModelCopyWith<$Res> get location {
  
  return $LocationModelCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlaceModel].
extension PlaceModelPatterns on PlaceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceModel value)  $default,){
final _that = this;
switch (_that) {
case _PlaceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceModel value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String name, @HiveField(2)  String? description, @HiveField(3)  LocationModel location, @HiveField(4)  List<String>? coverImage, @HiveField(5)  List<String>? imageUrls, @HiveField(6)  PlaceCategory category, @HiveField(7)  double? rating, @HiveField(8)  int? reviewCount, @HiveField(9)  double? price, @HiveField(10)  bool isFavorite, @HiveField(11)  PlaceBadge badge)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.location,_that.coverImage,_that.imageUrls,_that.category,_that.rating,_that.reviewCount,_that.price,_that.isFavorite,_that.badge);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String name, @HiveField(2)  String? description, @HiveField(3)  LocationModel location, @HiveField(4)  List<String>? coverImage, @HiveField(5)  List<String>? imageUrls, @HiveField(6)  PlaceCategory category, @HiveField(7)  double? rating, @HiveField(8)  int? reviewCount, @HiveField(9)  double? price, @HiveField(10)  bool isFavorite, @HiveField(11)  PlaceBadge badge)  $default,) {final _that = this;
switch (_that) {
case _PlaceModel():
return $default(_that.id,_that.name,_that.description,_that.location,_that.coverImage,_that.imageUrls,_that.category,_that.rating,_that.reviewCount,_that.price,_that.isFavorite,_that.badge);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String id, @HiveField(1)  String name, @HiveField(2)  String? description, @HiveField(3)  LocationModel location, @HiveField(4)  List<String>? coverImage, @HiveField(5)  List<String>? imageUrls, @HiveField(6)  PlaceCategory category, @HiveField(7)  double? rating, @HiveField(8)  int? reviewCount, @HiveField(9)  double? price, @HiveField(10)  bool isFavorite, @HiveField(11)  PlaceBadge badge)?  $default,) {final _that = this;
switch (_that) {
case _PlaceModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.location,_that.coverImage,_that.imageUrls,_that.category,_that.rating,_that.reviewCount,_that.price,_that.isFavorite,_that.badge);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 1, adapterName: 'PlaceModelAdapter')
class _PlaceModel extends PlaceModel {
  const _PlaceModel({@HiveField(0) this.id = '', @HiveField(1) this.name = '', @HiveField(2) this.description, @HiveField(3) required this.location, @HiveField(4) final  List<String>? coverImage, @HiveField(5) final  List<String>? imageUrls, @HiveField(6) this.category = PlaceCategory.other, @HiveField(7) this.rating, @HiveField(8) this.reviewCount, @HiveField(9) this.price, @HiveField(10) this.isFavorite = false, @HiveField(11) this.badge = PlaceBadge.none}): _coverImage = coverImage,_imageUrls = imageUrls,super._();
  factory _PlaceModel.fromJson(Map<String, dynamic> json) => _$PlaceModelFromJson(json);

@override@JsonKey()@HiveField(0) final  String id;
@override@JsonKey()@HiveField(1) final  String name;
@override@HiveField(2) final  String? description;
@override@HiveField(3) final  LocationModel location;
 final  List<String>? _coverImage;
@override@HiveField(4) List<String>? get coverImage {
  final value = _coverImage;
  if (value == null) return null;
  if (_coverImage is EqualUnmodifiableListView) return _coverImage;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _imageUrls;
@override@HiveField(5) List<String>? get imageUrls {
  final value = _imageUrls;
  if (value == null) return null;
  if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey()@HiveField(6) final  PlaceCategory category;
@override@HiveField(7) final  double? rating;
@override@HiveField(8) final  int? reviewCount;
@override@HiveField(9) final  double? price;
@override@JsonKey()@HiveField(10) final  bool isFavorite;
@override@JsonKey()@HiveField(11) final  PlaceBadge badge;

/// Create a copy of PlaceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceModelCopyWith<_PlaceModel> get copyWith => __$PlaceModelCopyWithImpl<_PlaceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other._coverImage, _coverImage)&&const DeepCollectionEquality().equals(other._imageUrls, _imageUrls)&&(identical(other.category, category) || other.category == category)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.price, price) || other.price == price)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.badge, badge) || other.badge == badge));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,location,const DeepCollectionEquality().hash(_coverImage),const DeepCollectionEquality().hash(_imageUrls),category,rating,reviewCount,price,isFavorite,badge);

@override
String toString() {
  return 'PlaceModel(id: $id, name: $name, description: $description, location: $location, coverImage: $coverImage, imageUrls: $imageUrls, category: $category, rating: $rating, reviewCount: $reviewCount, price: $price, isFavorite: $isFavorite, badge: $badge)';
}


}

/// @nodoc
abstract mixin class _$PlaceModelCopyWith<$Res> implements $PlaceModelCopyWith<$Res> {
  factory _$PlaceModelCopyWith(_PlaceModel value, $Res Function(_PlaceModel) _then) = __$PlaceModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String name,@HiveField(2) String? description,@HiveField(3) LocationModel location,@HiveField(4) List<String>? coverImage,@HiveField(5) List<String>? imageUrls,@HiveField(6) PlaceCategory category,@HiveField(7) double? rating,@HiveField(8) int? reviewCount,@HiveField(9) double? price,@HiveField(10) bool isFavorite,@HiveField(11) PlaceBadge badge
});


@override $LocationModelCopyWith<$Res> get location;

}
/// @nodoc
class __$PlaceModelCopyWithImpl<$Res>
    implements _$PlaceModelCopyWith<$Res> {
  __$PlaceModelCopyWithImpl(this._self, this._then);

  final _PlaceModel _self;
  final $Res Function(_PlaceModel) _then;

/// Create a copy of PlaceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? location = null,Object? coverImage = freezed,Object? imageUrls = freezed,Object? category = null,Object? rating = freezed,Object? reviewCount = freezed,Object? price = freezed,Object? isFavorite = null,Object? badge = null,}) {
  return _then(_PlaceModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocationModel,coverImage: freezed == coverImage ? _self._coverImage : coverImage // ignore: cast_nullable_to_non_nullable
as List<String>?,imageUrls: freezed == imageUrls ? _self._imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as PlaceCategory,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,reviewCount: freezed == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,badge: null == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as PlaceBadge,
  ));
}

/// Create a copy of PlaceModel
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
