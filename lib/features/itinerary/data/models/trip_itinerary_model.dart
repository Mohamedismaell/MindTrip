import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/features/itinerary/domain/entities/time_slot.dart';
import 'package:mindtrip/features/itinerary/domain/entities/trip_day.dart';
import 'package:mindtrip/features/itinerary/domain/entities/trip_itinerary.dart';
import 'package:mindtrip/features/places/data/mapper/place_mapper.dart';

class TimeSlotModel extends TimeSlot {
  const TimeSlotModel({
    required super.period,
    required super.title,
    required super.places,
  });

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) {
    return TimeSlotModel(
      period: PlaceDayPeriod.values.firstWhere(
        (e) => e.name == json['period'],
        orElse: () => PlaceDayPeriod.morning,
      ),
      title: json['title'] as String,
      places: (json['places'] as List<dynamic>)
          .map((e) => PlaceModel.fromJson(e as Map<String, dynamic>).toEntity())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'period': period.name,
      'title': title,
      'places': places.map((e) => e.toModel().toJson()).toList(),
    };
  }

  factory TimeSlotModel.fromEntity(TimeSlot entity) {
    return TimeSlotModel(
      period: entity.period,
      title: entity.title,
      places: entity.places,
    );
  }

  TimeSlot toEntity() {
    return TimeSlot(period: period, title: title, places: places);
  }
}

class TripDayModel extends TripDay {
  const TripDayModel({
    required super.dayNumber,
    required super.title,
    required super.coverImageUrl,
    required super.tags,
    required super.stopCount,
    required super.estimatedCost,
    required List<TimeSlotModel> super.timeSlots,
  });

  factory TripDayModel.fromJson(Map<String, dynamic> json) {
    return TripDayModel(
      dayNumber: json['dayNumber'] as int,
      title: json['title'] as String,
      coverImageUrl: json['coverImageUrl'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      stopCount: json['stopCount'] as int,
      estimatedCost: (json['estimatedCost'] as num).toDouble(),
      timeSlots: (json['timeSlots'] as List<dynamic>)
          .map((e) => TimeSlotModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayNumber': dayNumber,
      'title': title,
      'coverImageUrl': coverImageUrl,
      'tags': tags,
      'stopCount': stopCount,
      'estimatedCost': estimatedCost,
      'timeSlots': timeSlots.map((e) => (e as TimeSlotModel).toJson()).toList(),
    };
  }

  factory TripDayModel.fromEntity(TripDay entity) {
    return TripDayModel(
      dayNumber: entity.dayNumber,
      title: entity.title,
      coverImageUrl: entity.coverImageUrl,
      tags: entity.tags,
      stopCount: entity.stopCount,
      estimatedCost: entity.estimatedCost,
      timeSlots: entity.timeSlots
          .map((e) => TimeSlotModel.fromEntity(e))
          .toList(),
    );
  }

  TripDay toEntity() {
    return TripDay(
      dayNumber: dayNumber,
      title: title,
      coverImageUrl: coverImageUrl,
      tags: tags,
      stopCount: stopCount,
      estimatedCost: estimatedCost,
      timeSlots: timeSlots.map((e) => (e as TimeSlotModel).toEntity()).toList(),
    );
  }
}

class TripItineraryModel extends TripItinerary {
  const TripItineraryModel({
    required super.tripId,
    required List<TripDayModel> super.days,
    required super.estimatedTotalCost,
  });

  factory TripItineraryModel.fromJson(Map<String, dynamic> json) {
    return TripItineraryModel(
      tripId: json['tripId'] as String,
      days: (json['days'] as List<dynamic>)
          .map((e) => TripDayModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      estimatedTotalCost: (json['estimatedTotalCost'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tripId': tripId,
      'days': days.map((e) => (e as TripDayModel).toJson()).toList(),
      'estimatedTotalCost': estimatedTotalCost,
    };
  }

  factory TripItineraryModel.fromEntity(TripItinerary entity) {
    return TripItineraryModel(
      tripId: entity.tripId,
      days: entity.days.map((e) => TripDayModel.fromEntity(e)).toList(),
      estimatedTotalCost: entity.estimatedTotalCost,
    );
  }

  TripItinerary toEntity() {
    return TripItinerary(
      tripId: tripId,
      days: days.map((e) => (e as TripDayModel).toEntity()).toList(),
      estimatedTotalCost: estimatedTotalCost,
    );
  }
}
