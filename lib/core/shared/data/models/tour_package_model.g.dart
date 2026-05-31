// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_package_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TourPackageModel _$TourPackageModelFromJson(Map<String, dynamic> json) =>
    _TourPackageModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      location: LocationModel.fromJson(
        json['location'] as Map<String, dynamic>,
      ),
      imageUrl: json['imageUrl'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      durationDays: (json['durationDays'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TourPackageModelToJson(_TourPackageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'location': instance.location,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
      'rating': instance.rating,
      'durationDays': instance.durationDays,
    };
