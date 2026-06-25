// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_place_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlanPlaceModel {

@JsonKey(name: 'place_id') String get placeId; String get name; String get city;@JsonKey(name: 'city_en') String get cityEn; String get category;@JsonKey(fromJson: parseDouble) double get rating;@JsonKey(name: 'reviews_count', fromJson: parseInt) int get reviewsCount; String get address; String get description;@JsonKey(name: 'photo_url') String get photoUrl;@JsonKey(name: 'image_urls', fromJson: parseStringList) List<String> get imageUrls;@JsonKey(name: 'maps_url') String get mapsUrl;@JsonKey(fromJson: parseDouble) double get lat;@JsonKey(fromJson: parseDouble) double get lng;@JsonKey(fromJson: parseDay) int get day; String get type;@JsonKey(fromJson: parseDouble) double get price;@JsonKey(fromJson: parseDouble) double get cost;@JsonKey(fromJson: parseStringList) List<String> get interests;@JsonKey(name: 'is_hidden_gem') bool get isHiddenGem;@JsonKey(name: 'opening_hours') String get openingHours;@JsonKey(name: 'is_opened', fromJson: parseBool) bool get isOpened;
/// Create a copy of PlanPlaceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanPlaceModelCopyWith<PlanPlaceModel> get copyWith => _$PlanPlaceModelCopyWithImpl<PlanPlaceModel>(this as PlanPlaceModel, _$identity);

  /// Serializes this PlanPlaceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanPlaceModel&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.name, name) || other.name == name)&&(identical(other.city, city) || other.city == city)&&(identical(other.cityEn, cityEn) || other.cityEn == cityEn)&&(identical(other.category, category) || other.category == category)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewsCount, reviewsCount) || other.reviewsCount == reviewsCount)&&(identical(other.address, address) || other.address == address)&&(identical(other.description, description) || other.description == description)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&const DeepCollectionEquality().equals(other.imageUrls, imageUrls)&&(identical(other.mapsUrl, mapsUrl) || other.mapsUrl == mapsUrl)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.day, day) || other.day == day)&&(identical(other.type, type) || other.type == type)&&(identical(other.price, price) || other.price == price)&&(identical(other.cost, cost) || other.cost == cost)&&const DeepCollectionEquality().equals(other.interests, interests)&&(identical(other.isHiddenGem, isHiddenGem) || other.isHiddenGem == isHiddenGem)&&(identical(other.openingHours, openingHours) || other.openingHours == openingHours)&&(identical(other.isOpened, isOpened) || other.isOpened == isOpened));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,placeId,name,city,cityEn,category,rating,reviewsCount,address,description,photoUrl,const DeepCollectionEquality().hash(imageUrls),mapsUrl,lat,lng,day,type,price,cost,const DeepCollectionEquality().hash(interests),isHiddenGem,openingHours,isOpened]);

@override
String toString() {
  return 'PlanPlaceModel(placeId: $placeId, name: $name, city: $city, cityEn: $cityEn, category: $category, rating: $rating, reviewsCount: $reviewsCount, address: $address, description: $description, photoUrl: $photoUrl, imageUrls: $imageUrls, mapsUrl: $mapsUrl, lat: $lat, lng: $lng, day: $day, type: $type, price: $price, cost: $cost, interests: $interests, isHiddenGem: $isHiddenGem, openingHours: $openingHours, isOpened: $isOpened)';
}


}

/// @nodoc
abstract mixin class $PlanPlaceModelCopyWith<$Res>  {
  factory $PlanPlaceModelCopyWith(PlanPlaceModel value, $Res Function(PlanPlaceModel) _then) = _$PlanPlaceModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'place_id') String placeId, String name, String city,@JsonKey(name: 'city_en') String cityEn, String category,@JsonKey(fromJson: parseDouble) double rating,@JsonKey(name: 'reviews_count', fromJson: parseInt) int reviewsCount, String address, String description,@JsonKey(name: 'photo_url') String photoUrl,@JsonKey(name: 'image_urls', fromJson: parseStringList) List<String> imageUrls,@JsonKey(name: 'maps_url') String mapsUrl,@JsonKey(fromJson: parseDouble) double lat,@JsonKey(fromJson: parseDouble) double lng,@JsonKey(fromJson: parseDay) int day, String type,@JsonKey(fromJson: parseDouble) double price,@JsonKey(fromJson: parseDouble) double cost,@JsonKey(fromJson: parseStringList) List<String> interests,@JsonKey(name: 'is_hidden_gem') bool isHiddenGem,@JsonKey(name: 'opening_hours') String openingHours,@JsonKey(name: 'is_opened', fromJson: parseBool) bool isOpened
});




}
/// @nodoc
class _$PlanPlaceModelCopyWithImpl<$Res>
    implements $PlanPlaceModelCopyWith<$Res> {
  _$PlanPlaceModelCopyWithImpl(this._self, this._then);

  final PlanPlaceModel _self;
  final $Res Function(PlanPlaceModel) _then;

/// Create a copy of PlanPlaceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? placeId = null,Object? name = null,Object? city = null,Object? cityEn = null,Object? category = null,Object? rating = null,Object? reviewsCount = null,Object? address = null,Object? description = null,Object? photoUrl = null,Object? imageUrls = null,Object? mapsUrl = null,Object? lat = null,Object? lng = null,Object? day = null,Object? type = null,Object? price = null,Object? cost = null,Object? interests = null,Object? isHiddenGem = null,Object? openingHours = null,Object? isOpened = null,}) {
  return _then(_self.copyWith(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,cityEn: null == cityEn ? _self.cityEn : cityEn // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewsCount: null == reviewsCount ? _self.reviewsCount : reviewsCount // ignore: cast_nullable_to_non_nullable
as int,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,imageUrls: null == imageUrls ? _self.imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,mapsUrl: null == mapsUrl ? _self.mapsUrl : mapsUrl // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double,interests: null == interests ? _self.interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,isHiddenGem: null == isHiddenGem ? _self.isHiddenGem : isHiddenGem // ignore: cast_nullable_to_non_nullable
as bool,openingHours: null == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as String,isOpened: null == isOpened ? _self.isOpened : isOpened // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanPlaceModel].
extension PlanPlaceModelPatterns on PlanPlaceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanPlaceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanPlaceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanPlaceModel value)  $default,){
final _that = this;
switch (_that) {
case _PlanPlaceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanPlaceModel value)?  $default,){
final _that = this;
switch (_that) {
case _PlanPlaceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'place_id')  String placeId,  String name,  String city, @JsonKey(name: 'city_en')  String cityEn,  String category, @JsonKey(fromJson: parseDouble)  double rating, @JsonKey(name: 'reviews_count', fromJson: parseInt)  int reviewsCount,  String address,  String description, @JsonKey(name: 'photo_url')  String photoUrl, @JsonKey(name: 'image_urls', fromJson: parseStringList)  List<String> imageUrls, @JsonKey(name: 'maps_url')  String mapsUrl, @JsonKey(fromJson: parseDouble)  double lat, @JsonKey(fromJson: parseDouble)  double lng, @JsonKey(fromJson: parseDay)  int day,  String type, @JsonKey(fromJson: parseDouble)  double price, @JsonKey(fromJson: parseDouble)  double cost, @JsonKey(fromJson: parseStringList)  List<String> interests, @JsonKey(name: 'is_hidden_gem')  bool isHiddenGem, @JsonKey(name: 'opening_hours')  String openingHours, @JsonKey(name: 'is_opened', fromJson: parseBool)  bool isOpened)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanPlaceModel() when $default != null:
return $default(_that.placeId,_that.name,_that.city,_that.cityEn,_that.category,_that.rating,_that.reviewsCount,_that.address,_that.description,_that.photoUrl,_that.imageUrls,_that.mapsUrl,_that.lat,_that.lng,_that.day,_that.type,_that.price,_that.cost,_that.interests,_that.isHiddenGem,_that.openingHours,_that.isOpened);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'place_id')  String placeId,  String name,  String city, @JsonKey(name: 'city_en')  String cityEn,  String category, @JsonKey(fromJson: parseDouble)  double rating, @JsonKey(name: 'reviews_count', fromJson: parseInt)  int reviewsCount,  String address,  String description, @JsonKey(name: 'photo_url')  String photoUrl, @JsonKey(name: 'image_urls', fromJson: parseStringList)  List<String> imageUrls, @JsonKey(name: 'maps_url')  String mapsUrl, @JsonKey(fromJson: parseDouble)  double lat, @JsonKey(fromJson: parseDouble)  double lng, @JsonKey(fromJson: parseDay)  int day,  String type, @JsonKey(fromJson: parseDouble)  double price, @JsonKey(fromJson: parseDouble)  double cost, @JsonKey(fromJson: parseStringList)  List<String> interests, @JsonKey(name: 'is_hidden_gem')  bool isHiddenGem, @JsonKey(name: 'opening_hours')  String openingHours, @JsonKey(name: 'is_opened', fromJson: parseBool)  bool isOpened)  $default,) {final _that = this;
switch (_that) {
case _PlanPlaceModel():
return $default(_that.placeId,_that.name,_that.city,_that.cityEn,_that.category,_that.rating,_that.reviewsCount,_that.address,_that.description,_that.photoUrl,_that.imageUrls,_that.mapsUrl,_that.lat,_that.lng,_that.day,_that.type,_that.price,_that.cost,_that.interests,_that.isHiddenGem,_that.openingHours,_that.isOpened);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'place_id')  String placeId,  String name,  String city, @JsonKey(name: 'city_en')  String cityEn,  String category, @JsonKey(fromJson: parseDouble)  double rating, @JsonKey(name: 'reviews_count', fromJson: parseInt)  int reviewsCount,  String address,  String description, @JsonKey(name: 'photo_url')  String photoUrl, @JsonKey(name: 'image_urls', fromJson: parseStringList)  List<String> imageUrls, @JsonKey(name: 'maps_url')  String mapsUrl, @JsonKey(fromJson: parseDouble)  double lat, @JsonKey(fromJson: parseDouble)  double lng, @JsonKey(fromJson: parseDay)  int day,  String type, @JsonKey(fromJson: parseDouble)  double price, @JsonKey(fromJson: parseDouble)  double cost, @JsonKey(fromJson: parseStringList)  List<String> interests, @JsonKey(name: 'is_hidden_gem')  bool isHiddenGem, @JsonKey(name: 'opening_hours')  String openingHours, @JsonKey(name: 'is_opened', fromJson: parseBool)  bool isOpened)?  $default,) {final _that = this;
switch (_that) {
case _PlanPlaceModel() when $default != null:
return $default(_that.placeId,_that.name,_that.city,_that.cityEn,_that.category,_that.rating,_that.reviewsCount,_that.address,_that.description,_that.photoUrl,_that.imageUrls,_that.mapsUrl,_that.lat,_that.lng,_that.day,_that.type,_that.price,_that.cost,_that.interests,_that.isHiddenGem,_that.openingHours,_that.isOpened);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanPlaceModel implements PlanPlaceModel {
  const _PlanPlaceModel({@JsonKey(name: 'place_id') required this.placeId, required this.name, required this.city, @JsonKey(name: 'city_en') required this.cityEn, required this.category, @JsonKey(fromJson: parseDouble) required this.rating, @JsonKey(name: 'reviews_count', fromJson: parseInt) required this.reviewsCount, required this.address, required this.description, @JsonKey(name: 'photo_url') required this.photoUrl, @JsonKey(name: 'image_urls', fromJson: parseStringList) required final  List<String> imageUrls, @JsonKey(name: 'maps_url') required this.mapsUrl, @JsonKey(fromJson: parseDouble) required this.lat, @JsonKey(fromJson: parseDouble) required this.lng, @JsonKey(fromJson: parseDay) required this.day, required this.type, @JsonKey(fromJson: parseDouble) required this.price, @JsonKey(fromJson: parseDouble) required this.cost, @JsonKey(fromJson: parseStringList) required final  List<String> interests, @JsonKey(name: 'is_hidden_gem') required this.isHiddenGem, @JsonKey(name: 'opening_hours') required this.openingHours, @JsonKey(name: 'is_opened', fromJson: parseBool) required this.isOpened}): _imageUrls = imageUrls,_interests = interests;
  factory _PlanPlaceModel.fromJson(Map<String, dynamic> json) => _$PlanPlaceModelFromJson(json);

@override@JsonKey(name: 'place_id') final  String placeId;
@override final  String name;
@override final  String city;
@override@JsonKey(name: 'city_en') final  String cityEn;
@override final  String category;
@override@JsonKey(fromJson: parseDouble) final  double rating;
@override@JsonKey(name: 'reviews_count', fromJson: parseInt) final  int reviewsCount;
@override final  String address;
@override final  String description;
@override@JsonKey(name: 'photo_url') final  String photoUrl;
 final  List<String> _imageUrls;
@override@JsonKey(name: 'image_urls', fromJson: parseStringList) List<String> get imageUrls {
  if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imageUrls);
}

@override@JsonKey(name: 'maps_url') final  String mapsUrl;
@override@JsonKey(fromJson: parseDouble) final  double lat;
@override@JsonKey(fromJson: parseDouble) final  double lng;
@override@JsonKey(fromJson: parseDay) final  int day;
@override final  String type;
@override@JsonKey(fromJson: parseDouble) final  double price;
@override@JsonKey(fromJson: parseDouble) final  double cost;
 final  List<String> _interests;
@override@JsonKey(fromJson: parseStringList) List<String> get interests {
  if (_interests is EqualUnmodifiableListView) return _interests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_interests);
}

@override@JsonKey(name: 'is_hidden_gem') final  bool isHiddenGem;
@override@JsonKey(name: 'opening_hours') final  String openingHours;
@override@JsonKey(name: 'is_opened', fromJson: parseBool) final  bool isOpened;

/// Create a copy of PlanPlaceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanPlaceModelCopyWith<_PlanPlaceModel> get copyWith => __$PlanPlaceModelCopyWithImpl<_PlanPlaceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanPlaceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanPlaceModel&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.name, name) || other.name == name)&&(identical(other.city, city) || other.city == city)&&(identical(other.cityEn, cityEn) || other.cityEn == cityEn)&&(identical(other.category, category) || other.category == category)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewsCount, reviewsCount) || other.reviewsCount == reviewsCount)&&(identical(other.address, address) || other.address == address)&&(identical(other.description, description) || other.description == description)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&const DeepCollectionEquality().equals(other._imageUrls, _imageUrls)&&(identical(other.mapsUrl, mapsUrl) || other.mapsUrl == mapsUrl)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.day, day) || other.day == day)&&(identical(other.type, type) || other.type == type)&&(identical(other.price, price) || other.price == price)&&(identical(other.cost, cost) || other.cost == cost)&&const DeepCollectionEquality().equals(other._interests, _interests)&&(identical(other.isHiddenGem, isHiddenGem) || other.isHiddenGem == isHiddenGem)&&(identical(other.openingHours, openingHours) || other.openingHours == openingHours)&&(identical(other.isOpened, isOpened) || other.isOpened == isOpened));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,placeId,name,city,cityEn,category,rating,reviewsCount,address,description,photoUrl,const DeepCollectionEquality().hash(_imageUrls),mapsUrl,lat,lng,day,type,price,cost,const DeepCollectionEquality().hash(_interests),isHiddenGem,openingHours,isOpened]);

@override
String toString() {
  return 'PlanPlaceModel(placeId: $placeId, name: $name, city: $city, cityEn: $cityEn, category: $category, rating: $rating, reviewsCount: $reviewsCount, address: $address, description: $description, photoUrl: $photoUrl, imageUrls: $imageUrls, mapsUrl: $mapsUrl, lat: $lat, lng: $lng, day: $day, type: $type, price: $price, cost: $cost, interests: $interests, isHiddenGem: $isHiddenGem, openingHours: $openingHours, isOpened: $isOpened)';
}


}

/// @nodoc
abstract mixin class _$PlanPlaceModelCopyWith<$Res> implements $PlanPlaceModelCopyWith<$Res> {
  factory _$PlanPlaceModelCopyWith(_PlanPlaceModel value, $Res Function(_PlanPlaceModel) _then) = __$PlanPlaceModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'place_id') String placeId, String name, String city,@JsonKey(name: 'city_en') String cityEn, String category,@JsonKey(fromJson: parseDouble) double rating,@JsonKey(name: 'reviews_count', fromJson: parseInt) int reviewsCount, String address, String description,@JsonKey(name: 'photo_url') String photoUrl,@JsonKey(name: 'image_urls', fromJson: parseStringList) List<String> imageUrls,@JsonKey(name: 'maps_url') String mapsUrl,@JsonKey(fromJson: parseDouble) double lat,@JsonKey(fromJson: parseDouble) double lng,@JsonKey(fromJson: parseDay) int day, String type,@JsonKey(fromJson: parseDouble) double price,@JsonKey(fromJson: parseDouble) double cost,@JsonKey(fromJson: parseStringList) List<String> interests,@JsonKey(name: 'is_hidden_gem') bool isHiddenGem,@JsonKey(name: 'opening_hours') String openingHours,@JsonKey(name: 'is_opened', fromJson: parseBool) bool isOpened
});




}
/// @nodoc
class __$PlanPlaceModelCopyWithImpl<$Res>
    implements _$PlanPlaceModelCopyWith<$Res> {
  __$PlanPlaceModelCopyWithImpl(this._self, this._then);

  final _PlanPlaceModel _self;
  final $Res Function(_PlanPlaceModel) _then;

/// Create a copy of PlanPlaceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? placeId = null,Object? name = null,Object? city = null,Object? cityEn = null,Object? category = null,Object? rating = null,Object? reviewsCount = null,Object? address = null,Object? description = null,Object? photoUrl = null,Object? imageUrls = null,Object? mapsUrl = null,Object? lat = null,Object? lng = null,Object? day = null,Object? type = null,Object? price = null,Object? cost = null,Object? interests = null,Object? isHiddenGem = null,Object? openingHours = null,Object? isOpened = null,}) {
  return _then(_PlanPlaceModel(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,cityEn: null == cityEn ? _self.cityEn : cityEn // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewsCount: null == reviewsCount ? _self.reviewsCount : reviewsCount // ignore: cast_nullable_to_non_nullable
as int,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,imageUrls: null == imageUrls ? _self._imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,mapsUrl: null == mapsUrl ? _self.mapsUrl : mapsUrl // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double,interests: null == interests ? _self._interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,isHiddenGem: null == isHiddenGem ? _self.isHiddenGem : isHiddenGem // ignore: cast_nullable_to_non_nullable
as bool,openingHours: null == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as String,isOpened: null == isOpened ? _self.isOpened : isOpened // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
