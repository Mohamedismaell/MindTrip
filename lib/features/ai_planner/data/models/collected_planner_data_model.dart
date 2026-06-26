import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/utils/json_parser.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/collected_planner_data_entity.dart';

class CollectedDataModel extends Equatable {
  const CollectedDataModel({
    this.destination = '',
    this.days = 0,
    this.budget = 0,
    this.interests = const [],
    this.people = 0,
    this.mustInclude = const [],
    this.date,
  });

  final String destination;
  final int days;
  final int budget;
  final List<String> interests;
  final int people;
  final List<String> mustInclude;
  final String? date;
  factory CollectedDataModel.fromJson(Map<String, dynamic> json) {
    return CollectedDataModel(
      destination: parseString(json['destination']),
      days: parseInt(json['days']),
      budget: parseInt(json['budget']),
      interests: parseStringList(json['interests']),
      people: parseInt(json['people']),
      mustInclude: parseStringList(json['mustInclude']),
      date: parseString(json['date']),
    );
  }

  factory CollectedDataModel.fromEntity(CollectedPlannerDataEntity entity) {
    return CollectedDataModel(
      destination: entity.destination,
      days: entity.days,
      budget: entity.budget,
      interests: entity.interests,
      people: entity.people,
      mustInclude: entity.mustInclude,
      date: entity.date,
    );
  }

  factory CollectedDataModel.empty() => const CollectedDataModel();

  Map<String, dynamic> toJson() {
    return {
      'destination': destination,
      'days': days,
      'budget': budget,
      'interests': interests,
      'people': people,
      'mustInclude': mustInclude,
      'date': date,
    };
  }

  CollectedDataModel copyWith({
    String? destination,
    int? days,
    int? budget,
    List<String>? interests,
    int? people,
    List<String>? mustInclude,
    String? date,
  }) {
    return CollectedDataModel(
      destination: destination ?? this.destination,
      days: days ?? this.days,
      budget: budget ?? this.budget,
      interests: interests ?? this.interests,
      people: people ?? this.people,
      mustInclude: mustInclude ?? this.mustInclude,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [
    destination,
    days,
    budget,
    interests,
    people,
    mustInclude,
    date,
  ];
}

extension CollectedDataModelMapper on CollectedDataModel {
  CollectedPlannerDataEntity toEntity() {
    return CollectedPlannerDataEntity(
      destination: destination,
      days: days,
      budget: budget,
      interests: interests,
      people: people,
      mustInclude: mustInclude,
      date: date,
    );
  }
}

extension CollectedPlannerDataEntityMapper on CollectedPlannerDataEntity {
  CollectedDataModel toModel() {
    return CollectedDataModel(
      destination: destination,
      days: days,
      budget: budget,
      interests: interests,
      people: people,
      mustInclude: mustInclude,
      date: date,
    );
  }
}
