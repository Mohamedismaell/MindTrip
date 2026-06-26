import 'package:mindtrip/core/shared/data/mapper/trip_mapper.dart';
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
      status: TripStatus.values.firstWhere(
        (e) => e.name.toLowerCase() == status.toLowerCase(),
        orElse: () => TripStatus.draft,
      ),
      shareToken: shareToken,
      isPublic: isPublic,
      sessionId: sessionId,
      coverImageUrl: coverImageUrl,
      placesCount: placesCount,
      progressPercent: progressPercent,
      plan: plan.toEntity(),
      // collected: ... we'll discuss below
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
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
