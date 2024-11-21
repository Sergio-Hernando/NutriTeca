import 'package:dio/dio.dart';
import 'package:nutri_teca/data/models/monthly_spent_data_entity.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'monthly_spent_api.g.dart';

@RestApi()
abstract class MonthlySpentApi {
  factory MonthlySpentApi(Dio dio, {String? baseUrl}) = _MonthlySpentApi;

  @POST(
    '/example',
  )
  Future<MonthlySpentDataEntity> createMonthlySpent({
    @Body() required MonthlySpentDataEntity monthlySpent,
  });

  @GET(
    '/example',
  )
  Future<int> deleteMonthlySpent({
    @Query('id') required String id,
  });

  @GET(
    '/example',
  )
  Future<int> deleteSpentIfNewMonth();

  @GET(
    '/example',
  )
  Future<List<MonthlySpentDataEntity>> getAllMonthlySpent();
}
