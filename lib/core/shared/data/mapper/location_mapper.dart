import 'package:mindtrip/core/shared/data/models/location_model.dart';
import 'package:mindtrip/core/shared/domain/entities/location_entity.dart';

extension LocationMapper on LocationModel {
  LocationEntity toEntity() {
    return LocationEntity(
      address: address,
      latitude: latitude,
      longitude: longitude,
    );
  }
}

extension LocationEntityMapper on LocationEntity {
  LocationModel toModel() {
    return LocationModel(
      address: address,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
