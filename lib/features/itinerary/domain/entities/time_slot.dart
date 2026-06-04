import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';

enum PlaceDayPeriod { morning, afternoon, evening }

class TimeSlot extends Equatable {
  const TimeSlot({
    required this.period,
    required this.title,
    required this.places,
  });

  final PlaceDayPeriod period;
  final String title;
  final List<PlaceEntity> places;

  TimeSlot copyWith({
    PlaceDayPeriod? period,
    String? title,
    List<PlaceEntity>? places,
  }) {
    return TimeSlot(
      period: period ?? this.period,
      title: title ?? this.title,
      places: places ?? this.places,
    );
  }

  @override
  List<Object?> get props => [period, title, places];
}
