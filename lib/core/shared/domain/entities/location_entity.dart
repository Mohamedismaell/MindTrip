import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final String city;
  final String cityEn;
  final String address;
  final double latitude;
  final double longitude;

  const LocationEntity({
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.cityEn,
  });

  factory LocationEntity.fromJson(Map<String, dynamic> json) {
    return LocationEntity(
      city: json['city'] as String? ?? '',
      cityEn: json['cityEn'] as String? ?? '',
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
