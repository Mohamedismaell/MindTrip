import 'package:mindtrip/core/shared/data/mapper/location_mapper.dart';
import 'package:mindtrip/core/shared/data/models/tour_package_model.dart';
import 'package:mindtrip/features/home/domain/entity/tour_package_entity.dart';

extension TourPackageMapper on TourPackageModel {
  TourPackageEntity toEntity() {
    return TourPackageEntity(
      id: id,
      title: title,
      location: location.toEntity(),
      imageUrl: imageUrl,
      price: price,
      rating: rating,
      durationDays: durationDays,
    );
  }
}

extension TourPackageEntityMapper on TourPackageEntity {
  TourPackageModel toModel() {
    return TourPackageModel(
      id: id,
      title: title,
      location: location.toModel(),
      imageUrl: imageUrl,
      price: price,
      rating: rating,
      durationDays: durationDays,
    );
  }
}
