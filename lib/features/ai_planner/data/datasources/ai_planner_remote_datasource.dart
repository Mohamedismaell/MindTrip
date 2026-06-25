import 'package:dio/dio.dart';
import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import 'package:mindtrip/core/database/api/dio_consumer.dart';
import 'package:mindtrip/core/database/api/end_points.dart';
import 'package:mindtrip/features/ai_planner/data/models/generate_plan_request_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/generated_plan_model.dart';

abstract class AiPlannerRemoteDataSource {
  Future<GeneratedPlanModel> generate({
    required GeneratePlanRequestModel request,
    CancelToken? cancelToken,
  });
}

class AiPlannerRemoteDataSourceImp implements AiPlannerRemoteDataSource {
  final ApiConsumer _apiConsumer;

  AiPlannerRemoteDataSourceImp({required ApiConsumer apiConsumer})
    : _apiConsumer = apiConsumer;

  @override
  Future<GeneratedPlanModel> generate({
    required GeneratePlanRequestModel request,
    CancelToken? cancelToken,
  }) async {
    try {
      final requestData = request.toJson();

      if (_apiConsumer is DioConsumer) {
        final dioConsumer = _apiConsumer;
        final response = await dioConsumer.post(
          EndPoints.generatePlan,
          data: requestData,
          cancelToken: cancelToken,
          options: Options(
            receiveTimeout: const Duration(seconds: 120),
            sendTimeout: const Duration(seconds: 120),
          ),
        );
        return GeneratedPlanModel.fromJson(response as Map<String, dynamic>);
      } else {
        final response = await _apiConsumer.post(
          EndPoints.generatePlan,
          data: requestData,
          cancelToken: cancelToken,
        );
        return GeneratedPlanModel.fromJson(response as Map<String, dynamic>);
      }
    } catch (e) {
      throw ApiErrorMapper.fromException(e);
    }
  }
}
