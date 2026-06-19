import 'package:mindtrip/core/shared/data/models/planner_preview_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/planner_preview_entity.dart';

extension PlannerStopMapper on PlannerStopModel {
  PlannerStopEntity toEntity() {
    return PlannerStopEntity(
      time: time,
      label: label,
    );
  }
}

extension PlannerStopEntityMapper on PlannerStopEntity {
  PlannerStopModel toModel() {
    return PlannerStopModel(
      time: time,
      label: label,
    );
  }
}

extension PlannerPreviewMapper on PlannerPreviewModel {
  PlannerPreviewEntity toEntity() {
    return PlannerPreviewEntity(
      title: title,
      imageUrl: imageUrl,
      badge: badge,
      stops: stops.map((stop) => stop.toEntity()).toList(),
    );
  }
}

extension PlannerPreviewEntityMapper on PlannerPreviewEntity {
  PlannerPreviewModel toModel() {
    return PlannerPreviewModel(
      title: title,
      imageUrl: imageUrl,
      badge: badge,
      stops: stops.map((stop) => stop.toModel()).toList(),
    );
  }
}
