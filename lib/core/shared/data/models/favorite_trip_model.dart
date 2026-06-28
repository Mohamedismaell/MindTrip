import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/core/shared/domain/entities/favorite_trip_entity.dart';

part 'favorite_trip_model.freezed.dart';
part 'favorite_trip_model.g.dart';

@freezed
@HiveType(typeId: 15)
abstract class FavoriteTripModel with _$FavoriteTripModel {
  const FavoriteTripModel._();

  const factory FavoriteTripModel({
    @HiveField(0) required String favoriteTripId,
    @HiveField(1) required String tripId,
    @HiveField(2) required String destination,
    @HiveField(3) required DateTime startDate,
    @HiveField(4) required DateTime endDate,
    @HiveField(5) required int durationDays,
    @HiveField(6) required String status,
    @HiveField(7) required DateTime createdAt,
  }) = _FavoriteTripModel;

  factory FavoriteTripModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteTripModelFromJson(json);

  FavoriteTripEntity toEntity() {
    return FavoriteTripEntity(
      favoriteTripId: favoriteTripId,
      tripId: tripId,
      destination: destination,
      startDate: startDate,
      endDate: endDate,
      durationDays: durationDays,
      status: status,
      createdAt: createdAt,
    );
  }
}

extension FavoriteTripEntityMapper on FavoriteTripEntity {
  FavoriteTripModel toModel() {
    return FavoriteTripModel(
      favoriteTripId: favoriteTripId,
      tripId: tripId,
      destination: destination,
      startDate: startDate,
      endDate: endDate,
      durationDays: durationDays,
      status: status,
      createdAt: createdAt,
    );
  }
}
