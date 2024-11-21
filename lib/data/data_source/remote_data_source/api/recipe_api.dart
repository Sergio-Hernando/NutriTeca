import 'package:dio/dio.dart';
import 'package:nutri_teca/data/models/recipe_data_entity.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'recipe_api.g.dart';

@RestApi()
abstract class RecipeApi {
  factory RecipeApi(Dio dio, {String? baseUrl}) = _RecipeApi;

  @POST(
    '/example',
  )
  Future<RecipeDataEntity> createRecipe({
    @Body() required RecipeDataEntity recipe,
  });

  @GET(
    '/example',
  )
  Future<int> deleteRecipe({
    @Query('id') required String id,
  });

  @GET(
    '/example',
  )
  Future<RecipeDataEntity> getRecipe({
    @Query('id') required String id,
  });

  @GET(
    '/example',
  )
  Future<List<RecipeDataEntity>> getRecipeByAlimentId({
    @Query('id') required String alimentId,
  });

  @GET(
    '/example',
  )
  Future<List<RecipeDataEntity>> getAllRecipes();

  @PUT(
    '/example',
  )
  Future<RecipeDataEntity> updateRecipe({
    @Body() required RecipeDataEntity recipe,
  });
}
