import 'package:mindtrip/features/trips/data/models/trip_model.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

extension TripModelMapper on TripModel {
  Trip toEntity() {
    return Trip(
      id: tripId,
      backendTripId: tripId,
      title: title,
      status: TripStatus.values.firstWhere(
        (e) => e.name.toLowerCase() == status.toLowerCase(),
        orElse: () => TripStatus.draft,
      ),
      createdAt: createdAt,
      updatedAt: updatedAt,
      destination: city,
      destinationGovernorate: destinationGovernorate,
      tripStart: startDate,
      tripEnd: endDate,
      people: people,
      totalBudget: totalBudgetEgp,
      totalCost: totalCost,
      shareToken: shareToken,
      isPublic: isPublic,
      sessionId: sessionId,
      collectedJson: collectedJson,
      coverImageUrl: coverImageUrl,
      placesCount: placesCount,
      progressPercent: progressPercent ?? 0.0,
      interests: const [],
    );
  }
}

extension TripEntityMapper on Trip {
  TripModel toModel() {
    return TripModel(
      tripId: backendTripId ?? id,
      title: title,
      destinationGovernorate: destinationGovernorate ?? '',
      city: destination,
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
      collectedJson: collectedJson,
      coverImageUrl: coverImageUrl,
      placesCount: placesCount,
      progressPercent: progressPercent,
      createdAt: createdAt,
      updatedAt: updatedAt,
      plan: planJson,
    );
  }
}
