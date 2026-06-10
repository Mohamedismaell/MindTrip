import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/itinerary/domain/entities/time_slot.dart';

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

  int get totalPlaces =>
      timeSlots.fold(0, (sum, slot) => sum + slot.places.length);

  TripDay copyWith({
    int? dayNumber,
    String? title,
    String? coverImageUrl,
    List<String>? tags,
    int? stopCount,
    double? estimatedCost,
    List<TimeSlot>? timeSlots,
  }) {
    return TripDay(
      dayNumber: dayNumber ?? this.dayNumber,
      title: title ?? this.title,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      tags: tags ?? this.tags,
      stopCount: stopCount ?? this.stopCount,
      estimatedCost: estimatedCost ?? this.estimatedCost,
      timeSlots: timeSlots ?? this.timeSlots,
    );
  }

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
