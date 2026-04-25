import 'package:equatable/equatable.dart';
import 'package:hive_ce_flutter/adapters.dart';

part 'location_model.g.dart';

@HiveType(typeId: 2)
class LocationModel extends Equatable {
  @HiveField(0)
  final String address;
  @HiveField(1)
  final double latitude;
  @HiveField(2)
  final double longitude;

  const LocationModel({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      address: json['location'] as String? ?? '',
      latitude: json['latitude'] as double? ?? 0.0,
      longitude: json['longitude'] as double? ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'location': address, 'latitude': latitude, 'longitude': longitude};
  }

  @override
  List<Object?> get props => [address, latitude, longitude];
}
