import 'package:mindtrip/features/ai_planner/data/datasources/trip_local_datasource.dart';
import 'package:mindtrip/features/ai_planner/data/models/trip_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/trip_repository.dart';

class TripRepositoryImpl implements TripRepository {
  final TripLocalDataSource _localDataSource;

  const TripRepositoryImpl(this._localDataSource);

  @override
  Future<List<Trip>> getAllTrips() async {
    final models = await _localDataSource.getAll();
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<Trip?> getTripById(String id) async {
    final model = await _localDataSource.getById(id);
    return model?.toEntity();
  }

  //! why save as model ?
  @override
  Future<void> saveTrip(Trip trip) async {
    final model = TripModel.fromEntity(trip);
    await _localDataSource.save(model);
  }

  @override
  Future<void> updateTrip(Trip trip) async {
    final model = TripModel.fromEntity(trip);
    await _localDataSource.save(model);
  }

  @override
  Future<void> deleteTrip(String id) async {
    await _localDataSource.delete(id);
  }
}
