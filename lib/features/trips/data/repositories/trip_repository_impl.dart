import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/features/trips/data/datasources/trip_local_datasource.dart';
import 'package:mindtrip/features/trips/data/datasources/remote_trip_datasource.dart';
import 'package:mindtrip/features/trips/data/models/create_trip_request_model.dart';
import 'package:mindtrip/features/trips/data/models/get_trips_request_model.dart';
import 'package:mindtrip/features/trips/data/models/rename_trip_request_model.dart';
import 'package:mindtrip/features/trips/data/models/trip_review_request_model.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/domain/repositories/trip_repository.dart';
import 'package:mindtrip/features/trips/data/mapper/trip_mapper.dart';

class TripRepositoryImpl implements TripRepository {
  final TripLocalDataSource _localDataSource;
  final RemoteTripDataSource _remoteDataSource;

  const TripRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<Result<void>> saveTrip(Trip trip) async {
    try {
      final model = trip.toModel();
      await _localDataSource.save(model);
      return const Result.ok(null);
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.cancel) {
        return const Result.cancelled();
      }
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<void>> updateTrip(Trip trip) async {
    try {
      final model = trip.toModel();
      await _localDataSource.save(model);
      return const Result.ok(null);
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.cancel) {
        return const Result.cancelled();
      }
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<Trip>> createTrip(CreateTripRequestModel request) async {
    try {
      final savedTrip = await _remoteDataSource.createTrip(request);
      final model = savedTrip.toModel();
      await _localDataSource.save(model);
      return Result.ok(savedTrip);
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.cancel) {
        return const Result.cancelled();
      }
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<void>> updateTripStatus(String tripId, String status) async {
    return Result.error(
      ApiErrorMapper.fromException(Exception('Use changeTripStatus instead')),
    );
  }

  @override
  Future<Result<List<Trip>>> getTrips({
    int? status,
    CancelToken? cancelToken,
  }) async {
    try {
      final trips = await _remoteDataSource.getTrips(
        GetTripsRequestModel(status: status),
        cancelToken: cancelToken,
      );

      await _localDataSource.replaceAll(trips.map((e) => e.toModel()).toList());

      return Result.ok(trips);
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.cancel) {
        return const Result.cancelled();
      }
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<Trip>> getTripById(
    String id, {
    CancelToken? cancelToken,
  }) async {
    try {
      final trip = await _remoteDataSource.getTripById(
        id,
        cancelToken: cancelToken,
      );
      await _localDataSource.save(trip.toModel());
      return Result.ok(trip);
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.cancel) {
        return const Result.cancelled();
      }
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<void>> deleteTrip(String id, {CancelToken? cancelToken}) async {
    try {
      await _remoteDataSource.deleteTrip(id, cancelToken: cancelToken);
      await _localDataSource.delete(id);
      return const Result.ok(null);
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.cancel) {
        return const Result.cancelled();
      }
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<String>> shareTrip(
    String id, {
    CancelToken? cancelToken,
  }) async {
    try {
      final token = await _remoteDataSource.shareTrip(
        id,
        cancelToken: cancelToken,
      );
      return Result.ok(token);
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.cancel) {
        return const Result.cancelled();
      }
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<Trip>> renameTrip(
    String id,
    String title, {
    CancelToken? cancelToken,
  }) async {
    try {
      final trip = await _remoteDataSource.renameTrip(
        id,
        RenameTripRequestModel(title: title),
        cancelToken: cancelToken,
      );
      await _localDataSource.save(trip.toModel());
      return Result.ok(trip);
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.cancel) {
        return const Result.cancelled();
      }
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<Trip>> changeTripStatus(
    String id,
    int status, {
    CancelToken? cancelToken,
  }) async {
    try {
      final trip = await _remoteDataSource.updateTripStatus(
        id,
        status,
        cancelToken: cancelToken,
      );
      await _localDataSource.save(trip.toModel());
      return Result.ok(trip);
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.cancel) {
        return const Result.cancelled();
      }
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<void>> reviewTrip(
    String id,
    int rating,
    String? comment, {
    CancelToken? cancelToken,
  }) async {
    try {
      await _remoteDataSource.reviewTrip(
        id,
        TripReviewRequestModel(rating: rating, comment: comment),
        cancelToken: cancelToken,
      );
      return const Result.ok(null);
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.cancel) {
        return const Result.cancelled();
      }
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }
}
