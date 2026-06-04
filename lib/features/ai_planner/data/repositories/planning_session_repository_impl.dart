import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/features/ai_planner/data/datasources/planning_session_local_datasource.dart';
import 'package:mindtrip/features/ai_planner/data/models/planning_session_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/planning_session.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/planning_session_repository.dart';

class PlanningSessionRepositoryImpl implements PlanningSessionRepository {
  final PlanningSessionLocalDataSource _localDataSource;

  PlanningSessionRepositoryImpl(this._localDataSource);

  @override
  Future<Result<PlanningSession?>> getSession(String tripId) async {
    try {
      final model = await _localDataSource.getById(tripId);
      return Result.ok(model);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<void>> saveSession(PlanningSession session) async {
    try {
      final model = PlanningSessionModel.fromEntity(session);
      await _localDataSource.save(model);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<void>> deleteSession(String tripId) async {
    try {
      await _localDataSource.delete(tripId);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }
}
