import 'package:mindtrip/features/trips/domain/entities/trip.dart';

TripStatus _statusFromString(String value) {
  switch (value.toLowerCase()) {
    case 'draft':
      return TripStatus.draft;

    case 'upcoming':
      return TripStatus.upcoming;

    case 'completed':
      return TripStatus.completed;

    case 'cancelled':
      return TripStatus.cancelled;

    default:
      return TripStatus.draft;
  }
}

String _statusToString(TripStatus status) {
  switch (status) {
    case TripStatus.draft:
      return 'Draft';

    case TripStatus.upcoming:
      return 'Upcoming';

    case TripStatus.completed:
      return 'Completed';

    case TripStatus.cancelled:
      return 'Cancelled';

    case TripStatus.inProgress:
      return 'Draft';
  }
}