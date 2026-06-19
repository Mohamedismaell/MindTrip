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

@HiveField(0)@JsonKey(name: 'place_id') String get placeId;@HiveField(1) String get name;@HiveField(2) String? get city;@HiveField(3)@JsonKey(name: 'city_en') String? get cityEn;@HiveField(4)@JsonKey(fromJson: _toListOfStrings) List<String>? get interests;@HiveField(5) String? get category;/// Price per person
@HiveField(6)@JsonKey(fromJson: _toDouble) double? get price;/// Total estimated cost
@HiveField(7)@JsonKey(fromJson: _toDouble) double? get cost;@HiveField(8)@JsonKey(fromJson: _toDouble) double? get rating;@HiveField(9)@JsonKey(name: 'reviews_count') int? get reviewsCount;@HiveField(10) String? get address;@HiveField(11) String? get description;@HiveField(12)@JsonKey(name: 'photo_url') String? get photoUrl;@HiveField(13)@JsonKey(name: 'image_urls', fromJson: _toListOfStrings) List<String>? get imageUrls;@HiveField(14)@JsonKey(name: 'opening_hours') String? get openingHours;@HiveField(15)@JsonKey(fromJson: _toDoubleNonNullable) double get lat;@HiveField(16)@JsonKey(fromJson: _toDoubleNonNullable) double get lng;@HiveField(17)@JsonKey(name: 'is_hidden_gem') bool get isHiddenGem;@HiveField(18)@JsonKey(name: 'maps_url') String? get mapsUrl;// New fields from sample
@HiveField(19) String? get day;@HiveField(20)@JsonKey(name: 'is_opened') String? get isOpened;@HiveField(21) String? get type;
/// Create a copy of PlaceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceModelCopyWith<PlaceModel> get copyWith => _$PlaceModelCopyWithImpl<PlaceModel>(this as PlaceModel, _$identity);

  /// Serializes this PlaceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceModel&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.name, name) || other.name == name)&&(identical(other.city, city) || other.city == city)&&(identical(other.cityEn, cityEn) || other.cityEn == cityEn)&&const DeepCollectionEquality().equals(other.interests, interests)&&(identical(other.category, category) || other.category == category)&&(identical(other.price, price) || other.price == price)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewsCount, reviewsCount) || other.reviewsCount == reviewsCount)&&(identical(other.address, address) || other.address == address)&&(identical(other.description, description) || other.description == description)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&const DeepCollectionEquality().equals(other.imageUrls, imageUrls)&&(identical(other.openingHours, openingHours) || other.openingHours == openingHours)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.isHiddenGem, isHiddenGem) || other.isHiddenGem == isHiddenGem)&&(identical(other.mapsUrl, mapsUrl) || other.mapsUrl == mapsUrl)&&(identical(other.day, day) || other.day == day)&&(identical(other.isOpened, isOpened) || other.isOpened == isOpened)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,placeId,name,city,cityEn,const DeepCollectionEquality().hash(interests),category,price,cost,rating,reviewsCount,address,description,photoUrl,const DeepCollectionEquality().hash(imageUrls),openingHours,lat,lng,isHiddenGem,mapsUrl,day,isOpened,type]);

@override
String toString() {
  return 'PlaceModel(placeId: $placeId, name: $name, city: $city, cityEn: $cityEn, interests: $interests, category: $category, price: $price, cost: $cost, rating: $rating, reviewsCount: $reviewsCount, address: $address, description: $description, photoUrl: $photoUrl, imageUrls: $imageUrls, openingHours: $openingHours, lat: $lat, lng: $lng, isHiddenGem: $isHiddenGem, mapsUrl: $mapsUrl, day: $day, isOpened: $isOpened, type: $type)';
}


}

/// @nodoc
abstract mixin class $PlaceModelCopyWith<$Res>  {
  factory $PlaceModelCopyWith(PlaceModel value, $Res Function(PlaceModel) _then) = _$PlaceModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0)@JsonKey(name: 'place_id') String placeId,@HiveField(1) String name,@HiveField(2) String? city,@HiveField(3)@JsonKey(name: 'city_en') String? cityEn,@HiveField(4)@JsonKey(fromJson: _toListOfStrings) List<String>? interests,@HiveField(5) String? category,@HiveField(6)@JsonKey(fromJson: _toDouble) double? price,@HiveField(7)@JsonKey(fromJson: _toDouble) double? cost,@HiveField(8)@JsonKey(fromJson: _toDouble) double? rating,@HiveField(9)@JsonKey(name: 'reviews_count') int? reviewsCount,@HiveField(10) String? address,@HiveField(11) String? description,@HiveField(12)@JsonKey(name: 'photo_url') String? photoUrl,@HiveField(13)@JsonKey(name: 'image_urls', fromJson: _toListOfStrings) List<String>? imageUrls,@HiveField(14)@JsonKey(name: 'opening_hours') String? openingHours,@HiveField(15)@JsonKey(fromJson: _toDoubleNonNullable) double lat,@HiveField(16)@JsonKey(fromJson: _toDoubleNonNullable) double lng,@HiveField(17)@JsonKey(name: 'is_hidden_gem') bool isHiddenGem,@HiveField(18)@JsonKey(name: 'maps_url') String? mapsUrl,@HiveField(19) String? day,@HiveField(20)@JsonKey(name: 'is_opened') String? isOpened,@HiveField(21) String? type
});




}
/// @nodoc
class _$PlaceModelCopyWithImpl<$Res>
    implements $PlaceModelCopyWith<$Res> {
  _$PlaceModelCopyWithImpl(this._self, this._then);

  final PlaceModel _self;
  final $Res Function(PlaceModel) _then;

/// Create a copy of PlaceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? placeId = null,Object? name = null,Object? city = freezed,Object? cityEn = freezed,Object? interests = freezed,Object? category = freezed,Object? price = freezed,Object? cost = freezed,Object? rating = freezed,Object? reviewsCount = freezed,Object? address = freezed,Object? description = freezed,Object? photoUrl = freezed,Object? imageUrls = freezed,Object? openingHours = freezed,Object? lat = null,Object? lng = null,Object? isHiddenGem = null,Object? mapsUrl = freezed,Object? day = freezed,Object? isOpened = freezed,Object? type = freezed,}) {
  return _then(_self.copyWith(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,cityEn: freezed == cityEn ? _self.cityEn : cityEn // ignore: cast_nullable_to_non_nullable
as String?,interests: freezed == interests ? _self.interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,cost: freezed == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,reviewsCount: freezed == reviewsCount ? _self.reviewsCount : reviewsCount // ignore: cast_nullable_to_non_nullable
as int?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,imageUrls: freezed == imageUrls ? _self.imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>?,openingHours: freezed == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as String?,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,isHiddenGem: null == isHiddenGem ? _self.isHiddenGem : isHiddenGem // ignore: cast_nullable_to_non_nullable
as bool,mapsUrl: freezed == mapsUrl ? _self.mapsUrl : mapsUrl // ignore: cast_nullable_to_non_nullable
as String?,day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String?,isOpened: freezed == isOpened ? _self.isOpened : isOpened // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)@JsonKey(name: 'place_id')  String placeId, @HiveField(1)  String name, @HiveField(2)  String? city, @HiveField(3)@JsonKey(name: 'city_en')  String? cityEn, @HiveField(4)@JsonKey(fromJson: _toListOfStrings)  List<String>? interests, @HiveField(5)  String? category, @HiveField(6)@JsonKey(fromJson: _toDouble)  double? price, @HiveField(7)@JsonKey(fromJson: _toDouble)  double? cost, @HiveField(8)@JsonKey(fromJson: _toDouble)  double? rating, @HiveField(9)@JsonKey(name: 'reviews_count')  int? reviewsCount, @HiveField(10)  String? address, @HiveField(11)  String? description, @HiveField(12)@JsonKey(name: 'photo_url')  String? photoUrl, @HiveField(13)@JsonKey(name: 'image_urls', fromJson: _toListOfStrings)  List<String>? imageUrls, @HiveField(14)@JsonKey(name: 'opening_hours')  String? openingHours, @HiveField(15)@JsonKey(fromJson: _toDoubleNonNullable)  double lat, @HiveField(16)@JsonKey(fromJson: _toDoubleNonNullable)  double lng, @HiveField(17)@JsonKey(name: 'is_hidden_gem')  bool isHiddenGem, @HiveField(18)@JsonKey(name: 'maps_url')  String? mapsUrl, @HiveField(19)  String? day, @HiveField(20)@JsonKey(name: 'is_opened')  String? isOpened, @HiveField(21)  String? type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceModel() when $default != null:
return $default(_that.placeId,_that.name,_that.city,_that.cityEn,_that.interests,_that.category,_that.price,_that.cost,_that.rating,_that.reviewsCount,_that.address,_that.description,_that.photoUrl,_that.imageUrls,_that.openingHours,_that.lat,_that.lng,_that.isHiddenGem,_that.mapsUrl,_that.day,_that.isOpened,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)@JsonKey(name: 'place_id')  String placeId, @HiveField(1)  String name, @HiveField(2)  String? city, @HiveField(3)@JsonKey(name: 'city_en')  String? cityEn, @HiveField(4)@JsonKey(fromJson: _toListOfStrings)  List<String>? interests, @HiveField(5)  String? category, @HiveField(6)@JsonKey(fromJson: _toDouble)  double? price, @HiveField(7)@JsonKey(fromJson: _toDouble)  double? cost, @HiveField(8)@JsonKey(fromJson: _toDouble)  double? rating, @HiveField(9)@JsonKey(name: 'reviews_count')  int? reviewsCount, @HiveField(10)  String? address, @HiveField(11)  String? description, @HiveField(12)@JsonKey(name: 'photo_url')  String? photoUrl, @HiveField(13)@JsonKey(name: 'image_urls', fromJson: _toListOfStrings)  List<String>? imageUrls, @HiveField(14)@JsonKey(name: 'opening_hours')  String? openingHours, @HiveField(15)@JsonKey(fromJson: _toDoubleNonNullable)  double lat, @HiveField(16)@JsonKey(fromJson: _toDoubleNonNullable)  double lng, @HiveField(17)@JsonKey(name: 'is_hidden_gem')  bool isHiddenGem, @HiveField(18)@JsonKey(name: 'maps_url')  String? mapsUrl, @HiveField(19)  String? day, @HiveField(20)@JsonKey(name: 'is_opened')  String? isOpened, @HiveField(21)  String? type)  $default,) {final _that = this;
switch (_that) {
case _PlaceModel():
return $default(_that.placeId,_that.name,_that.city,_that.cityEn,_that.interests,_that.category,_that.price,_that.cost,_that.rating,_that.reviewsCount,_that.address,_that.description,_that.photoUrl,_that.imageUrls,_that.openingHours,_that.lat,_that.lng,_that.isHiddenGem,_that.mapsUrl,_that.day,_that.isOpened,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)@JsonKey(name: 'place_id')  String placeId, @HiveField(1)  String name, @HiveField(2)  String? city, @HiveField(3)@JsonKey(name: 'city_en')  String? cityEn, @HiveField(4)@JsonKey(fromJson: _toListOfStrings)  List<String>? interests, @HiveField(5)  String? category, @HiveField(6)@JsonKey(fromJson: _toDouble)  double? price, @HiveField(7)@JsonKey(fromJson: _toDouble)  double? cost, @HiveField(8)@JsonKey(fromJson: _toDouble)  double? rating, @HiveField(9)@JsonKey(name: 'reviews_count')  int? reviewsCount, @HiveField(10)  String? address, @HiveField(11)  String? description, @HiveField(12)@JsonKey(name: 'photo_url')  String? photoUrl, @HiveField(13)@JsonKey(name: 'image_urls', fromJson: _toListOfStrings)  List<String>? imageUrls, @HiveField(14)@JsonKey(name: 'opening_hours')  String? openingHours, @HiveField(15)@JsonKey(fromJson: _toDoubleNonNullable)  double lat, @HiveField(16)@JsonKey(fromJson: _toDoubleNonNullable)  double lng, @HiveField(17)@JsonKey(name: 'is_hidden_gem')  bool isHiddenGem, @HiveField(18)@JsonKey(name: 'maps_url')  String? mapsUrl, @HiveField(19)  String? day, @HiveField(20)@JsonKey(name: 'is_opened')  String? isOpened, @HiveField(21)  String? type)?  $default,) {final _that = this;
switch (_that) {
case _PlaceModel() when $default != null:
return $default(_that.placeId,_that.name,_that.city,_that.cityEn,_that.interests,_that.category,_that.price,_that.cost,_that.rating,_that.reviewsCount,_that.address,_that.description,_that.photoUrl,_that.imageUrls,_that.openingHours,_that.lat,_that.lng,_that.isHiddenGem,_that.mapsUrl,_that.day,_that.isOpened,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceModel extends PlaceModel {
  const _PlaceModel({@HiveField(0)@JsonKey(name: 'place_id') required this.placeId, @HiveField(1) required this.name, @HiveField(2) this.city, @HiveField(3)@JsonKey(name: 'city_en') this.cityEn, @HiveField(4)@JsonKey(fromJson: _toListOfStrings) final  List<String>? interests, @HiveField(5) this.category, @HiveField(6)@JsonKey(fromJson: _toDouble) this.price, @HiveField(7)@JsonKey(fromJson: _toDouble) this.cost, @HiveField(8)@JsonKey(fromJson: _toDouble) this.rating, @HiveField(9)@JsonKey(name: 'reviews_count') this.reviewsCount, @HiveField(10) this.address, @HiveField(11) this.description, @HiveField(12)@JsonKey(name: 'photo_url') this.photoUrl, @HiveField(13)@JsonKey(name: 'image_urls', fromJson: _toListOfStrings) final  List<String>? imageUrls, @HiveField(14)@JsonKey(name: 'opening_hours') this.openingHours, @HiveField(15)@JsonKey(fromJson: _toDoubleNonNullable) this.lat = 0.0, @HiveField(16)@JsonKey(fromJson: _toDoubleNonNullable) this.lng = 0.0, @HiveField(17)@JsonKey(name: 'is_hidden_gem') this.isHiddenGem = false, @HiveField(18)@JsonKey(name: 'maps_url') this.mapsUrl, @HiveField(19) this.day, @HiveField(20)@JsonKey(name: 'is_opened') this.isOpened, @HiveField(21) this.type}): _interests = interests,_imageUrls = imageUrls,super._();
  factory _PlaceModel.fromJson(Map<String, dynamic> json) => _$PlaceModelFromJson(json);

@override@HiveField(0)@JsonKey(name: 'place_id') final  String placeId;
@override@HiveField(1) final  String name;
@override@HiveField(2) final  String? city;
@override@HiveField(3)@JsonKey(name: 'city_en') final  String? cityEn;
 final  List<String>? _interests;
@override@HiveField(4)@JsonKey(fromJson: _toListOfStrings) List<String>? get interests {
  final value = _interests;
  if (value == null) return null;
  if (_interests is EqualUnmodifiableListView) return _interests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@HiveField(5) final  String? category;
/// Price per person
@override@HiveField(6)@JsonKey(fromJson: _toDouble) final  double? price;
/// Total estimated cost
@override@HiveField(7)@JsonKey(fromJson: _toDouble) final  double? cost;
@override@HiveField(8)@JsonKey(fromJson: _toDouble) final  double? rating;
@override@HiveField(9)@JsonKey(name: 'reviews_count') final  int? reviewsCount;
@override@HiveField(10) final  String? address;
@override@HiveField(11) final  String? description;
@override@HiveField(12)@JsonKey(name: 'photo_url') final  String? photoUrl;
 final  List<String>? _imageUrls;
@override@HiveField(13)@JsonKey(name: 'image_urls', fromJson: _toListOfStrings) List<String>? get imageUrls {
  final value = _imageUrls;
  if (value == null) return null;
  if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@HiveField(14)@JsonKey(name: 'opening_hours') final  String? openingHours;
@override@HiveField(15)@JsonKey(fromJson: _toDoubleNonNullable) final  double lat;
@override@HiveField(16)@JsonKey(fromJson: _toDoubleNonNullable) final  double lng;
@override@HiveField(17)@JsonKey(name: 'is_hidden_gem') final  bool isHiddenGem;
@override@HiveField(18)@JsonKey(name: 'maps_url') final  String? mapsUrl;
// New fields from sample
@override@HiveField(19) final  String? day;
@override@HiveField(20)@JsonKey(name: 'is_opened') final  String? isOpened;
@override@HiveField(21) final  String? type;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceModel&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.name, name) || other.name == name)&&(identical(other.city, city) || other.city == city)&&(identical(other.cityEn, cityEn) || other.cityEn == cityEn)&&const DeepCollectionEquality().equals(other._interests, _interests)&&(identical(other.category, category) || other.category == category)&&(identical(other.price, price) || other.price == price)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewsCount, reviewsCount) || other.reviewsCount == reviewsCount)&&(identical(other.address, address) || other.address == address)&&(identical(other.description, description) || other.description == description)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&const DeepCollectionEquality().equals(other._imageUrls, _imageUrls)&&(identical(other.openingHours, openingHours) || other.openingHours == openingHours)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.isHiddenGem, isHiddenGem) || other.isHiddenGem == isHiddenGem)&&(identical(other.mapsUrl, mapsUrl) || other.mapsUrl == mapsUrl)&&(identical(other.day, day) || other.day == day)&&(identical(other.isOpened, isOpened) || other.isOpened == isOpened)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,placeId,name,city,cityEn,const DeepCollectionEquality().hash(_interests),category,price,cost,rating,reviewsCount,address,description,photoUrl,const DeepCollectionEquality().hash(_imageUrls),openingHours,lat,lng,isHiddenGem,mapsUrl,day,isOpened,type]);

@override
String toString() {
  return 'PlaceModel(placeId: $placeId, name: $name, city: $city, cityEn: $cityEn, interests: $interests, category: $category, price: $price, cost: $cost, rating: $rating, reviewsCount: $reviewsCount, address: $address, description: $description, photoUrl: $photoUrl, imageUrls: $imageUrls, openingHours: $openingHours, lat: $lat, lng: $lng, isHiddenGem: $isHiddenGem, mapsUrl: $mapsUrl, day: $day, isOpened: $isOpened, type: $type)';
}


}

/// @nodoc
abstract mixin class _$PlaceModelCopyWith<$Res> implements $PlaceModelCopyWith<$Res> {
  factory _$PlaceModelCopyWith(_PlaceModel value, $Res Function(_PlaceModel) _then) = __$PlaceModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0)@JsonKey(name: 'place_id') String placeId,@HiveField(1) String name,@HiveField(2) String? city,@HiveField(3)@JsonKey(name: 'city_en') String? cityEn,@HiveField(4)@JsonKey(fromJson: _toListOfStrings) List<String>? interests,@HiveField(5) String? category,@HiveField(6)@JsonKey(fromJson: _toDouble) double? price,@HiveField(7)@JsonKey(fromJson: _toDouble) double? cost,@HiveField(8)@JsonKey(fromJson: _toDouble) double? rating,@HiveField(9)@JsonKey(name: 'reviews_count') int? reviewsCount,@HiveField(10) String? address,@HiveField(11) String? description,@HiveField(12)@JsonKey(name: 'photo_url') String? photoUrl,@HiveField(13)@JsonKey(name: 'image_urls', fromJson: _toListOfStrings) List<String>? imageUrls,@HiveField(14)@JsonKey(name: 'opening_hours') String? openingHours,@HiveField(15)@JsonKey(fromJson: _toDoubleNonNullable) double lat,@HiveField(16)@JsonKey(fromJson: _toDoubleNonNullable) double lng,@HiveField(17)@JsonKey(name: 'is_hidden_gem') bool isHiddenGem,@HiveField(18)@JsonKey(name: 'maps_url') String? mapsUrl,@HiveField(19) String? day,@HiveField(20)@JsonKey(name: 'is_opened') String? isOpened,@HiveField(21) String? type
});




}
/// @nodoc
class __$PlaceModelCopyWithImpl<$Res>
    implements _$PlaceModelCopyWith<$Res> {
  __$PlaceModelCopyWithImpl(this._self, this._then);

  final _PlaceModel _self;
  final $Res Function(_PlaceModel) _then;

/// Create a copy of PlaceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? placeId = null,Object? name = null,Object? city = freezed,Object? cityEn = freezed,Object? interests = freezed,Object? category = freezed,Object? price = freezed,Object? cost = freezed,Object? rating = freezed,Object? reviewsCount = freezed,Object? address = freezed,Object? description = freezed,Object? photoUrl = freezed,Object? imageUrls = freezed,Object? openingHours = freezed,Object? lat = null,Object? lng = null,Object? isHiddenGem = null,Object? mapsUrl = freezed,Object? day = freezed,Object? isOpened = freezed,Object? type = freezed,}) {
  return _then(_PlaceModel(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,cityEn: freezed == cityEn ? _self.cityEn : cityEn // ignore: cast_nullable_to_non_nullable
as String?,interests: freezed == interests ? _self._interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,cost: freezed == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,reviewsCount: freezed == reviewsCount ? _self.reviewsCount : reviewsCount // ignore: cast_nullable_to_non_nullable
as int?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,imageUrls: freezed == imageUrls ? _self._imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>?,openingHours: freezed == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as String?,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,isHiddenGem: null == isHiddenGem ? _self.isHiddenGem : isHiddenGem // ignore: cast_nullable_to_non_nullable
as bool,mapsUrl: freezed == mapsUrl ? _self.mapsUrl : mapsUrl // ignore: cast_nullable_to_non_nullable
as String?,day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String?,isOpened: freezed == isOpened ? _self.isOpened : isOpened // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
