import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/features/trips/data/models/trip_model.dart';

class TripLocalDataSource {
  final Box<TripModel> _tripsBox;

  const TripLocalDataSource(this._tripsBox);

  Future<List<TripModel>> getAll() async {
    return _tripsBox.values.toList();
  }

  Future<TripModel?> getById(String id) async {
    return _tripsBox.get(id);
  }

  Future<void> save(TripModel trip) async {
    await _tripsBox.put(trip.id, trip);
  }

  Future<void> delete(String id) async {
    await _tripsBox.delete(id);
  }
}
