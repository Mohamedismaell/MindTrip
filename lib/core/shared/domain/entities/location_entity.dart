import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final String location;
  final double latitude;
  final double longitude;

  const LocationEntity({
    required this.location,
    required this.latitude,
    required this.longitude,
  });

  factory LocationEntity.fromJson(Map<String, dynamic> json) {
    return LocationEntity(
      location: json['location'] as String? ?? '',
      latitude: json['latitude'] as double? ?? 0.0,
      longitude: json['longitude'] as double? ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'location': location, 'latitude': latitude, 'longitude': longitude};
  }

  @override
  List<Object?> get props => [location, latitude, longitude];
}
