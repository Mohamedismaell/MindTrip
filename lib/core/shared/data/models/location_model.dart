import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final String address;
  final double latitude;
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
