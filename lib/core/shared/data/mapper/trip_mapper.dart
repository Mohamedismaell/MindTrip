import 'package:mindtrip/core/shared/data/models/trip_model.dart';
import 'package:mindtrip/core/shared/domain/entities/trip_entity.dart';
import 'package:mindtrip/core/shared/data/mapper/place_mapper.dart';

extension TripMapper on TripModel {
  TripEntity toEntity() {
    return TripEntity(
      id: id,
      title: title,
      subtitle: subtitle,
      imageUrl: imageUrl,
      places: places.map((e) => e.toEntity()).toList(),
      startDate: startDate,
      endDate: endDate,
      isFavorite: isFavorite,
      isAiGenerated: isAiGenerated,
    );
  }
}

extension TripEntityMapper on TripEntity {
  TripModel toModel() {
    return TripModel(
      id: id,
      title: title,
      subtitle: subtitle,
      imageUrl: imageUrl,
      places: places.map((e) => e.toModel()).toList(),
      startDate: startDate,
      endDate: endDate,
      isFavorite: isFavorite,
      isAiGenerated: isAiGenerated,
    );
  }
}
