// import 'package:mindtrip/features/trips/data/models/trip_model.dart';
// import 'package:mindtrip/features/trips/domain/entities/trip.dart';

// extension TripModelMapper on TripModel {
//   Trip toEntity() {
//     return Trip(
//       id: tripId,
//       title: title,
//       status: _statusFromString(status),
//       createdAt: createdAt,
//       updatedAt: updatedAt,
//       destination: destination,
//       destinationGovernorate: destinationGovernorate,
//       tripStart: startDate,
//       tripEnd: endDate,
//       people: people,
//       totalBudget: totalBudget,
//       totalCost: totalCost,
//       interests: const [],
//       coverImageUrl: coverImageUrl,
//       sessionId: sessionId,
//       backendTripId: tripId,
//       planJson: plan,
//       collectedJson: collectedJson,
//       shareToken: shareToken,
//       isPublic: isPublic,
//       placesCount: placesCount,
//       progressPercent: progressPercent,
//     );
//   }
// }

// extension TripEntityMapper on Trip {
//   TripModel toModel() {
//     return TripModel(
//       tripId: backendTripId ?? id,
//       title: title,
//       destinationGovernorate: destinationGovernorate ?? '',
//       destination: destination,
//       startDate: tripStart,
//       endDate: tripEnd,
//       people: people,
//       totalBudget: totalBudget,
//       budget: totalBudget,
//       totalCost: totalCost,
//       status: _statusToString(status),
//       shareToken: shareToken,
//       isPublic: isPublic,
//       sessionId: sessionId,
//       collectedJson: collectedJson,
//       coverImageUrl: coverImageUrl,
//       placesCount: placesCount,
//       progressPercent: progressPercent,
//       createdAt: createdAt,
//       updatedAt: updatedAt,
//       plan: planJson,
//     );
//   }
// }
