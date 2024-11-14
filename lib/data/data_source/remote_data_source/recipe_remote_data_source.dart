import 'package:nutri_teca/data/data_source/remote_data_source/api/recipe_api.dart';
import 'package:nutri_teca/data/data_source_contracts/recipe_data_source_contract.dart';
import 'package:nutri_teca/data/models/recipe_data_entity.dart';

class RecipeRemoteDataSource implements RecipeDataSourceContract {
  final RecipeApi _api;

  RecipeRemoteDataSource(this._api);

  @override
  Future<RecipeDataEntity?> createRecipe(RecipeDataEntity recipe) async =>
      await _api.createRecipe(recipe: recipe);

  @override
  Future<int> deleteRecipe(int id) async =>
      await _api.deleteRecipe(id: id.toString());

  @override
  Future<RecipeDataEntity> getRecipe(int id) async =>
      await _api.getRecipe(id: id.toString());

  @override
  Future<List<RecipeDataEntity>> getAllRecipes() async =>
      await _api.getAllRecipes();

  @override
  Future<RecipeDataEntity?> updateRecipe(RecipeDataEntity recipe) async =>
      await _api.updateRecipe(recipe: recipe);

  @override
  Future<List<RecipeDataEntity>> getRecipesByAlimentId(int alimentId) async =>
      await _api.getRecipeByAlimentId(alimentId: alimentId.toString());
}
