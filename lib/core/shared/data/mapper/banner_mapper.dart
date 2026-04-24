import 'package:mindtrip/core/shared/data/models/banner_model.dart';
import 'package:mindtrip/core/shared/domain/entities/banner_entity.dart';

extension BannerMapper on BannerModel {
  BannerEntity toEntity() {
    return BannerEntity(
      id: id,
      title: title,
      imageUrl: imageUrl,
      targetUrl: targetUrl,
    );
  }
}

extension BannerEntityMapper on BannerEntity {
  BannerModel toModel() {
    return BannerModel(
      id: id,
      title: title,
      imageUrl: imageUrl,
      targetUrl: targetUrl,
    );
  }
}
