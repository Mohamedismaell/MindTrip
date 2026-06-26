import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/data/models/collected_planner_data_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/generated_plan_model.dart';

class CreateTripRequestModel extends Equatable {
  const CreateTripRequestModel({
    required this.title,
    required this.destinationGovernorate,
    required this.city,
    this.startDate,
    this.endDate,
    required this.people,
    required this.totalBudgetEgp,
    required this.totalCost,
    required this.plan,
    required this.collected,
    this.sessionId,
    required this.isPublic,
  });

  final String title;
  final String destinationGovernorate;
  final String city;
  final String? startDate;
  final String? endDate;
  final int people;
  final int totalBudgetEgp;
  final int totalCost;
  final GeneratedPlanModel plan;
  final CollectedDataModel collected;
  final String? sessionId;
  final bool isPublic;

  factory CreateTripRequestModel.fromJson(Map<String, dynamic> json) {
    return CreateTripRequestModel(
      title: json['title'] as String,
      destinationGovernorate: json['destinationGovernorate'] as String,
      city: json['city'] as String,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      people: (json['people'] as num).toInt(),
      totalBudgetEgp: (json['totalBudgetEgp'] as num).toInt(),
      totalCost: (json['totalCost'] as num).toInt(),
      plan: GeneratedPlanModel.fromJson(json['plan'] as Map<String, dynamic>),
      collected: CollectedDataModel.fromJson(
        json['collected'] as Map<String, dynamic>,
      ),
      sessionId: json['sessionId'] as String?,
      isPublic: json['isPublic'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'destinationGovernorate': destinationGovernorate,
      'city': city,
      'startDate': startDate,
      'endDate': endDate,
      'people': people,
      'totalBudgetEgp': totalBudgetEgp,
      'totalCost': totalCost,
      'plan': plan.toJson(),
      'collected': collected.toJson(),
      'sessionId': sessionId,
      'isPublic': isPublic,
    };
  }

  CreateTripRequestModel copyWith({
    String? title,
    String? destinationGovernorate,
    String? city,
    String? startDate,
    String? endDate,
    int? people,
    int? totalBudgetEgp,
    int? totalCost,
    GeneratedPlanModel? plan,
    CollectedDataModel? collected,
    String? sessionId,
    bool? isPublic,
  }) {
    return CreateTripRequestModel(
      title: title ?? this.title,
      destinationGovernorate:
          destinationGovernorate ?? this.destinationGovernorate,
      city: city ?? this.city,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      people: people ?? this.people,
      totalBudgetEgp: totalBudgetEgp ?? this.totalBudgetEgp,
      totalCost: totalCost ?? this.totalCost,
      plan: plan ?? this.plan,
      collected: collected ?? this.collected,
      sessionId: sessionId ?? this.sessionId,
      isPublic: isPublic ?? this.isPublic,
    );
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
