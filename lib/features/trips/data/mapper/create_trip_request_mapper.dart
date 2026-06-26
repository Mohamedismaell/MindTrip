import 'package:mindtrip/features/ai_planner/data/mapper/generated_plan_mapper.dart';
import 'package:mindtrip/features/ai_planner/data/models/collected_planner_data_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/collected_planner_data_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';
import 'package:mindtrip/features/trips/data/models/create_trip_request_model.dart';

extension CreateTripRequestMapper on GeneratedPlanEntity {
  CreateTripRequestModel toCreateTripRequest({
    required CollectedPlannerDataEntity collected,
    required String sessionId,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    final resolvedDestination = collected.destination.isEmpty
        ? 'Unknown'
        : collected.destination;

    return CreateTripRequestModel(
      title: 'Trip to $resolvedDestination',
      destinationGovernorate: resolvedDestination,
      city: resolvedDestination,
      startDate: startDate?.toIso8601String(),
      endDate: endDate?.toIso8601String(),
      people: collected.people > 0 ? collected.people : people,
      totalBudgetEgp: collected.budget > 0
          ? collected.budget
          : totalCalculatedCost,
      totalCost: totalCalculatedCost,
      plan: toModel(),
      collected: CollectedDataModel.fromEntity(collected),
      sessionId: sessionId,
      isPublic: true,
    );
  }
}
