import 'package:dio/dio.dart';
import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/core/database/api/end_points.dart';
import 'package:mindtrip/features/trips/data/mapper/trip_mapper.dart';
import 'package:mindtrip/features/trips/data/models/create_trip_request_model.dart';
import 'package:mindtrip/features/trips/data/models/get_trips_request_model.dart';
import 'package:mindtrip/features/trips/data/models/rename_trip_request_model.dart';
import 'package:mindtrip/features/trips/data/models/trip_model.dart';
import 'package:mindtrip/features/trips/data/models/trip_review_request_model.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

abstract class RemoteTripDataSource {
  Future<Trip> createTrip(
    CreateTripRequestModel request, {
    CancelToken? cancelToken,
  });
  Future<List<Trip>> getTrips(
    GetTripsRequestModel request, {
    CancelToken? cancelToken,
  });
  Future<Trip> getTripById(String id, {CancelToken? cancelToken});
  Future<void> deleteTrip(String id, {CancelToken? cancelToken});
  Future<String> shareTrip(String id, {CancelToken? cancelToken});
  Future<Trip> renameTrip(
    String id,
    RenameTripRequestModel request, {
    CancelToken? cancelToken,
  });
  Future<Trip> updateTripStatus(
    String tripId,
    int status, {
    CancelToken? cancelToken,
  });
  Future<void> reviewTrip(
    String id,
    TripReviewRequestModel request, {
    CancelToken? cancelToken,
  });
}

class RemoteTripDataSourceImpl implements RemoteTripDataSource {
  const RemoteTripDataSourceImpl(this._apiConsumer);

  final ApiConsumer _apiConsumer;

  @override
  Future<Trip> createTrip(
    CreateTripRequestModel request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _apiConsumer.post(
        EndPoints.trips,
        data: request.toJson(),
        cancelToken: cancelToken,
      );

      return TripModel.fromJson(response as Map<String, dynamic>).toEntity();
    } catch (e) {
      throw ApiErrorMapper.fromException(e);
    }
  }

  @override
  Future<List<Trip>> getTrips(
    GetTripsRequestModel request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _apiConsumer.get(
        EndPoints.trips,
        queryParameters: request.toJson(),
        cancelToken: cancelToken,
      );

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
  Future<Trip> getTripById(String id, {CancelToken? cancelToken}) async {
    try {
      final response = await _apiConsumer.get(
        EndPoints.tripById(id),
        cancelToken: cancelToken,
      );

      return TripModel.fromJson(response as Map<String, dynamic>).toEntity();
    } catch (e) {
      throw ApiErrorMapper.fromException(e);
    }
  }

  @override
  Future<void> deleteTrip(String id, {CancelToken? cancelToken}) async {
    try {
      await _apiConsumer.delete(
        EndPoints.tripById(id),
        cancelToken: cancelToken,
      );
    } catch (e) {
      throw ApiErrorMapper.fromException(e);
    }
  }

  @override
  Future<String> shareTrip(String id, {CancelToken? cancelToken}) async {
    try {
      final response = await _apiConsumer.post(
        EndPoints.tripShare(id),
        cancelToken: cancelToken,
      );

      final data = response as Map<String, dynamic>;
      return data['shareToken'] as String;
    } catch (e) {
      throw ApiErrorMapper.fromException(e);
    }
  }

  @override
  Future<Trip> renameTrip(
    String id,
    RenameTripRequestModel request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _apiConsumer.patch(
        EndPoints.tripRename(id),
        data: request.toJson(),
        cancelToken: cancelToken,
      );

      return TripModel.fromJson(response as Map<String, dynamic>).toEntity();
    } catch (e) {
      throw ApiErrorMapper.fromException(e);
    }
  }

  @override
  Future<Trip> updateTripStatus(
    String tripId,
    int status, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _apiConsumer.patch(
        EndPoints.tripStatus(tripId),
        queryParameters: {'status': status},
        cancelToken: cancelToken,
      );

      return TripModel.fromJson(response as Map<String, dynamic>).toEntity();
    } catch (e) {
      throw ApiErrorMapper.fromException(e);
    }
  }

  @override
  Future<void> reviewTrip(
    String id,
    TripReviewRequestModel request, {
    CancelToken? cancelToken,
  }) async {
    try {
      await _apiConsumer.post(
        EndPoints.tripReview(id),
        data: request.toJson(),
        cancelToken: cancelToken,
      );
    } catch (e) {
      throw ApiErrorMapper.fromException(e);
    }
  }
}
