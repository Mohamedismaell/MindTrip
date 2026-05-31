// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BannerModel _$BannerModelFromJson(Map<String, dynamic> json) => _BannerModel(
  id: json['id'] as String? ?? '',
  title: json['title'] as String? ?? '',
  imageUrl: json['imageUrl'] as String? ?? '',
  targetUrl: json['targetUrl'] as String?,
);

Map<String, dynamic> _$BannerModelToJson(_BannerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'targetUrl': instance.targetUrl,
    };
