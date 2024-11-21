import 'package:dio/dio.dart';
import 'package:nutri_teca/data/models/additives_data_entity.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'additives_api.g.dart';

@RestApi()
abstract class AdditivesApi {
  factory AdditivesApi(Dio dio, {String? baseUrl}) = _AdditivesApi;

  @GET(
    '/example',
  )
  Future<List<AdditiveDataEntity>> getAdditives();
}
