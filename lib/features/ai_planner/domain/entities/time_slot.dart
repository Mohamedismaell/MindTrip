import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';

enum DayPeriod { morning, afternoon, evening }

class TimeSlot extends Equatable {
  const TimeSlot({
    required this.period,
    required this.title,
    required this.places,
  });

  final DayPeriod period;
  final String title;
  final List<PlaceEntity> places;

  @override
  List<Object?> get props => [period, title, places];
}
