import 'package:food_macros/data/models/recipe_remote_entity.dart';
import 'package:food_macros/domain/models/request/recipe_request_entity.dart';

abstract class RecipeDataSourceContract {
  Future<RecipeRemoteEntity?> createRecipe(RecipeRequestEntity recipe);
  Future<RecipeRemoteEntity?> getRecipe(int id);
  Future<List<RecipeRemoteEntity>> getAllRecipes();
  Future<int> updateRecipe(RecipeRequestEntity recipe);
  Future<int> deleteRecipe(int id);
}
