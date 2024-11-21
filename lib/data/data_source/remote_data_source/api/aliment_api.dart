import 'package:dio/dio.dart';
import 'package:nutri_teca/data/models/aliment_data_entity.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'aliment_api.g.dart';

@RestApi()
abstract class AlimentApi {
  factory AlimentApi(Dio dio, {String? baseUrl}) = _AlimentApi;

  @POST(
    '/example',
  )
  Future<AlimentDataEntity> createAliment({
    @Body() required AlimentDataEntity aliment,
  });

  @GET(
    '/example',
  )
  Future<int> deleteAliment({
    @Query('id') required String id,
  });

  @GET(
    '/example',
  )
  Future<AlimentDataEntity> getAliment({
    @Query('id') required String id,
  });

  @GET(
    '/example',
  )
  Future<List<AlimentDataEntity>> getAllAliments();

  @PUT(
    '/example',
  )
  Future<AlimentDataEntity> updateAliment({
    @Body() required AlimentDataEntity aliment,
  });
}
