import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/time_slot.dart';

class TripDay extends Equatable {
  const TripDay({
    required this.dayNumber,
    required this.title,
    required this.coverImageUrl,
    //Todo: the tags should be the catgory of the places
    required this.tags,
    required this.stopCount,
    required this.estimatedCost,
    required this.timeSlots,
  });

  final int dayNumber;
  final String title;
  final String coverImageUrl;
  final List<String> tags;
  final int stopCount;
  final double estimatedCost;
  final List<TimeSlot> timeSlots;

  @override
  List<Object?> get props => [
    dayNumber,
    title,
    coverImageUrl,
    tags,
    stopCount,
    estimatedCost,
    timeSlots,
  ];
}
