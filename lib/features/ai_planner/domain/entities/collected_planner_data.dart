import 'package:equatable/equatable.dart';

/// Value object that mirrors the `collected` / `cardAnswers` fields
/// sent to the backend's `/api/v1/ai/chat` endpoint.
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

  /// Builds the `collected` map for the chat request body.
  Map<String, dynamic> toCollectedMap() => {
    'destination': destination,
    'days': days,
    'budget': budget,
    'interests': interests,
    'people': people,
    'mustInclude': mustInclude,
  };

  /// Builds the `cardAnswers` map for the chat request body.
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
