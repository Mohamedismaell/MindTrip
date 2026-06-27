import 'package:mindtrip/features/ai_planner/data/mapper/generated_plan_mapper.dart';
import 'package:mindtrip/features/ai_planner/data/models/collected_planner_data_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/collected_planner_data_entity.dart';
import 'package:mindtrip/features/trips/data/models/trip_model.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

extension TripModelMapper on TripModel {
  Trip toEntity() {
    return Trip(
      tripId: tripId,
      title: title,
      city: city,
      destinationGovernorate: destinationGovernorate,
      tripStart: startDate,
      tripEnd: endDate,
      durationDays: durationDays,
      people: people,
      totalBudget: totalBudgetEgp,
      totalCost: totalCost,
      status: _mapStatus(status),
      shareToken: shareToken ?? '',
      isPublic: isPublic,
      sessionId: sessionId ?? '',
      coverImageUrl: coverImageUrl,
      placesCount: placesCount,
      progressPercent: progressPercent,
      plan: plan.toEntity(),
      // collected: collected?.toEntity(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  TripStatus _mapStatus(String status) {
    switch (status.toLowerCase()) {
      case 'draft':
      case 'temporary':
        return TripStatus.draft;
      case 'complete':
      case 'completed':
        return TripStatus.completed;
      default:
        return TripStatus.inProgress;
    }
  }
}

extension TripEntityMapper on Trip {
  TripModel toModel() {
    return TripModel(
      tripId: tripId,
      title: title,
      destinationGovernorate: destinationGovernorate,
      city: city,
      startDate: tripStart,
      endDate: tripEnd,
      durationDays: durationDays,
      people: people,
      totalBudgetEgp: totalBudget,
      totalCost: totalCost,
      status: status.name,
      shareToken: shareToken,
      isPublic: isPublic,
      sessionId: sessionId,
      collected: (collected ?? const CollectedPlannerDataEntity()).toModel(),
      coverImageUrl: coverImageUrl ?? '',
      placesCount: placesCount,
      progressPercent: progressPercent,
      createdAt: createdAt,
      updatedAt: updatedAt,
      plan: plan.toModel(),
    );
  }
}
