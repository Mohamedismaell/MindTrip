import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/map/presentation/models/location_result.dart';

enum LocationStatus {
  initial,
  loading,
  granted,
  denied,
  deniedForever,
  serviceDisabled,
  error,
}

class LocationState extends Equatable {
  final LocationStatus status;
  final LocationResult? location;

  const LocationState({this.status = LocationStatus.initial, this.location});

  LocationState copyWith({LocationStatus? status, LocationResult? location}) {
    return LocationState(
      status: status ?? this.status,
      location: location ?? this.location,
    );
  }

  bool get hasLocation => location != null;

  String get displayName {
    if (location == null) return '';
    final parts = [
      location!.city,
      location!.country,
    ].where((s) => s.isNotEmpty).toList();
    return parts.join(', ');
  }

  @override
  List<Object?> get props => [status, location];
}
