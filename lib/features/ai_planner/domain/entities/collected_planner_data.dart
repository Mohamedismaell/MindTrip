import 'package:equatable/equatable.dart';

class CollectedPlannerData extends Equatable {
  const CollectedPlannerData({
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

  Map<String, dynamic> toCollectedMap() => {
    'destination': destination,
    'days': days,
    'budget': budget,
    'interests': interests,
    'people': people,
    'mustInclude': mustInclude,
  };

  Map<String, dynamic> toCardAnswersMap() => {
    'destination': destination,
    'days': days,
    'budget': budget,
    'interests': interests,
    'people': people,
    'must_include': mustInclude,
  };

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
