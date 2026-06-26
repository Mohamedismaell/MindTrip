import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/features/trips/data/models/trip_model.dart';

class TripLocalDataSource {
  final Box<Map> _tripsBox;

  const TripLocalDataSource(this._tripsBox);

  Future<List<TripModel>> getAll() async {
    return _tripsBox.values
        .map((e) => TripModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<TripModel?> getById(String id) async {
    final json = _tripsBox.get(id);

    if (json == null) return null;

    return TripModel.fromJson(Map<String, dynamic>.from(json));
  }

  Future<void> save(TripModel trip) async {
    final json = trip.toJson();

    print('================ STORAGE JSON ================');
    print(json.toString());

    json.forEach((key, value) {
      print('$key -> ${value.runtimeType}');
    });

    final plan = json['plan'];
    if (plan is Map) {
      print('------------ PLAN ------------');
      plan.forEach((key, value) {
        print('$key -> ${value.runtimeType}');
      });
    }

    await _tripsBox.put(trip.tripId, json);
  }

  Future<void> delete(String id) async {
    await _tripsBox.delete(id);
  }
}
