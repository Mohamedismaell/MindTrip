import 'package:equatable/equatable.dart';

class CollectedPlannerDataEntity extends Equatable {
  const CollectedPlannerDataEntity({
    this.destination = '',
    this.days = 0,
    this.budget = 0,
    this.interests = const [],
    this.people = 0,
    this.mustInclude = const [],
  });

  final String destination;
  final int days;
  final int budget;
  final List<String> interests;
  final int people;
  final List<String> mustInclude;

  @override
  List<Object?> get props => [
    destination,
    days,
    budget,
    interests,
    people,
    mustInclude,
  ];
}
