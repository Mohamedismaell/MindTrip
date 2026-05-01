import 'package:equatable/equatable.dart';

class MapSearchResult extends Equatable {
  final String name;
  final double latitude;
  final double longitude;
  final String? address;

  const MapSearchResult({
    required this.name,
    required this.latitude,
    required this.longitude,
    this.address,
  });

  @override
  List<Object?> get props => [name, latitude, longitude, address];
}
