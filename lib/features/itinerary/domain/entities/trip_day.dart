// import 'package:equatable/equatable.dart';
// import 'package:mindtrip/features/ai_planner/data/models/day_plan_model.dart';
// import 'package:mindtrip/features/ai_planner/domain/entities/plan_place_entity.dart';

// /// A single time-block within a [TripDay] (morning / afternoon / evening).
// class TimeSlot extends Equatable {
//   const TimeSlot({
//     required this.period,
//     required this.title,
//     required this.places,
//   });

//   final PlaceDayPeriod period;
//   final String title;
//   final List<PlanPlaceEntity> places;

//   @override
//   List<Object?> get props => [period, title, places];
// }

// /// A full day within a generated trip itinerary.
// ///
// /// Combines the raw [DayPlanEntity] data (morning / afternoon / evening
// /// place lists) with presentation-level metadata such as [dayNumber],
// /// [title], [tags], [estimatedCost], and an optional [coverImageUrl].
// class TripDay extends Equatable {
//   const TripDay({
//     required this.dayNumber,
//     required this.title,
//     required this.tags,
//     required this.estimatedCost,
//     required this.timeSlots,
//     this.coverImageUrl = '',
//   });

//   final int dayNumber;
//   final String title;
//   final List<String> tags;
//   final double estimatedCost;
//   final List<TimeSlot> timeSlots;
//   final String coverImageUrl;

//   /// Total number of places across all time slots.
//   int get totalPlaces => timeSlots.fold(0, (sum, s) => sum + s.places.length);

//   /// All places across all time slots in sequence.
//   List<PlanPlaceEntity> get allPlaces =>
//       timeSlots.expand((s) => s.places).toList();

//   @override
//   List<Object?> get props => [
//     dayNumber,
//     title,
//     tags,
//     estimatedCost,
//     timeSlots,
//     coverImageUrl,
//   ];
// }
