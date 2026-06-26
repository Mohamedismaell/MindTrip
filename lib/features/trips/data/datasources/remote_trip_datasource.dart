import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/core/database/api/end_points.dart';
import 'package:mindtrip/features/trips/data/mapper/trip_mapper.dart';
import 'package:mindtrip/features/trips/data/models/create_trip_request_model.dart';
import 'package:mindtrip/features/trips/data/models/trip_model.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

abstract class RemoteTripDataSource {
  Future<Trip> createTrip(CreateTripRequestModel request);
  Future<List<Trip>> getAllTrips();
  Future<void> updateTripStatus(String tripId, String status);
}

class RemoteTripDataSourceImpl implements RemoteTripDataSource {
  const RemoteTripDataSourceImpl(this._apiConsumer);

  final ApiConsumer _apiConsumer;

  @override
  Future<Trip> createTrip(CreateTripRequestModel request) async {
    try {
      final response = await _apiConsumer.post(
        EndPoints.trips,
        data: request.toJson(),
      );

      final responseData = response as Map<String, dynamic>;
      return TripModel.fromJson(responseData).toEntity();
    } catch (e) {
      throw ApiErrorMapper.fromException(e);
    }
  }

  @override
  Future<List<Trip>> getAllTrips() async {
    try {
      final response = await _apiConsumer.get(EndPoints.trips);
      final data = response as Map<String, dynamic>;
      final list = data['items'] as List<dynamic>? ?? [];
      return list
          .map((e) => TripModel.fromJson(e as Map<String, dynamic>).toEntity())
          .toList();
    } catch (e) {
      throw ApiErrorMapper.fromException(e);
    }
  }

  @override
  Future<void> updateTripStatus(String tripId, String status) async {
    try {
      await _apiConsumer.patch(
        '${EndPoints.trips}/$tripId/status',
        data: {'status': status},
      );
    } catch (e) {
      throw ApiErrorMapper.fromException(e);
    }
  }
}
