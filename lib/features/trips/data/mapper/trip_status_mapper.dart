import 'package:mindtrip/features/trips/domain/entities/trip.dart';

TripStatus statusFromString(String value) {
  switch (value.toLowerCase()) {
    case 'draft':
      return TripStatus.draft;

    case 'inprogress':
      return TripStatus.inProgress;

    case 'completed':
      return TripStatus.completed;

    default:
      return TripStatus.draft;
  }
}

String statusToString(TripStatus status) {
  switch (status) {
    case TripStatus.draft:
      return 'Draft';

    case TripStatus.inProgress:
      return 'InProgress';

    case TripStatus.completed:
      return 'Completed';
    default:
      return 'Draft';
  }
}
