import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/data/models/collected_planner_data_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/generated_plan_model.dart';

class UpdateTripPlanRequestModel extends Equatable {
  const UpdateTripPlanRequestModel({
    this.title,
    this.destinationGovernorate,
    this.city,
    this.startDate,
    this.endDate,
    this.people,
    this.totalBudgetEgp,
    this.totalCost,
    this.plan,
    this.collected,
    this.sessionId,
    this.isPublic,
  });

  final String? title;
  final String? destinationGovernorate;
  final String? city;
  final String? startDate;
  final String? endDate;
  final int? people;
  final int? totalBudgetEgp;
  final int? totalCost;
  final GeneratedPlanModel? plan;
  final CollectedDataModel? collected;
  final String? sessionId;
  final bool? isPublic;

  Map<String, dynamic> toJson() {
    return {
      if (title != null) 'title': title,
      if (destinationGovernorate != null)
        'destinationGovernorate': destinationGovernorate,
      if (city != null) 'city': city,
      if (startDate != null) 'startDate': startDate,
      if (endDate != null) 'endDate': endDate,
      if (people != null) 'people': people,
      if (totalBudgetEgp != null) 'totalBudgetEgp': totalBudgetEgp,
      if (totalCost != null) 'totalCost': totalCost,
      if (plan != null) 'plan': plan!.toJson(),
      if (collected != null) 'collected': collected!.toJson(),
      if (sessionId != null) 'sessionId': sessionId,
      if (isPublic != null) 'isPublic': isPublic,
    };
  }

  @override
  List<Object?> get props => [
        title,
        destinationGovernorate,
        city,
        startDate,
        endDate,
        people,
        totalBudgetEgp,
        totalCost,
        plan,
        collected,
        sessionId,
        isPublic,
      ];
}
